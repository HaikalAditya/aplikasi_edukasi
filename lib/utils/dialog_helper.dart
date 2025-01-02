import 'package:flutter/material.dart';

class DialogHelper {
  static void showResultDialog(
    BuildContext context,
    bool isCorrect,
    int currentLevel,
    VoidCallback onContinue,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isCorrect ? 'Benar! 🎉' : 'Salah! 😞'),
          content: Text(
            isCorrect
                ? 'Selamat! Anda naik ke level $currentLevel.'
                : 'Coba lagi!',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onContinue();
              },
              child: const Text('Lanjut'),
            ),
          ],
        );
      },
    );
  }
}
