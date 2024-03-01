import 'package:flutter/material.dart';

class LinearUploadProgress extends StatefulWidget {
  const LinearUploadProgress({super.key, required this.progressPercentage});
  final double progressPercentage;
  @override
  State<LinearUploadProgress> createState() {
    return _LinearUploadProgress();
  }
}

class _LinearUploadProgress extends State<LinearUploadProgress> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LinearProgressIndicator(
          value: widget.progressPercentage,
          backgroundColor: Colors.grey,
          valueColor: const AlwaysStoppedAnimation<Color>(
              Color.fromRGBO(239, 54, 125, 0.8)),
        ),
        const SizedBox(height: 10),
        // Text(
        //   '${(widget.progressPercentage * 100).toStringAsFixed(2)}%',
        //   style: const TextStyle(fontSize: 20),
        // ),
      ],
    );
  }
}
