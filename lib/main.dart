import 'package:flutter/material.dart';
import 'package:get/get.dart'; // GetX için import
import 'screens/intro_screen.dart'; // `IntroScreen`'i ekleyin
import 'models/question.dart';
import 'utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kPrimaryColor,
          secondary: kSecondaryColor,
        ),
      ),
      home: const IntroScreen(), // `IntroScreen` olarak değiştirildi
    );
  }
}

final List<Question> questions = [
  Question(
    questionText: 'A harfi ile başlayan görselleri seçiniz!',
    answers: [
      'assets/images/araba.webp', // Doğru
      'assets/images/armut.jpg', // Doğru
      'assets/images/eldiven.webp', // Yanlış
      'assets/images/balon.webp', // Yanlış
    ],
    correctAnswerIndices: [0, 1],
  ),
  Question(
    questionText: 'B harfi ile başlayan görselleri seçiniz!',
    answers: [
      'assets/images/balon.webp', // Doğru
      'assets/images/bisiklet.jpg', // Doğru
      'assets/images/araba.webp', // Yanlış
      'assets/images/elma.webp', // Yanlış
    ],
    correctAnswerIndices: [0, 1],
  ),
  Question(
    questionText: 'E harfi ile başlayan görselleri seçiniz!',
    answers: [
      'assets/images/elma.webp', // Doğru
      'assets/images/eldiven.webp', // Doğru
      'assets/images/balon.webp', // Yanlış
      'assets/images/kedi.png', // Yanlış
    ],
    correctAnswerIndices: [0, 1],
  ),
];
