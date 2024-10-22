import 'package:flutter/material.dart';
import 'package:kids_learning/screens/dictation_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'quiz_screen.dart';
import 'numbers_screen.dart';
import 'alphabet_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(width: 20.0, height: 100.0),
            const Text(
              'Learning',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5.0, height: 100.0),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 14.0,
                fontFamily: 'Horizon',
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  RotateAnimatedText('is like eating ice cream!'),
                  RotateAnimatedText('makes your brain dance!'),
                  RotateAnimatedText('turns you into a superhero!'),
                  RotateAnimatedText('is cooler than a rainbow unicorn!'),
                  RotateAnimatedText('helps you talk to dinosaurs!'),
                ],
                repeatForever: true,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NumbersScreen()),
                );
              },
              child: const Card(
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.looks_one,
                      size: 64,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Learn Numbers',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlphabetScreen()),
                );
              },
              child: const Card(
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.looks_two,
                      size: 64,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Learn Alphabet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizScreen()),
                );
              },
              child: const Card(
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.quiz,
                      size: 64,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Take Quiz',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SpellWordScreen()),
                );
              },
              child: const Card(
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mic,
                      size: 64,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Dictation',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
