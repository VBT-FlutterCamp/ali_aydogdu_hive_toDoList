import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import "package:hive_flutter/hive_flutter.dart";
import 'package:todoapp/models/note.dart';
import 'package:todoapp/view/add_note_view.dart';
import 'package:todoapp/view/note_view.dart';

class NoteListView extends StatefulWidget {
  const NoteListView({Key? key}) : super(key: key);

  @override
  State<NoteListView> createState() => _NoteListViewState();
}

class _NoteListViewState extends State<NoteListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("N O T E C Y"),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Note>("note").listenable(),
          builder: (context, Box<Note> box, _) {
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (ctx, i) {
                  final note = box.getAt(i);
                  final Widget? imageFile =
                      Image.file(File(note?.imageUrl.toString() ?? ""));
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => noteView(
                                    title: note?.title?.toString() ?? "",
                                    description:
                                        note?.description?.toString() ?? "",
                                    imageUrl: note?.imageUrl ?? ""),
                              ),
                            );
                          },
                          leading: imageFile == null
                              ? Icon(Icons.image_not_supported_sharp)
                              : imageFile,
                          /*(Image.file(
                              File(note?.imageUrl.toString() ?? ""))),*/
                          title: Text(note?.title?.toString() ?? ""),
                          trailing: IconButton(
                              onPressed: () {
                                box.deleteAt(i);
                              },
                              icon: Icon(Icons.delete)),
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const addNoteView(),
            ),
          );
        },
        label: Text("+ | Add Note"),
      ),
    );
  }
}
