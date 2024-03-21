import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:survey_mandiri/data/document_list_response.dart';
import 'package:survey_mandiri/model/document_list_ui_model.dart';
import 'package:survey_mandiri/network/api_service.dart';
import 'package:survey_mandiri/network/upload_complete_request.dart';
import 'package:survey_mandiri/screen/video_preview.dart';
import 'package:survey_mandiri/widgets/elevated_cardview.dart';
import 'package:survey_mandiri/widgets/cardview_document_details.dart';
import 'package:survey_mandiri/widgets/document_cardview_item.dart';
import 'package:camera/camera.dart';
import 'package:survey_mandiri/screen/take_picture.dart';
import 'package:survey_mandiri/screen/record_video.dart';
import 'package:survey_mandiri/screen/image_preview.dart';
import 'package:dio/dio.dart';
import 'package:survey_mandiri/data/upload_complete_request.dart';
import 'dart:io';


class UploadDocument extends StatefulWidget {
  const UploadDocument({super.key, required this.uploadId});

  final String uploadId;

  @override
  State<UploadDocument> createState() {
    return _UploadDocument();
  }
}

class _UploadDocument extends State<UploadDocument> {
  final List<DocumentsUiModel> _documentUiModel = [];
  String uploadProgress = '0.0';
  bool _canShowButton = true;
  late ProgressDialog pr =pr = ProgressDialog(
      context,
      type: ProgressDialogType.normal,
      isDismissible: false,
      /// your body here
      customBody:const LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(239, 54, 125, 0.8)),
        backgroundColor: Colors.white,
      ),
    );

  @override
  void initState() {
    super.initState();
    _fetchDocuments();
  }

  void _fetchDocuments() async {
    await pr.show();
    final documents = (await ApiService().fetchDocuments(widget.uploadId));
    Future.delayed(const Duration(seconds: 0)).then(
      (value) => setState(
        () {
          pr.hide();
          if (documents?.result.documents != null) {
            for (var document in documents?.result.documents ?? <Document>[]) {
              _documentUiModel.add(
                DocumentsUiModel(
                    name: document.name,
                    type: document.type,
                    cameraOnly: document.cameraOnly,
                    baseUrl: document.baseUrl,
                    relativeUrl: document.relativeUrl,
                    signedUrl: document.signedUrl),
              );
            }
          }else{
            FocusManager.instance.primaryFocus?.unfocus();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
     content: Text("Upload already completed or not allowed. Please contact customer support"),
));
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  void _uploadComplete() async {
     await pr.show();
List<UploadComplete> documents = [];

for (var i = 0; i < _documentUiModel.length; i++) {
documents.add(UploadComplete(baseUrl: _documentUiModel[i].baseUrl ?? '', 
name: _documentUiModel[i].name ?? '', 
relativeUrl: _documentUiModel[i].relativeUrl ?? ''));
}

  DocumentsRequestBody requestBody = DocumentsRequestBody(documents: documents);

    final uploadComplete = (await ApiService().uploadComplete(widget.uploadId, requestBody));
    Future.delayed(const Duration(seconds: 0)).then(
      (value) => setState(
        () {
          pr.hide();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
     content: Text("All Documents uploaded successfully"),
),);
        }),);
       if (context.mounted) Navigator.of(context).pop();
  }

  void _uploadFileToServer(
      String filePath, String baseUrl, int position) async {
    final dio = Dio();
    uploadProgress == '0.0';
    Response responseGoogleStorage = await dio.put(
      baseUrl,
      data: File(filePath).readAsBytesSync(),
      options: Options(
        headers: {
          'Content-Type': 'application/octet-stream',
          'Accept': "*/*",
          'Content-Length': File(filePath).lengthSync().toString(),
          'Connection': 'keep-alive',
        },
      ),
      onSendProgress: (count, total) =>
          uploadProgress = '${(count / total) * 100}',
    );

    setState(() {
      _documentUiModel[position].uploadPercentage = uploadProgress;
    });

    if (responseGoogleStorage.statusCode == 200) {
      setState(
        () {
          _documentUiModel[position].isUploaded = true;
          _documentUiModel[position].isUploading = false;
          checkIfAllFilesAreUploaded();
        },
      );
    } else {
      setState(
        () {
          _canShowButton = true;
          _documentUiModel[position].isUploadFailed = true;
          _documentUiModel[position].isUploading = false;
          checkIfAllFilesAreUploaded();
        },
      );
    }
  }

  void checkIfAllFilesAreUploaded(){
    var numberOfFilesUploaded = 0;

    for (var i = 0; i < _documentUiModel.length; i++) {
     if(_documentUiModel[i].isUploaded == true){
      numberOfFilesUploaded ++;
     }
    }
    print("Number of file uploaded is $numberOfFilesUploaded");
    print("Total number of docs is ${_documentUiModel.length}");

    if(numberOfFilesUploaded == _documentUiModel.length){
       _uploadComplete();
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Survey Mandiri",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: const Color.fromRGBO(239, 54, 125, 0.8),
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Color.fromRGBO(228, 39, 112, 0.8),
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const ScrollPhysics(),
              children: [
                const SizedBox(height: 24),
                const ElevatedCardView(bottomMargin: 24),
                const CardviewDocumentDetails(),
                FutureBuilder(
                  future: Future(() => _documentUiModel),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _documentUiModel.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                if (_documentUiModel[index].type == "image") {
                                  if (_documentUiModel[index]
                                          .takenPicturePath !=
                                      null) {
                                    var picPath = _documentUiModel[index]
                                        .takenPicturePath;
                                    final imagePreviewResult =
                                        await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ImagePreview(
                                          imagePath: picPath ?? '',
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      if (imagePreviewResult == 'delete') {
                                        _documentUiModel[index]
                                            .takenPicturePath = null;
                                      }
                                    });
                                  } else {
                                    final pictureResult =
                                        await availableCameras().then(
                                      (value) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              CameraPage(cameras: value),
                                        ),
                                      ),
                                    );
                                    setState(
                                      () {
                                        _documentUiModel[index]
                                            .takenPicturePath = pictureResult;
                                      },
                                    );
                                  }
                                } else {
                                  if (_documentUiModel[index].takenVideoPath !=
                                      null) {
                                    final videoPreviewResult =
                                        await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => VideoPreview(
                                            filePath: _documentUiModel[index]
                                                    .takenVideoPath ??
                                                ''),
                                      ),
                                    );
                                    setState(() {
                                      if (videoPreviewResult == 'delete') {
                                        _documentUiModel[index].takenVideoPath =
                                            null;
                                      }
                                    });
                                  } else {
                                    final videoResult =
                                        await availableCameras().then(
                                      (value) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              RecordVideo(cameras: value),
                                        ),
                                      ),
                                    );
                                    setState(
                                      () {
                                        _documentUiModel[index].takenVideoPath =
                                            videoResult;
                                      },
                                    );
                                  }
                                }
                              },
                              child: DocumentCardViewItem(
                                item: _documentUiModel[index],
                                progressPercentage: double.parse(
                                    _documentUiModel[index].uploadPercentage ??
                                        '0.0'),
                              ),
                            );
                          },
                        );
                      
                    } else {
                      // Show loader indicator
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Visibility(
              visible: _canShowButton,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(239, 54, 125, 0.8),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(color: Colors.white, fontSize: 14),
                  fixedSize: const Size(300, 34),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                ),
                onPressed: () {
                  for (var i = 0; i < _documentUiModel.length; i++) {
                    setState(() {
                      _canShowButton = false;
                      _documentUiModel[i].isUploading = true;
                    });
                    
                    if (_documentUiModel[i].takenPicturePath != null) {
                      _uploadFileToServer(
                          _documentUiModel[i].takenPicturePath ?? '',
                          _documentUiModel[i].signedUrl ?? '',
                          i);
                    } else if (_documentUiModel[i].takenVideoPath != null) {
                      _uploadFileToServer(
                          _documentUiModel[i].takenVideoPath ?? '',
                          _documentUiModel[i].signedUrl ?? '',
                          i);
                    }
                  }
                },
                child: const Text('Upload'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
