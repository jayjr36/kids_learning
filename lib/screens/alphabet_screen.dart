import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AlphabetScreen extends StatelessWidget {
  final List<String> alphabet =
      List.generate(26, (index) => String.fromCharCode(65 + index));
  final FlutterTts flutterTts = FlutterTts();

  AlphabetScreen({super.key});

  Future<void> _speak(String letter) async {
    await flutterTts.speak(letter);
  }

  void _showLetterDialog(BuildContext context, String letter) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          contentPadding: const EdgeInsets.all(20.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                letter,
                style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              // Image.asset(
              //   'assets/letter_image.png',
              //   height: 100,
              // ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Colors.white, // Button text color
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learn Alphabet')),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: alphabet.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              String selectedLetter = alphabet[index];
              _speak(selectedLetter);
              _showLetterDialog(context, selectedLetter);
            },
            child: Card(
              child: Center(
                child: Text(
                  alphabet[index],
                  style: const TextStyle(
                      fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
