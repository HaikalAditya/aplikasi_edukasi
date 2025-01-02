import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../levels/image_level.dart';
import '../levels/audio_level.dart';
import '../levels/scramble_level.dart';
import '../levels/text_level.dart';
import '../levels/english_level.dart';
import '../utils/dialog_helper.dart';

class BermainPage extends StatefulWidget {
  const BermainPage({super.key});

  @override
  State<BermainPage> createState() => _BermainPageState();
}

class _BermainPageState extends State<BermainPage> {
  final GameState gameState = GameState();

  @override
  void initState() {
    super.initState();
    gameState.initGame();
    _generateLevel();
  }

  @override
  void dispose() {
    gameState.dispose();
    super.dispose();
  }

  void _generateLevel() {
    switch (gameState.currentLevel) {
      case 1:
        gameState.generateImageLevel();
      case 2:
        gameState.generateAudioLevel();
      case 3:
        gameState.generateScrambleLevel();
      case 4:
        gameState.generateTextLevel();
      case 5:
        gameState.generateEnglishLevel();
      default:
        gameState.generateImageLevel();
    }
    setState(() {});
  }

  void _handleAnswer(String answer) {
    final isCorrect = gameState.checkAnswer(answer);
    if (isCorrect) {
      setState(() {
        gameState.incrementScore();
        gameState.nextLevel();
        _generateLevel();
      });
    }
    DialogHelper.showResultDialog(
      context,
      isCorrect,
      gameState.currentLevel,
      () {
        if (isCorrect) _generateLevel();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildCurrentLevel(),
                ),
                const SizedBox(height: 20),
                Text(
                  'Score: ${gameState.score}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentLevel() {
    switch (gameState.currentLevel) {
      case 1:
        return ImageLevel(
          currentImage: gameState.currentImage!,
          options: gameState.options,
          onAnswer: _handleAnswer,
        );
      case 2:
        return AudioLevel(
          currentImage: gameState.currentImage!,
          options: gameState.options,
          onAnswer: _handleAnswer,
        );
      case 3:
        return ScrambleLevel(
          currentImage: gameState.currentImage!,
          correctAnswer: gameState.correctAnswer!,
          options: gameState.options,
          onAnswer: _handleAnswer,
        );
      case 4:
        return TextLevel(
          currentImage: gameState.currentImage!,
          options: gameState.options,
          onAnswer: _handleAnswer,
        );
      case 5:
        return EnglishLevel(
          currentImage: gameState.currentImage!,
          options: gameState.options,
          onAnswer: _handleAnswer,
        );
      default:
        return ImageLevel(
          currentImage: gameState.currentImage!,
          options: gameState.options,
          onAnswer: _handleAnswer,
        );
    }
  }
}
