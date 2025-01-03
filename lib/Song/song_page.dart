import 'package:choose_songs/Song/add_song.dart';
import 'package:flutter/material.dart';

class SongPageful extends StatefulWidget {
  const SongPageful({super.key, required this.title,required this.id});

  final String title;
  final String id;

  @override
  State<SongPageful> createState() => SongPageState();
}

class SongPageState extends State<SongPageful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("曲一覧"),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.bold, 
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 240),
      ),
      body:Center(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {

            return const Center(
              child:Padding(
                padding:EdgeInsets.symmetric(//上下左右に一定の余白を設定
                  horizontal:16,//左右の余白
                  vertical:10,//上下の余白
                ),

                child:Row(
                  children:[
                    Icon(
                      Icons.music_note,
                      size:30,
                    ),

                    Text(
                      'テスト',
                      style:TextStyle(
                        fontSize:20,
                        //fontWeight: FontWeight.bold,//テキストの太さ
                      ),
                    ),

                  ]
                )
              )
            );
            
          },
        ),
      ),


        //曲を追加するボタン
        floatingActionButton: FloatingActionButton(
          
          onPressed: () {
            debugPrint('現在のIDは${widget.id}');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddSong(id: widget.id))
            );
          },
          backgroundColor: const Color.fromARGB(255, 255, 255, 240),
          child: const Icon(Icons.add),
        ),
    );
  }
}
