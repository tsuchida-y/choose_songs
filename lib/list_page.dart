import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);


  static List<String> playList = ['PlayList1', 'PlayList2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('曲一覧'),
      ),
      body:Center(
        child:ListView.builder(
          itemCount: playList.length,
          itemBuilder: (BuildContext context, int index) {
          return Container(
            child:Padding(
              padding:const EdgeInsets.symmetric(//上下左右に一定の余白を設定
              horizontal:16,//左右の余白
              vertical:16,//上下の余白
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.music_note,
                  size:48,
                ),
                Text(
                  playList[index],
                  style:const TextStyle(
                    fontSize:24,
                    fontWeight: FontWeight.bold,//テキストの太さ
                  ),

                ),
                const Spacer(),
                IconButton(
                  onPressed: (){},
                  icon:const Icon(Icons.more_vert),
                ),
              ]
            ))
          );
        })
      )
    );
  }
}