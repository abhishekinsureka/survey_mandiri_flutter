import 'package:survey_mandiri/data/upload_complete_request.dart';

class DocumentsRequestBody {
  final List<UploadComplete> documents;

  DocumentsRequestBody({required this.documents});

  Map<String, dynamic> toJson() {
    return {
      'documents': documents.map((doc) => doc.toJson()).toList(),
    };
  }
}