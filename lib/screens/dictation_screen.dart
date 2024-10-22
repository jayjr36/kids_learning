import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpellWordScreen extends StatefulWidget {
  const SpellWordScreen({super.key});

  @override
  SpellWordScreenState createState() => SpellWordScreenState();
}

class SpellWordScreenState extends State<SpellWordScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _words = [
    {'word': 'apple', 'image': 'assets/apple.png'},
    {'word': 'dog', 'image': 'assets/dog.png'},
    {'word': 'cat', 'image': 'assets/cat.png'},
    {'word': 'ball', 'image': 'assets/apple.png'},
    {'word': 'car', 'image': 'assets/dog.png'},
    {'word': 'cup', 'image': 'assets/cat.png'},
  ];
  int _currentWordIndex = 0;
  bool _isCorrect = false;
  bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();
    _spellWord();
  }

  Future<void> _spellWord() async {
    String word = _words[_currentWordIndex]['word']!;
    for (int i = 0; i < word.length; i++) {
      await _flutterTts.speak(word[i]);
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void _checkAnswer() {
    String typedWord = _controller.text.toLowerCase().trim();
    String correctWord = _words[_currentWordIndex]['word']!;
    setState(() {
      _isCorrect = typedWord == correctWord;
      _isSubmitted = true;
    });
  }

  void _nextWord() {
    setState(() {
      _currentWordIndex = (_currentWordIndex + 1) % _words.length;
      _controller.clear();
      _isSubmitted = false;
      _isCorrect = false;
    });
    _spellWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spell the Word'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              _words[_currentWordIndex]['image']!,
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Type the word',
              ),
              onSubmitted: (value) {
                _checkAnswer();
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            if (_isSubmitted)
              Text(
                _isCorrect ? 'Correct!' : 'Try Again!',
                style: TextStyle(
                  fontSize: 24,
                  color: _isCorrect ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _nextWord,
              child: const Text('Next Word'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
