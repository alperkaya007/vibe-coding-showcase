import 'package:flutter/material.dart';
import 'dart:math';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});
  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  static const _quotes = [
    {'text': 'The only way to do great work is to love what you do.', 'author': 'Steve Jobs'},
    {'text': 'Code is like humor. When you explain it, it is bad.', 'author': 'Cory House'},
    {'text': 'First, solve the problem. Then, write the code.', 'author': 'John Johnson'},
    {'text': 'Make it work, make it right, make it fast.', 'author': 'Kent Beck'},
  ];

  late Map<String, String> _current;

  @override
  void initState() {
    super.initState();
    _current = _quotes[Random().nextInt(_quotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF6750A4), Color(0xFF9C27B0)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.format_quote, size: 60, color: Colors.white54),
              const SizedBox(height: 24),
              Text(_current['text']!, style: const TextStyle(color: Colors.white, fontSize: 22, fontStyle: FontStyle.italic), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Text('— ${_current['author']}', style: const TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 40),
              FilledButton.icon(
                onPressed: () => setState(() => _current = _quotes[Random().nextInt(_quotes.length)]),
                icon: const Icon(Icons.refresh),
                label: const Text('New Quote'),
                style: FilledButton.styleFrom(backgroundColor: Colors.white24),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
