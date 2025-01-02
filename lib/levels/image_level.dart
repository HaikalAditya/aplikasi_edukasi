import 'package:flutter/material.dart';

class ImageLevel extends StatelessWidget {
  final String currentImage;
  final List<String> options;
  final Function(String) onAnswer;

  const ImageLevel({
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
            height: 200,
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
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/$option.jpg'),
                      fit: BoxFit.cover,
                    ),
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
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
