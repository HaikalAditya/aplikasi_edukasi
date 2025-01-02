import 'package:flutter/material.dart';

class ScrambleLevel extends StatefulWidget {
  final String currentImage;
  final String correctAnswer;
  final List<String> options;
  final Function(String) onAnswer;

  const ScrambleLevel({
    super.key,
    required this.currentImage,
    required this.correctAnswer,
    required this.options,
    required this.onAnswer,
  });

  @override
  State<ScrambleLevel> createState() => _ScrambleLevelState();
}

class _ScrambleLevelState extends State<ScrambleLevel> {
  List<String> currentAnswer = [];

  void _handleLetterTap(String letter) {
    if (currentAnswer.length < widget.correctAnswer.length) {
      setState(() {
        currentAnswer.add(letter);
        if (currentAnswer.length == widget.correctAnswer.length) {
          widget.onAnswer(currentAnswer.join());
          currentAnswer.clear();
        }
      });
    }
  }

  Widget _buildScrambleTile(String letter) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          letter,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Menyusun Nama Hewan :',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        Image.asset(
          widget.currentImage,
          height: 100,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.correctAnswer.length,
            (index) => Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 0, 102, 255)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  currentAnswer.length > index ? currentAnswer[index] : '',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: widget.options
              .map((letter) => GestureDetector(
                    onTap: () => _handleLetterTap(letter),
                    child: _buildScrambleTile(letter),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
