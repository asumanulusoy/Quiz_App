import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quiz_app/screens/intro_screen.dart';
import '../models/question.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questions;

  const QuizScreen({super.key, required this.questions});

  @override
  // ignore: library_private_types_in_public_api
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  final Map<int, bool> _selectedAnswers = {};
  int _correctAnswersCount = 0;
  final int _correctAnswerThreshold = 2;

  void _handleAnswer(int index, bool isCorrect) {
    if (_selectedAnswers.containsKey(index)) return;

    setState(() {
      _selectedAnswers[index] = true;
    });

    if (isCorrect) {
      _correctAnswersCount++;
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Tebrikler, doğru cevap verdiniz!',
        confirmBtnText: 'Tamam',
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
        },
      );

      if (_correctAnswersCount >= _correctAnswerThreshold) {
        Future.delayed(const Duration(seconds: 1), () {
          _moveToNextQuestion();
        });
      }
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Üzgünüm, bu cevap yanlış. Haydi tekrar dene!',
        confirmBtnText: 'Tamam',
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  void _moveToNextQuestion() {
    setState(() {
      if (_currentQuestionIndex < widget.questions.length - 1) {
        _currentQuestionIndex++;
        _selectedAnswers.clear();
        _correctAnswersCount = 0;
      } else {
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    Get.defaultDialog(
      title: 'Quiz Tamamlandı!',
      titleStyle: GoogleFonts.acme(
        textStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.teal[800],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              Get.offAll(
                  () => const IntroScreen()); // Başlangıç ekranına yönlendirme
            },
            // ignore: sort_child_properties_last
            child: Text(
              'Başlangıç Ekranına Dön',
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal, // Buton rengi
              foregroundColor: Colors.white, // Buton yazı rengi
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 5,
            ),
          ),
        ],
      ),
      barrierDismissible: false, // Dışarı tıklanarak kapanmasını engeller
      backgroundColor: Colors.white, // Arka plan rengi
      radius: 16, // Köşe yuvarlaklığı
      titlePadding: const EdgeInsets.all(20), // Başlık etrafında boşluk
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 10), // İçerik etrafında boşluk
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentQuestionIndex];
    final List<String> answers = question.answers;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Get.offAll(
                  () => const IntroScreen()); // Başlangıç ekranına yönlendirme
            },
          ),
        ],
        automaticallyImplyLeading:
            false, // Sol taraftaki geri butonunu kaldırır
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 80), // AppBar'ın altında boşluk bırakır
            Text(
              question.questionText,
              style: GoogleFonts.kreon(
                textStyle: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontFamily: 'Arial',
                ),
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                itemCount: answers.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedAnswers.containsKey(index);
                  final isCorrect = widget
                      .questions[_currentQuestionIndex].correctAnswerIndices
                      .contains(index);

                  return GestureDetector(
                    onTap: () {
                      if (!isSelected) {
                        _handleAnswer(index, isCorrect);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? isCorrect
                                  ? Colors.teal
                                  : Colors.redAccent
                              : Colors.grey,
                          width: 4,
                        ),
                      ),
                      child: GridTile(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            answers[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
