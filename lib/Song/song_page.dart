import 'package:flutter/material.dart';

class SongPageles extends StatelessWidget {
  const SongPageles({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
       theme: ThemeData(
         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
         useMaterial3: true,
       ),
      home: const SongPageful(title: '曲一覧'),
    );
  }
}

class SongPageful extends StatefulWidget {
  const SongPageful({super.key, required this.title});

  final String title;

  @override
  State<SongPageful> createState() => SongPageState();
}

class SongPageState extends State<SongPageful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 35,
          fontWeight: FontWeight.bold, 
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 240),
      ),
    );
  }
}
