import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPlayList extends StatefulWidget {
  const AddPlayList({Key? key}) : super(key: key);

  @override
  State<AddPlayList> createState() => AddPlayListState();
}

class AddPlayListState extends State<AddPlayList> {

    //firebaseにデータを追加するメソッド
    Future addFirebaseData() async{
    await FirebaseFirestore.instance.collection("posts").add({//インスタンスを取得しコレクションを指定
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
      body: const Center(
          child: Text('プレイリスト追加', style: TextStyle(fontSize: 32.0))),
    );
  }
}