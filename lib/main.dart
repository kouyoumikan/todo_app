import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(
    FireStoreApp()
  );
}

class FireStoreApp extends StatefulWidget {
  @override
  _FireStoreAppState createState() => _FireStoreAppState();
}

class _FireStoreAppState extends State<FireStoreApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firestore Exsample'),
        ),
        body: Text('参考URL: https://youtu.be/WuYOGBEOEOo'),
      ),
    );
  }
}

