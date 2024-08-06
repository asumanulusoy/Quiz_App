class Question {
  final String questionText;
  final List<String> answers;
  final List<int> correctAnswerIndices;

  Question({
    required this.questionText,
    required this.answers,
    required this.correctAnswerIndices,
  });
}
