import 'package:flutter/material.dart';

class TextLevel extends StatelessWidget {
  final String currentImage;
  final List<String> options;
  final Function(String) onAnswer;

  const TextLevel({
    super.key,
    required this.currentImage,
    required this.options,
    required this.onAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            currentImage,
            height: 250,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: options.map((option) {
              return GestureDetector(
                onTap: () => onAnswer(option),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    option,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
