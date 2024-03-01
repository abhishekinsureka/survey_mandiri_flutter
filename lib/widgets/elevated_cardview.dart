import 'package:flutter/material.dart';

class ElevatedCardView extends StatelessWidget {
  const ElevatedCardView({super.key, required this.bottomMargin});

  final double bottomMargin;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 0, 16, bottomMargin),
      surfaceTintColor: Colors.white,
      // Set the background color to white
      elevation: 4.0,
      // Add elevation for a shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Left side (Text)
           const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Underwritten by',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'PT Asuransi Rama Satria Wibawa',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            // Right side (Image)
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Image.asset(
                'assets/images/rama-logo.png',
                width: 120,
                height: 48,
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
