import 'package:flutter/material.dart';

enum LanguageSelection { english, bahasa }

class RadioGroup extends StatefulWidget {
  const RadioGroup({super.key});

  @override
  State<RadioGroup> createState() {
    return _RadioGroup();
  }
}

class _RadioGroup extends State<RadioGroup> {
  LanguageSelection _character = LanguageSelection.english;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text(
            'English',
            style: TextStyle(color: Color.fromRGBO(18, 18, 18, 0.8)),
          ),
          leading: Radio<LanguageSelection>(
            activeColor: const Color.fromRGBO(239, 54, 125, 0.8),
            value: LanguageSelection.english,
            groupValue: _character,
            onChanged: (LanguageSelection? value) {
              setState(() {
                _character = value!;
              });
            },
          ),
        ),
        ListTile(
          title:const Text(
            'Bahasa',
            style: TextStyle(
              color: Color.fromRGBO(18, 18, 18, 0.8),
            ),
          ),
          leading: Radio<LanguageSelection>(
            activeColor: const Color.fromRGBO(239, 54, 125, 0.8),
            value: LanguageSelection.bahasa,
            groupValue: _character,
            onChanged: (LanguageSelection? value) {
              setState(() {
                _character = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}
