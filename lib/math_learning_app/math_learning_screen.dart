// lib/math_learning_app/math_learning_screen.dart
import 'package:flutter/material.dart';
import 'dart:math';

enum MathOperation { addition, subtraction, multiplication, division }

class MathLearningScreen extends StatefulWidget {
  const MathLearningScreen({super.key});

  @override
  State<MathLearningScreen> createState() => _MathLearningScreenState();
}

class _MathLearningScreenState extends State<MathLearningScreen> {
  MathOperation _currentOperation = MathOperation.addition;
  int _num1 = 0;
  int _num2 = 0;
  int _correctAnswer = 0;
  int _score = 0;
  String _userAnswer = '';
  bool _showResult = false;
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    final random = Random();
    
    switch (_currentOperation) {
      case MathOperation.addition:
        _num1 = random.nextInt(50) + 1;
        _num2 = random.nextInt(50) + 1;
        _correctAnswer = _num1 + _num2;
        break;
      case MathOperation.subtraction:
        _num1 = random.nextInt(50) + 25;
        _num2 = random.nextInt(25) + 1;
        _correctAnswer = _num1 - _num2;
        break;
      case MathOperation.multiplication:
        _num1 = random.nextInt(10) + 1;
        _num2 = random.nextInt(10) + 1;
        _correctAnswer = _num1 * _num2;
        break;
      case MathOperation.division:
        _num2 = random.nextInt(10) + 1;
        _correctAnswer = random.nextInt(10) + 1;
        _num1 = _num2 * _correctAnswer;
        break;
    }
    
    _userAnswer = '';
    _showResult = false;
  }

  void _checkAnswer() {
    final userNum = int.tryParse(_userAnswer);
    if (userNum == null) return;
    
    setState(() {
      _isCorrect = userNum == _correctAnswer;
      _showResult = true;
      if (_isCorrect) _score++;
    });
  }

  void _nextQuestion() {
    setState(() {
      _generateQuestion();
    });
  }

  void _changeOperation(MathOperation operation) {
    setState(() {
      _currentOperation = operation;
      _generateQuestion();
    });
  }

  String get _operationSymbol {
    switch (_currentOperation) {
      case MathOperation.addition:
        return '+';
      case MathOperation.subtraction:
        return '-';
      case MathOperation.multiplication:
        return '×';
      case MathOperation.division:
        return '÷';
    }
  }

  Color get _operationColor {
    switch (_currentOperation) {
      case MathOperation.addition:
        return Colors.green;
      case MathOperation.subtraction:
        return Colors.blue;
      case MathOperation.multiplication:
        return Colors.purple;
      case MathOperation.division:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Learning'),
        backgroundColor: _operationColor,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'Score: $_score',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_operationColor.withOpacity(0.3), Colors.white],
          ),
        ),
        child: Column(
          children: [
            // Operation Selection
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOperationButton(MathOperation.addition, '+', Colors.green),
                  _buildOperationButton(MathOperation.subtraction, '-', Colors.blue),
                  _buildOperationButton(MathOperation.multiplication, '×', Colors.purple),
                  _buildOperationButton(MathOperation.division, '÷', Colors.red),
                ],
              ),
            ),
            // Question Area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Text(
                              '$_num1 $_operationSymbol $_num2 = ?',
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 30),
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  _userAnswer = value;
                                });
                              },
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 24),
                              decoration: InputDecoration(
                                hintText: 'Enter answer',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.all(16),
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (!_showResult)
                              ElevatedButton(
                                onPressed: _userAnswer.isNotEmpty ? _checkAnswer : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _operationColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Check Answer', style: TextStyle(fontSize: 18)),
                              ),
                            if (_showResult) ...[
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: _isCorrect ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      _isCorrect ? Icons.check_circle : Icons.cancel,
                                      color: _isCorrect ? Colors.green : Colors.red,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _isCorrect ? 'Correct!' : 'Wrong! Answer is $_correctAnswer',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: _isCorrect ? Colors.green : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _nextQuestion,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _operationColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Next Question', style: TextStyle(fontSize: 18)),
                              ),
                            ],
                          ],
                        ),
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

  Widget _buildOperationButton(MathOperation operation, String symbol, Color color) {
    final isSelected = _currentOperation == operation;
    return GestureDetector(
      onTap: () => _changeOperation(operation),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? color : color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            symbol,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : color,
            ),
          ),
        ),
      ),
    );
  }
}