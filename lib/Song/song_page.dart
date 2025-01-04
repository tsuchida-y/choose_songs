import 'package:choose_songs/Song/add_song.dart';
import 'package:choose_songs/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SongPageful extends StatefulWidget {
  const SongPageful({super.key, required this.title,required this.id});

  final String title;
  final String id;

  @override
  State<SongPageful> createState() => SongPageState();
}

class SongPageState extends State<SongPageful> {

List <Post> posts = [];

    @override
  void initState() {
    super.initState();
    debugPrint('initStateをスタート');
    fetchFirebaseData();
    debugPrint('initStateを終了');
  }


      //firebaseからデータを取得する
    Future fetchFirebaseData() async{
    await FirebaseFirestore.instance.collection("Song").where('ID', isEqualTo: widget.id).orderBy('createdAt').get().then((event) {
      final docs = event.docs; //取得したドキュメントのリスト
      debugPrint('docsの中身は$docs');
      setState(() { //画面を更新する
      debugPrint('setStateをスタート');
      posts = docs.map((doc) { //各要素に対して処理を行う。docは現在のドキュメント
            final data = doc.data(); //ドキュメントのデータを取得
            final id = doc.id;
            final text = data['text'] as String;
            final createdAt = data['createdAt'].toDate();//Timestamp型をDateTime型(日付や時間)に変換
            final updatedAt = data['updatedAt']?.toDate();
            debugPrint('現在のテキストは$text');
            return Post(//取得したデータを使用し、Postオブジェクトを生成し返す
              id:id,//左がPostクラスのフィールド、右が取得したデータ
              text:text,
              createdAt:createdAt,
              updatedAt:updatedAt
            );
            },
            
            ).toList();//Listに変換する
            debugPrint('setStateを終了');
        });  
    });
  }
  
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
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return InkWell( //タップ可能にしエフェクトをつける
              onTap: () {},
            child:Padding(
              padding:const EdgeInsets.symmetric(//上下左右に一定の余白を設定
                horizontal:16,//左右の余白
                vertical:10,//上下の余白
              ),

              child: Row(
                children: [

                  const Icon(
                    Icons.music_note,
                    size:30,
                  ),

                  Text(
                    post.text,
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
            
          },
        ),
      ),


        //曲を追加するボタン
        floatingActionButton: FloatingActionButton(
          
          onPressed: () async{
            debugPrint('AddSongをスタート');
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddSong(id: widget.id))
            );
            debugPrint('AddSongから帰ってきた');
            await fetchFirebaseData();
          },
          
          backgroundColor: const Color.fromARGB(255, 255, 255, 240),
          child: const Icon(Icons.add),
        ),
    );
  }
}
