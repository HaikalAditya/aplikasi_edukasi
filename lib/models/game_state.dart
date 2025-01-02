import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class GameState {
  final List<String> images = [
    'assets/kucing.jpg',
    'assets/anjing.jpg',
    'assets/burung.jpg',
    'assets/panda.jpg',
    'assets/penguin.jpg',
    'assets/flamingo.jpg',
    'assets/bunglon.jpg',
    'assets/gajah.jpg',
    'assets/harimau.jpg',
    'assets/jerapah.jpg',
  ];

  // Mapping nama hewan dalam bahasa Inggris
  final Map<String, String> animalTranslations = {
    'kucing': 'cat',
    'anjing': 'dog',
    'burung': 'bird',
    'panda': 'panda',
    'penguin': 'penguin',
    'flamingo': 'flamingo',
    'bunglon': 'chameleon',
    'gajah': 'elephant',
    'harimau': 'tiger',
    'jerapah': 'giraffe',
  };

  late AudioPlayer player;
  String? currentImage;
  String? correctAnswer;
  List<String> options = [];
  int score = 0;
  int currentLevel = 1;
  final random = Random();

  void initGame() {
    player = AudioPlayer();
  }

  void dispose() {
    player.dispose();
  }

  void generateImageLevel() {
    _generateRandomImage();
    _generateOptions(4);
  }

  void generateAudioLevel() {
    _generateRandomImage();
    player.play(AssetSource('$correctAnswer.mp3'));
    _generateOptions(5);
  }

  void generateScrambleLevel() {
    _generateRandomImage();
    options = correctAnswer!.split('');
    options.shuffle();
  }

  void generateTextLevel() {
    _generateRandomImage();
    _generateTextOptions(4);
  }

  void generateEnglishLevel() {
    _generateRandomImage();
    _generateEnglishOptions(4);
  }

  void _generateRandomImage() {
    final randomIndex = random.nextInt(images.length);
    currentImage = images[randomIndex];
    correctAnswer = currentImage!.split('/').last.replaceAll('.jpg', '');
  }

  void _generateOptions(int numOptions) {
    final optionSet = {correctAnswer!};
    while (optionSet.length < numOptions) {
      final randomOption = images[random.nextInt(images.length)]
          .split('/')
          .last
          .replaceAll('.jpg', '');
      optionSet.add(randomOption);
    }
    options = optionSet.toList()..shuffle();
  }

  void _generateTextOptions(int numOptions) {
    final optionSet = {correctAnswer!};
    while (optionSet.length < numOptions) {
      final randomOption = images[random.nextInt(images.length)]
          .split('/')
          .last
          .replaceAll('.jpg', '');
      optionSet.add(randomOption);
    }
    options = optionSet.toList()..shuffle();
  }

  void _generateEnglishOptions(int numOptions) {
    final correctEnglish = animalTranslations[correctAnswer]!;
    final optionSet = {correctEnglish};
    while (optionSet.length < numOptions) {
      final randomOption = images[random.nextInt(images.length)]
          .split('/')
          .last
          .replaceAll('.jpg', '');
      final englishOption = animalTranslations[randomOption]!;
      optionSet.add(englishOption);
    }
    correctAnswer = correctEnglish; // Update correctAnswer to English version
    options = optionSet.toList()..shuffle();
  }

  bool checkAnswer(String answer) => answer == correctAnswer;

  void incrementScore() => score++;

  void nextLevel() {
    currentLevel++;
    if (currentLevel > 5) currentLevel = 1; // Updated to handle 5 levels
  }
}
