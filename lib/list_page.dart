import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:choose_songs/post.dart';




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
      home: const ListPageful(title: 'Firebase Learning!!'),
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
  static List<String> playList = ['PlayList1', 'PlayList2'];


  @override
  void initState() {
    super.initState();
    fetchFirebaseData();
  }


    //firebaseからデータを取得する
    Future fetchFirebaseData() async{
      print("fetchFirebaseData開始");
    await FirebaseFirestore.instance.collection("playListID")
    //.orderBy('createdAt')
    .get().then((event) {//コールバック関数を渡す
    print("fetchFirebaseDataインスタンスを生成");
      final docs = event.docs;//取得したドキュメントのリスト
      
        setState(() {//画面を更新する
          posts = docs.map((doc){//各要素に対して処理を行う。docは現在のドキュメント
          print("dataの中身$posts");
          print("現在のドキュメント$doc");
          print("テスト");
            final data = doc.data();//現在のドキュメントのデータを取得
            print("現在のドキュメントデータ$data");
            final id = doc.id;
            final text = data['text'] as String;
            //final createdAt = data['createdAt'].toDate();//Timestamp型をDateTime型(日付や時間)に変換
            //final updatedAt = data['updatedAt']?.toDate();

            return Post(//取得したデータを使用し、Postオブジェクトを生成し返す
              id:id,//左がPostクラスのフィールド、右が取得したデータ
              text:text,
              //createdAt:createdAt,
              //updatedAt:updatedAt
            );
            },
            
            ).toList();//Listに変換する
            print("更新後のpostsリスト: $posts");
            
        });  
    });
    print("fetchFirebaseData終了");
  }


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
                    //playList[index],
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