import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NumbersScreen extends StatelessWidget {
  final List<int> numbers = List.generate(50, (index) => index);
  final FlutterTts flutterTts = FlutterTts();

  NumbersScreen({super.key});

  Future<void> _speak(String number) async {
    await flutterTts.speak(number);
  }

  void _showNumberDialog(BuildContext context, String number) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            number,
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learn Numbers')),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: numbers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              String selectedNumber = numbers[index].toString();
              _speak(selectedNumber);
              _showNumberDialog(context, selectedNumber);
            },
            child: Card(
              child: Center(
                child: Text(
                  numbers[index].toString(),
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
