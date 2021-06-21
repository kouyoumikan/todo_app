import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async { // main()を非同期に設定
  // firebaseを初期化する処理
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
      FireStoreApp()
  );
}

class FireStoreApp extends StatefulWidget {
  const  FireStoreApp({Key? key}) : super(key: key);

  @override
  _FireStoreAppState createState() => _FireStoreAppState();
}

class _FireStoreAppState extends State<FireStoreApp> {
  // テキストフィールドの値をfirestoreで保存できるように設定
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // firestore内のgroceriesドキュメントのコレクションを参照する設定
    CollectionReference groceries = FirebaseFirestore.instance.collection('groceries');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: textController, // テキストフィールドの値をfirestoreで保存
          ),
        ),
        //body: Text('参考URL: https://youtu.be/WuYOGBEOEOo'),
        body: Center(
          child: StreamBuilder( // firebaseの内容
//            stream: FirebaseFirestore.instance
//              .collection('groceries') // firebaseのドキュメント名
//              .snapshots(),
            stream: groceries.snapshots(), // groceriesのsnapshotsを作成
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return ListView(
                children: snapshot.data!.docs.map((grocery) {
                  return Center(
                    child: ListTile(
                      title: Text(grocery['name']), // document内のnameの値を表示
                    ),
                  );
                }).toList(),
              );
            }),
        ),
        floatingActionButton: FloatingActionButton( // 保存ボタンの作成
          child: Icon(Icons.save),
          onPressed: () {
            // ボタン押下後、テキストフィールドの値をgroceriesドキュメント内のnameコレクションに保存する
            groceries.add({
              'name': textController.text,
            });
          },
        ),
      ),
    );
  }
}

//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'TODOアプリ',
//      home: Scaffold(
//      appBar: AppBar(
//        title: Text('TODOアプリ'),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {},
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ),
//    ),
//    );
//  }
//}
