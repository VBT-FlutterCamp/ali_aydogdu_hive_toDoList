import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import "package:hive_flutter/hive_flutter.dart";

import '../constants/strings.dart';
import '../models/note.dart';
import 'add_note_view.dart';
import 'note_view.dart';
import 'package:kartal/kartal.dart';

class NoteListView extends StatefulWidget {
  const NoteListView({Key? key}) : super(key: key);

  @override
  State<NoteListView> createState() => _NoteListViewState();
}

class _NoteListViewState extends State<NoteListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Note>("note").listenable(),
          builder: (context, Box<Note> box, _) {
            return listViewBuilder(box, context);
          },
        ),
      ),
      floatingActionButton: const AddNoteButton(),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(appTitle),
    );
  }

  ListView listViewBuilder(Box<Note> box, BuildContext context) {
    return ListView.builder(
        itemCount: box.length,
        itemBuilder: (ctx, i) {
          final note = box.getAt(i);
          final Widget? imageFile =
              Image.file(File(note?.imageUrl.toString() ?? ""));
          final Widget? imageNetwork =
              Image.network(note?.imageUrl.toString() ?? "");
          return Padding(
            padding: context.paddingLow / 3,
            child: Card(
              elevation: context.normalValue,
              child: Padding(
                padding: context.paddingLow,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => NoteView(
                            title: note?.title?.toString() ?? "",
                            description: note?.description?.toString() ?? "",
                            imageUrl: note?.imageUrl ?? ""),
                      ),
                    );
                  },
                  leading:
                      note?.imageUrl == noImageUrl ? imageNetwork : imageFile,
                  title: Text(note?.title?.toString() ?? ""),
                  trailing: IconButton(
                      onPressed: () {
                        box.deleteAt(i);
                      },
                      icon: const Icon(Icons.delete)),
                ),
              ),
            ),
          );
        });
  }
}

class AddNoteButton extends StatelessWidget {
  const AddNoteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const addNoteView(),
          ),
        );
      },
      label: Text(addNote),
    );
  }
}
