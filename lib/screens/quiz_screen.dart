import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kids_learning/model/questions.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  double _questionIndex = 0;
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String message) async {
    await flutterTts.speak(message);
  }

  void _answerQuestion(String answer) {
    String correctAnswer = Questions().questions[_questionIndex.toInt()]
        ['correctAnswer'] as String;

    // Determine dialog message based on the answer
    String dialogMessage =
        answer == correctAnswer ? 'Correct!' : 'Oops! Try again.';
    String spokenMessage =
        answer == correctAnswer ? 'Correct' : 'Oops! Try again.';

    speak(spokenMessage);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                dialogMessage,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Icon(
                answer == correctAnswer ? Icons.check_circle : Icons.error,
                size: 48,
                color: answer == correctAnswer ? Colors.green : Colors.red,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );

    setState(() {
      // Move to the next question
      _questionIndex = (_questionIndex + 1) % Questions().questions.length;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: Colors.green, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.stretch, 
            children: [
             
              Text(
                Questions().questions[_questionIndex.toInt()]['question']
                    as String,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green, 
                ),
                textAlign: TextAlign.center, 
              ),
              const SizedBox(height: 20),
            
              ...(Questions().questions[_questionIndex.toInt()]['answers']
                      as List<String>)
                  .map((answer) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () => _answerQuestion(answer),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(answer),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
