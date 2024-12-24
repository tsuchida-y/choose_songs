import 'package:flutter/material.dart';
import 'package:choose_songs/sort_page.dart';
import 'package:choose_songs/list_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ホーム画面'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //変数にページを追加
  static const _screens = [
    ListPage(),  
    SortPage()
  ];
  
  int _selectedIndex = 0;

    void _onItemTapped(int index) {//index=タップされたアイテムの位置(今は0か1)
    setState(() {
      _selectedIndex = index;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],//選択されたページを表示
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,//現在選択されているアイテムのindex
          onTap: _onItemTapped,//アイテムがタップされた時の処理
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'ライブラリ'),//ボタンに何を表示させるか
            BottomNavigationBarItem(icon: Icon(Icons.manage_search), label: 'セレクト'),
          ],
          type: BottomNavigationBarType.fixed,//
          selectedIconTheme: const IconThemeData(size: 30, color: Color.fromARGB(255, 255, 166, 1)),//アイコンの色・大きさ
          selectedItemColor: const Color.fromARGB(255, 179, 117, 1),//文字の色
          backgroundColor: const Color.fromARGB(255, 255, 255, 240),//背景色
        ));
  }
}
