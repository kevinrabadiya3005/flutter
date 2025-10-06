// lib/image_spelling_match_app/image_spelling_match_screen.dart
import 'package:flutter/material.dart';
import 'dart:math';

class ImageSpellingMatchScreen extends StatefulWidget {
  const ImageSpellingMatchScreen({super.key});

  @override
  State<ImageSpellingMatchScreen> createState() => _ImageSpellingMatchScreenState();
}

class _ImageSpellingMatchScreenState extends State<ImageSpellingMatchScreen> {
  int _score = 0;
  int _currentQuestionIndex = 0;
  bool _showResult = false;
  bool _isCorrect = false;
  String _selectedAnswer = '';

  final List<Map<String, dynamic>> _questions = [
    {
      'emoji': '🐱',
      'correctAnswer': 'CAT',
      'options': ['CAT', 'DOG', 'BAT', 'RAT'],
    },
    {
      'emoji': '🐶',
      'correctAnswer': 'DOG',
      'options': ['FOG', 'DOG', 'LOG', 'HOG'],
    },
    {
      'emoji': '🌞',
      'correctAnswer': 'SUN',
      'options': ['SUN', 'RUN', 'FUN', 'BUN'],
    },
    {
      'emoji': '🌙',
      'correctAnswer': 'MOON',
      'options': ['SOON', 'MOON', 'NOON', 'SPOON'],
    },
    {
      'emoji': '🍎',
      'correctAnswer': 'APPLE',
      'options': ['APPLE', 'GRAPE', 'BANANA', 'ORANGE'],
    },
    {
      'emoji': '🚗',
      'correctAnswer': 'CAR',
      'options': ['CAR', 'BUS', 'BIKE', 'TRAIN'],
    },
    {
      'emoji': '🏠',
      'correctAnswer': 'HOUSE',
      'options': ['HOUSE', 'MOUSE', 'HORSE', 'GOOSE'],
    },
    {
      'emoji': '🌳',
      'correctAnswer': 'TREE',
      'options': ['FREE', 'TREE', 'KNEE', 'FLEE'],
    },
    {
      'emoji': '🌸',
      'correctAnswer': 'FLOWER',
      'options': ['TOWER', 'POWER', 'FLOWER', 'SHOWER'],
    },
    {
      'emoji': '⭐',
      'correctAnswer': 'STAR',
      'options': ['STAR', 'SCAR', 'CHAR', 'CZAR'],
    },
  ];

  Map<String, dynamic> get _currentQuestion => _questions[_currentQuestionIndex];

  void _selectAnswer(String answer) {
    if (_showResult) return;
    
    setState(() {
      _selectedAnswer = answer;
      _isCorrect = answer == _currentQuestion['correctAnswer'];
      _showResult = true;
      if (_isCorrect) _score++;
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _showResult = false;
        _selectedAnswer = '';
      } else {
        _resetGame();
      }
    });
  }

  void _resetGame() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _showResult = false;
      _selectedAnswer = '';
      _questions.shuffle();
      for (var question in _questions) {
        question['options'].shuffle();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _questions.shuffle();
    for (var question in _questions) {
      question['options'].shuffle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Spelling Match'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'Score: $_score/${_questions.length}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Colors.deepPurple],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Progress Indicator
              LinearProgressIndicator(
                value: (_currentQuestionIndex + 1) / _questions.length,
                backgroundColor: Colors.white.withOpacity(0.3),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              const SizedBox(height: 20),
              
              // Question Counter
              Text(
                'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Image Card
              Card(
                elevation: 12,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Colors.yellow, Colors.orange],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _currentQuestion['emoji'],
                      style: const TextStyle(fontSize: 100),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Instruction
              const Text(
                'Choose the correct spelling:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Answer Options
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: _currentQuestion['options'].length,
                  itemBuilder: (context, index) {
                    final option = _currentQuestion['options'][index];
                    Color buttonColor = Colors.white;
                    Color textColor = Colors.purple;
                    
                    if (_showResult && option == _selectedAnswer) {
                      buttonColor = _isCorrect ? Colors.green : Colors.red;
                      textColor = Colors.white;
                    } else if (_showResult && option == _currentQuestion['correctAnswer']) {
                      buttonColor = Colors.green;
                      textColor = Colors.white;
                    }

                    return ElevatedButton(
                      onPressed: () => _selectAnswer(option),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: textColor,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        option,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Result and Next Button
              if (_showResult) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isCorrect ? Colors.green.withOpacity(0.9) : Colors.red.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isCorrect ? Icons.check_circle : Icons.cancel,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _isCorrect ? 'Correct!' : 'Try Again!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentQuestionIndex < _questions.length - 1 ? 'Next Question' : 'Play Again',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}