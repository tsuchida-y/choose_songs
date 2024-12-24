import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('曲一覧'),
      ),
      body: const Center(
          child: Text('曲一覧画面', style: TextStyle(fontSize: 32.0))),
    );
  }
}