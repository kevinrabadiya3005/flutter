// lib/it_quiz_app/it_quiz_screen.dart
import 'package:flutter/material.dart';

class ITQuizScreen extends StatefulWidget {
  const ITQuizScreen({super.key});

  @override
  State<ITQuizScreen> createState() => _ITQuizScreenState();
}

class _ITQuizScreenState extends State<ITQuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  bool _showResult = false;
  String _selectedAnswer = '';

  final List<Map<String, dynamic>> _questions = [
    {'q': 'Which language is used for web development?', 'options': ['Java', 'JavaScript', 'C++', 'Python'], 'ans': 'JavaScript'},
    {'q': 'What does OOP stand for?', 'options': ['Object Oriented Programming', 'Open Online Platform', 'Online Operating Program', 'Original Object Protocol'], 'ans': 'Object Oriented Programming'},
    {'q': 'What does HTML stand for?', 'options': ['HyperText Markup Language', 'Home Tool Markup Language', 'Hyperlinks Text Mark Language', 'High Tech Modern Language'], 'ans': 'HyperText Markup Language'},
  ];

  void _selectAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
      _showResult = true;
      if (answer == _questions[_currentIndex]['ans']) _score++;
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
        _showResult = false;
        _selectedAnswer = '';
      } else {
        _showFinalScore();
      }
    });
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Complete'),
        content: Text('Score: $_score/${_questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
                _score = 0;
                _showResult = false;
                _selectedAnswer = '';
              });
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programming Quiz'),
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Question ${_currentIndex + 1}/${_questions.length}',
                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(question['q'], style: const TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20),
            ...question['options'].map<Widget>((option) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _showResult ? null : () => _selectAnswer(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _showResult 
                      ? (option == question['ans'] ? Colors.green : 
                         option == _selectedAnswer ? Colors.red : Colors.grey)
                      : Colors.cyan,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(option),
                ),
              ),
            )),
            if (_showResult) ...[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan, foregroundColor: Colors.white),
                child: Text(_currentIndex < _questions.length - 1 ? 'Next' : 'Finish'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}