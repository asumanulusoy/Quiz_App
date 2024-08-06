import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AnswerBox extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;
  final bool isSelected;
  final bool isCorrect;

  const AnswerBox({
    super.key,
    required this.imagePath,
    required this.onTap,
    required this.isSelected,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(10.0),
          color: isSelected
              ? (isCorrect ? kCorrectAnswerColor : kWrongAnswerColor)
              : kSecondaryColor,
        ),
        child: Image.asset(imagePath),
      ),
    );
  }
}
