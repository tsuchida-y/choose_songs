import 'package:flutter/material.dart';

class SortPage extends StatelessWidget {
  const SortPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('選択画面'),
      ),
      body: const Center(
          child: Text('選択画面', style: TextStyle(fontSize: 32.0))),
    );
  }
}