import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:player/screens/video_player.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? directory;
  List file = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listofFiles();
  }

  // Make New Function
  void _listofFiles() async {
    directory = (await getApplicationDocumentsDirectory()).path;
    setState(() {
      file = io.Directory("$directory").listSync();  //use your folder name insted of resume.
    });
  }

  @override
  Widget build(BuildContext context) {
    return VidePlayerHome();
  }
}


//
// return Scaffold(
// appBar: AppBar(
// title: Text(widget.title),
// ),
// body: Center(
//
// child: ElevatedButton(
// child: Text("Pick Files"),
// onPressed: () async {
// final result = await FilePicker.platform.pickFiles();
// },
// )
// ),
// );