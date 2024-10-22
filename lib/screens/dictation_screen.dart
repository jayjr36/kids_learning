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
    {'word': 'apple', 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjMsDnJRmRWZds5gdgxnLMYb8vuJfPpRUCzA&s'},
    {'word': 'dog', 'image': 'https://www.nylabone.com/-/media/project/oneweb/nylabone/images/dog101/10-intelligent-dog-breeds/golden-retriever-tongue-out.jpg'},
    {'word': 'cat', 'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Cat_November_2010-1a.jpg/1200px-Cat_November_2010-1a.jpg'},
    {'word': 'car', 'image': 'https://imgd.aeplcdn.com/370x208/n/cw/ec/139651/curvv-exterior-right-front-three-quarter.jpeg?isig=0&q=80'},
    {'word': 'ball', 'image': 'https://cdn.britannica.com/68/195168-050-BBAE019A/football.jpg'},
    {'word': 'cup', 'image': 'https://www.forlifedesignusa.com/cdn/shop/products/550-CAR.jpg?v=1581640656'},
    {'word': 'house', 'image': 'https://www.houseplans.net/uploads/plans/32005/elevations/88909-768.jpg?v=091024132147'},
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
            Image.network(
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
