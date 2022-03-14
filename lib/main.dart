import 'dart:io';
import 'package:hive/hive.dart';
import "package:hive_flutter/hive_flutter.dart";
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoapp/view/note_list_view.dart';

import 'models/note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter<Note>(NoteAdapter());
  await Hive.openBox<Note>("note");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: NoteListView(),
    );
  }
}
