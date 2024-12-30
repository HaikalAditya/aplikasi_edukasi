import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class BermainPage extends StatefulWidget {
  const BermainPage({super.key});

  @override
  State<BermainPage> createState() => _BermainPageState();
}

class _BermainPageState extends State<BermainPage> {
  final List<String> _images = [
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

  late AudioPlayer _player;
  String? _currentImage;
  String? _correctAnswer;
  List<String> _options = [];
  List<String> _currentAnswer = [];
  int _score = 0;
  int _currentLevel = 1;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _generateLevel();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _generateLevel() {
    switch (_currentLevel) {
      case 1:
        _generateImageLevel();
        break;
      case 2:
        _generateAudioLevel();
        break;
      case 3:
        _generateScrambleLevel();
        break;
      default:
        _generateImageLevel();
        break;
    }
  }

  void _generateImageLevel() {
    final random = Random();
    final randomIndex = random.nextInt(_images.length);

    setState(() {
      _currentImage = _images[randomIndex];
      _correctAnswer = _currentImage!.split('/').last.replaceAll('.jpg', '');
      _generateOptions(4); // 4 options for image level
    });
  }

  void _generateAudioLevel() {
    final random = Random();
    final randomIndex = random.nextInt(_images.length);

    setState(() {
      _currentImage = _images[randomIndex];
      _correctAnswer = _currentImage!.split('/').last.replaceAll('.jpg', '');
      _player.play(AssetSource('$_correctAnswer.mp3'));
      _generateOptions(5); // 5 options for audio level
    });
  }

  void _generateScrambleLevel() {
    final random = Random();
    final randomIndex = random.nextInt(_images.length);

    setState(() {
      _currentImage = _images[randomIndex];
      _correctAnswer = _currentImage!.split('/').last.replaceAll('.jpg', '');
      _options =
          _correctAnswer!.split(''); // Split the correct answer into characters
      _options.shuffle(); // Shuffle the characters
      _currentAnswer.clear();
    });
  }

  void _generateOptions(int numOptions) {
    final random = Random();
    final Set<String> optionSet = {_correctAnswer!};

    while (optionSet.length < numOptions) {
      final randomOption = _images[random.nextInt(_images.length)]
          .split('/')
          .last
          .replaceAll('.jpg', '');
      optionSet.add(randomOption);
    }

    _options = optionSet.toList();
    _options.shuffle();
  }

  void _checkAnswer(String choice) {
    final isCorrect = choice == _correctAnswer;
    if (isCorrect) {
      setState(() {
        _score++;
        _currentLevel++;
        if (_currentLevel > 3) _currentLevel = 1; // Reset to Level 1
        _generateLevel();
      });
    }

    _showDialog(isCorrect);
  }

  void _checkScrambledAnswer(String userAnswer) {
    final isCorrect = userAnswer == _correctAnswer;
    if (isCorrect) {
      setState(() {
        _score++;
        _currentLevel++;
        if (_currentLevel > 3) _currentLevel = 1; // Reset to Level 1
        _generateLevel();
      });
    } else {
      // Jawaban salah, kosongkan kolom jawaban
      setState(() {
        _currentAnswer.clear();
      });
    }

    _showDialog(isCorrect);
  }

  void _showDialog(bool isCorrect) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isCorrect ? 'Benar! 🎉' : 'Salah! 😞'),
          content: Text(isCorrect
              ? 'Selamat! Anda naik ke level $_currentLevel.'
              : 'Coba lagi!'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isCorrect) _generateLevel();
              },
              child: const Text('Lanjut'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
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
                // Display current image
                Expanded(
                  flex: 2,
                  child: Center(
                    child: _currentImage == null
                        ? const CircularProgressIndicator()
                        : _currentLevel == 3
                            ? Column(
                                children: [
                                  Text(
                                    'Menyusun Nama Hewan :',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Image.asset(
                                    _currentImage!,
                                    height: 100,
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              )
                            : Image.asset(
                                _currentImage!,
                                height: 250,
                              ),
                  ),
                ),
                const SizedBox(height: 5),
                // Display options for scramble level
                // Display options for scramble level
                Expanded(
                  flex: 2,
                  child: _currentLevel == 3
                      ? Column(
                          children: [
                            // Kolom untuk menaruh huruf
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(_correctAnswer!.length,
                                  (index) {
                                return Container(
                                  width: 40,
                                  height: 40,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 0, 102, 255)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _currentAnswer.length > index
                                          ? _currentAnswer[index]
                                          : '',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0)),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(
                                height:
                                    20), // Jarak antara kolom jawaban dan pilihan huruf
                            // Pilihan huruf di bawah kolom jawaban
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              alignment: WrapAlignment.center,
                              children: _options.map((letter) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (_currentAnswer.length <
                                          _correctAnswer!.length) {
                                        _currentAnswer.add(
                                            letter); // Tambahkan huruf yang diklik
                                        if (_currentAnswer.length ==
                                            _correctAnswer!.length) {
                                          final userAnswer =
                                              _currentAnswer.join();
                                          _checkScrambledAnswer(
                                              userAnswer); // Validasi jawaban
                                        }
                                      }
                                    });
                                  },
                                  child: _buildScrambleTile(letter,
                                      isPlaceholder: false),
                                );
                              }).toList(),
                            ),
                          ],
                        )
                      : Center(
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            alignment: WrapAlignment.center,
                            children: _options.map((option) {
                              return GestureDetector(
                                onTap: () => _checkAnswer(option),
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
                        ),
                ),
                const SizedBox(height: 20),
                // Display score
                Text(
                  'Score: $_score',
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

  Widget _buildScrambleTile(String letter, {bool isPlaceholder = false}) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isPlaceholder ? Colors.grey[300] : Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isPlaceholder ? Colors.grey : Colors.white,
          ),
        ),
      ),
    );
  }
}
