import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class BelajarPage extends StatefulWidget {
  const BelajarPage({super.key});

  @override
  _BelajarPageState createState() => _BelajarPageState();
}

class _BelajarPageState extends State<BelajarPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  late AudioPlayer player = AudioPlayer();

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
    'assets/kangguru.jpg',
    'assets/koala.jpg',
    'assets/komodo.jpg',
    'assets/lumba-lumba.jpg',
    'assets/orang Utan.jpg',
    'assets/paus.jpg',
    'assets/rusa.jpg',
    'assets/ular.jpg',
    'assets/zebra.jpg',
  ];

  List<String> _animalNames = [];

  @override
  void initState() {
    super.initState();
    _animalNames = _images
        .map((path) =>
            path.split('/').last.split('.').first.replaceAll('-', ' '))
        .toList();

    // Create the audio player.
    player = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);
  }

  void _goToPage(int index) {
    if (index >= 0 && index < _images.length) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      String animalName = _animalNames[index];
      player.play(AssetSource("$animalName.mp3"));

      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Latar belakang gambar
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bacground.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Kontainer utama dengan PageView
          Center(
            child: Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                color: const Color.fromARGB(169, 255, 255, 255),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    16), // Sama dengan borderRadius pada Container
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      _images[index],
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
            ),
          ),

          // Tombol kiri
          Positioned(
            left: 20,
            top: MediaQuery.of(context).size.height * 0.4,
            child: SizedBox(
              width: 50,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _goToPage(_currentIndex - 1);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: const Icon(Icons.arrow_left, size: 24),
              ),
            ),
          ),
          // Tombol kanan
          Positioned(
            right: 20,
            top: MediaQuery.of(context).size.height * 0.4,
            child: SizedBox(
              width: 50,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _goToPage(_currentIndex + 1);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: const Icon(Icons.arrow_right, size: 24),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                _animalNames.isNotEmpty
                    ? _animalNames[_currentIndex].toUpperCase()
                    : '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
