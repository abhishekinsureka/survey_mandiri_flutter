import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey_mandiri/widgets/elevated_cardview.dart';
import 'package:survey_mandiri/widgets/language_selection.dart';
import 'package:survey_mandiri/widgets/my_text_input_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Survey Mandiri", // Localise This 
          style: TextStyle(color: Colors.white, fontSize: 16),
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
      body:const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            ElevatedCardView(bottomMargin: 100),
            MyTextInputLayout(),
            LanguageSelection()
          ],
        ),
      ),
    );
  }
}
