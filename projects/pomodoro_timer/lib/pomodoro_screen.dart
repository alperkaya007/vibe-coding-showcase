import 'package:flutter/material.dart';
import 'dart:async';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});
  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  static const _workMin = 25;
  static const _breakMin = 5;
  late int _seconds;
  bool _working = true, _running = false;
  int _sessions = 0;
  Timer? _timer;

  @override
  void initState() { super.initState(); _seconds = _workMin * 60; }
  @override
  void dispose() { _timer?.cancel(); super.dispose(); }

  String get _display => '${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}';

  void _toggle() {
    if (_running) { _timer?.cancel(); }
    else {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() {
          if (_seconds > 0) { _seconds--; }
          else {
            _working = !_working;
            if (_working) _sessions++;
            _seconds = (_working ? _workMin : _breakMin) * 60;
          }
        });
      });
    }
    setState(() => _running = !_running);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _working ? const Color(0xFFBA1A1A) : const Color(0xFF1B5E20),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(_working ? 'Focus' : 'Break', style: const TextStyle(color: Colors.white70, fontSize: 20)),
        Text(_display, style: const TextStyle(color: Colors.white, fontSize: 72, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
        const SizedBox(height: 32),
        FloatingActionButton.large(
          onPressed: _toggle,
          backgroundColor: Colors.white24,
          child: Icon(_running ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 16),
        Text('Sessions: $_sessions', style: const TextStyle(color: Colors.white70)),
      ])),
    );
  }
}
