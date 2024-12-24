import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);


  static List<String> playList = ['PlayList1', 'PlayList2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ライブラリ'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 35,
          fontWeight: FontWeight.bold,
          
        ),

        backgroundColor: const Color.fromARGB(255, 255, 255, 240),
      ),
      body:Center(
        child:ListView.builder(
          itemCount: playList.length,
          itemBuilder: (BuildContext context, int index) {
            
          return Container(
            child:Padding(
              padding:const EdgeInsets.symmetric(//上下左右に一定の余白を設定
                horizontal:16,//左右の余白
                vertical:10,//上下の余白
              ),

              child: Row(
                children: [
                  InkWell(//タップされた時の処理
                    onTap: (){

                    },
                  ),

                  const Icon(
                    Icons.music_note,
                    size:30,
                  ),

                  Text(
                    playList[index],
                    style:const TextStyle(
                      fontSize:20,
                      //fontWeight: FontWeight.bold,//テキストの太さ
                    ),
                  ),

                  const Spacer(),
                  IconButton(
                    onPressed: (){},
                    icon:const Icon(Icons.more_vert),
                  ),
                ]
              )
            )
          );
        })
      )
    );
  }
}