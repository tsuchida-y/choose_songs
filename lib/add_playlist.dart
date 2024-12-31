import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPlayList extends StatefulWidget {
  const AddPlayList({Key? key}) : super(key: key);

  @override
  State<AddPlayList> createState() => AddPlayListState();
}

class AddPlayListState extends State<AddPlayList> {
  String newWord = '';
    //firebaseにデータを追加するメソッド
    Future addFirebaseData() async{
    await FirebaseFirestore.instance.collection("playList").add({//インスタンスを取得しコレクションを指定
      'name': 'Flutter',//追加するデータはmap型で指定
      'text': newWord,
      'createdAt': DateTime.now(),
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プレイリスト追加'),
      ),

      body:Column(
        
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(50),
            ),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'プレイリスト名',
              hintText: 'Playlist1',
              hintStyle: TextStyle(color: Color.fromARGB(255, 130, 130, 130)),

            ),
            autofocus: true,
            onChanged: (text) {
              newWord = text;
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