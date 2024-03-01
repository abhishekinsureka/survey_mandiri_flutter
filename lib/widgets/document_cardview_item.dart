import 'package:flutter/material.dart';
import 'package:survey_mandiri/model/document_list_ui_model.dart';
import 'dart:io';
import 'package:survey_mandiri/widgets/linear_upload_progress.dart';

class DocumentCardViewItem extends StatefulWidget {
  DocumentCardViewItem(
      {required this.item, required this.progressPercentage, super.key});

  final DocumentsUiModel item;
  double progressPercentage = 0.0;

  @override
  State<DocumentCardViewItem> createState() {
    return _DocumentCardViewItem();
  }
}

class _DocumentCardViewItem extends State<DocumentCardViewItem> {
  String _setDocumentDescriptions(String? documentName, String? type) {
    String name = '';
    if (documentName == "existing_policy") {
      name = 'Existing Policy';
    } else {
      name = documentName?.toUpperCase() ?? '';
    }

    if (type == "IMAGE") {
      if (documentName == "BASTK") {
        name = 'Select and upload your BASTK';
      } else {
        name = 'Select and upload your $name pictures';
      }
    } else {
      name = 'Take $name video';
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          children: [
            Container(
              width: 60.0,
              height: 60.0,
              child: widget.item.takenPicturePath != null
                  ? Image.file(
                      File(widget.item.takenPicturePath as String),
                    )
                  : widget.item.takenVideoPath != null
                      ? Image.asset('assets/images/play_button.png',
                          fit: BoxFit.cover, width: 60, height: 60)
                      : Image.asset(
                          'assets/images/image-gallery.png',
                          fit: BoxFit.cover,
                        ),
            ),
            const SizedBox(width: 16.0), // Add some spacing
            // Right side - Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name?.toUpperCase() ?? '',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    _setDocumentDescriptions(widget.item.name?.toUpperCase(),
                        widget.item.type?.toUpperCase()),
                    style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                  const SizedBox(height: 60),
                  LinearUploadProgress(
                      progressPercentage: widget.progressPercentage)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
