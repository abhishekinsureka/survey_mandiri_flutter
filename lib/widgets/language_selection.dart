import 'package:flutter/material.dart';
import 'package:survey_mandiri/widgets/radio_group.dart';

class LanguageSelection extends StatefulWidget {
  const LanguageSelection({super.key});

  @override
  State<LanguageSelection> createState() {
    return _LanguageSelectionState();
  }
}

class _LanguageSelectionState extends State<LanguageSelection> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.only(top: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text at the top
            Container(
              margin: const EdgeInsets.only(left: 16),
              child:const Text(
                'Select Your Language',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(18, 18, 18, 0.8),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            // Radio buttons at the bottom
            const RadioGroup(),
          ],
        ));
  }
}
