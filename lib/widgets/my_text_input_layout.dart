import 'package:flutter/material.dart';
import 'package:survey_mandiri/screen/document_screen.dart';

class MyTextInputLayout extends StatefulWidget {
  const MyTextInputLayout({super.key});

  @override
  State<MyTextInputLayout> createState() {
    return _MyTextInputLayout();
  }
}

class _MyTextInputLayout extends State<MyTextInputLayout> {
  final _quoteNumberController = TextEditingController();

  @override
  void dispose() {
    _quoteNumberController.dispose();
    super.dispose();
  }

  void _continueClicked() {
    if (_quoteNumberController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Alert!"),
          content: const Text('Please enter upload id to proceed'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'Okay',
                style: TextStyle(
                    fontSize: 14, color: Color.fromRGBO(239, 54, 125, 0.8)),
              ),
            )
          ],
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            UploadDocument(uploadId: _quoteNumberController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 16, left: 16),
          child: TextField(
            cursorColor: Colors.black,
            controller: _quoteNumberController,
            maxLines: 1,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter upload id',
              helperText: '*Required',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.black),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        // Continue Button
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.only(right: 16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(239, 54, 125, 0.8),
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6), // <-- Radius
              ),
            ),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              _continueClicked();
            },
            child: const Text(
              'Continue',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
