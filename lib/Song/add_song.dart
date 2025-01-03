import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddSong extends StatefulWidget {
  const AddSong({super.key,required this.id});

final String id;
  @override
  State<AddSong> createState() => AddSongState();
}

class AddSongState extends State<AddSong> {
    
    String songWord = '';
    
    //firebaseにデータを追加するメソッド
    Future addFirebaseData() async{
    await FirebaseFirestore.instance.collection("Song").add({//インスタンスを取得しコレクションを指定
      'name': 'Flutter',//追加するデータはmap型で指定
      'ID': '1',
      'text': songWord,
      'createdAt': DateTime.now(),
    });
  }

    @override
  Widget build(BuildContext context) {
    print('移行後のIDは${widget.id}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('曲追加'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 240),
      ),

            body:Column(
        
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(50),
            ),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '曲名',
              hintText: '大地讃頌',
              hintStyle: TextStyle(color: Color.fromARGB(255, 130, 130, 130)),

            ),
            autofocus: true,
            onChanged: (text) {
              songWord = text;
            },
          ),
          ElevatedButton(
            onPressed: () {
              addFirebaseData();

              Navigator.pop(context);
            },
            child: const Text('追加'),
          ),
        ],
      ),
    );
  }
}