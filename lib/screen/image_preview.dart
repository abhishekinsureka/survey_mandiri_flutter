import 'package:flutter/material.dart';
import 'dart:io';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Navigator.pop(context, "delete");
              const snackBar = SnackBar(
                content: Text('Image deleted successfully'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          )
        ],
      ),
      body: Center(
        child: Image.file(
          File(imagePath),
        ),
      ),
    );
  }
}
