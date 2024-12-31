import 'package:choose_songs/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChangePlayListName extends StatefulWidget {
  const ChangePlayListName(this.post,{super.key});

  final Post post;//Postクラスのインスタンスを受け取る

  @override
  State<ChangePlayListName> createState() => ChangePlayListNameState();
}


class ChangePlayListNameState extends State<ChangePlayListName> {

  String updatedWord = '';//ユーザーが入力した新しい文字列を格納する変数


    //firebaseにデータを追加するメソッド
    Future updateFirebaseData() async{
    await FirebaseFirestore.instance.collection("playList").doc(widget.post.id).update({//ドキュメントIDを使用して、特定のドキュメントを参照
      'name': 'Flutter',
      'text': updatedWord,
      'updatedAt': DateTime.now(),
    });
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('名前変更'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 240),
      ),
      body: Column(
        children:[
          const Padding(
            padding: EdgeInsets.all(50),
          ),
          TextFormField(
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '新しいプレイリスト名',
            ),
            autofocus: true,
            initialValue: widget.post.text,//Postクラスのtextフィールドを初期値として設定
            onChanged: (value){//文字が入力されるたびに呼ばれる
              updatedWord = value;
              setState(() {});//画面を更新
            },
          ),
          ElevatedButton(
            onPressed: updatedWord.isEmpty ? null : (){//updatedWordが空でない場合のみボタンを押せるようにする
              updateFirebaseData();
              Navigator.pop(context);
            },
            child: const Text("変更"),
          )
        ] 
      ),
    );
  }
}