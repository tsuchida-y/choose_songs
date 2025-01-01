import 'package:choose_songs/PlayList/add_playlist.dart';
import 'package:choose_songs/Song/song_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:choose_songs/post.dart';
import 'package:choose_songs/PlayList/change_playlistname.dart';


class ListPageles extends StatelessWidget {
  const ListPageles({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
       theme: ThemeData(
         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
         useMaterial3: true,
       ),
      home: const ListPageful(title: 'ライブラリ'),
    );
  }
}




class ListPageful extends StatefulWidget {
  const ListPageful({super.key, required this.title});

  final String title;

  @override
  State<ListPageful> createState() => ListPageState();
}





class ListPageState extends State<ListPageful> {
  //const ListPageState({Key? key}) : super(key: key);

  List <Post> posts = [];


  @override
  void initState() {
    super.initState();
    fetchFirebaseData();
  }


    //firebaseからデータを取得する
    Future fetchFirebaseData() async{
    await FirebaseFirestore.instance.collection("playList").orderBy('createdAt').get().then((event) {//コールバック関数を渡す
      final docs = event.docs;//取得したドキュメントのリスト
      
        setState(() {//画面を更新する
          posts = docs.map((doc){//各要素に対して処理を行う。docは現在のドキュメント
            final data = doc.data();//現在のドキュメントのデータを取得
            final id = doc.id;
            final text = data['text'] as String;
            final createdAt = data['createdAt'].toDate();//Timestamp型をDateTime型(日付や時間)に変換
            final updatedAt = data['updatedAt']?.toDate();

            return Post(//取得したデータを使用し、Postオブジェクトを生成し返す
              id:id,//左がPostクラスのフィールド、右が取得したデータ
              text:text,
              createdAt:createdAt,
              updatedAt:updatedAt
            );
            },
            
            ).toList();//Listに変換する
            
        });  
    });
  }

  //Firebaseからデータを削除するメソッド
  Future deleteFirebaseData(String id) async{
  await FirebaseFirestore.instance.collection("playList").doc(id).delete();//ドキュメントIDを指定して削除 。引数はいらない
  }


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
      body:Center(
        child:ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            final post = posts[index];
            return InkWell( //タップ可能にしエフェクトをつける
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SongPageful(title: '',))
                );
              },
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
                    onPressed: (){
                      //ボトムシートを表示
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                        
                          return Center(  
                              child: ListView(
                              children:[
                                    ListTile(
                                      leading: const Icon(Icons.edit),
                                      title:const Text('名前変更'),
                                      onTap: () async {
                                        //Navigator.pop(context);
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => ChangePlayListName(post),)
                                        );
                                        Navigator.pop(context);
                                        await fetchFirebaseData();
                                        
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.delete), // 左側のアイコン
                                      title:const Text('削除'),
                                      onTap: () async {
                                        deleteFirebaseData(post.id);
                                        fetchFirebaseData();
                                        Navigator.pop(context);
                                      },
                                    ),
                              ]
                            ) 
                          );
                        },
                      );
                    },
                    icon:const Icon(Icons.more_vert),
                  ),

                ]
              )
            )
          );
        })
        ),

        //プレイリストを追加するボタン
        floatingActionButton: FloatingActionButton(
          
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPlayList()),
            );
            await fetchFirebaseData();
          },
          backgroundColor: const Color.fromARGB(255, 255, 255, 240),
          child: const Icon(Icons.add),
        ),

      );
  }
}