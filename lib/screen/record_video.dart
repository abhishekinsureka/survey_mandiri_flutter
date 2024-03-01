import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class RecordVideo extends StatefulWidget {
  const RecordVideo({super.key, required this.cameras});
  final List<CameraDescription>? cameras;

  @override
  State<RecordVideo> createState() {
    return _RecordVideo();
  }
}

class _RecordVideo extends State<RecordVideo> {
  bool isLoading = true;
  bool _isRecording = false;
  late CameraController _cameraController;

  @override
  void initState() {
    initCamera(widget.cameras![0]);
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(
        () {
          _isRecording = false;
          Navigator.pop(context, file.path);
        },
      );
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CameraPreview(_cameraController),
            Padding(
              padding: const EdgeInsets.all(25),
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                child: Icon(_isRecording ? Icons.stop : Icons.circle),
                onPressed: () => _recordVideo(),
              ),
            ),
          ],
        ),
      );
    }
  }
}
