import 'dart:io';

import 'package:hive/hive.dart';
import "package:hive_flutter/hive_flutter.dart";
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'package:images_picker/images_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../models/note.dart';

class addNoteView extends StatefulWidget {
  const addNoteView({Key? key}) : super(key: key);

  @override
  State<addNoteView> createState() => _addNoteViewState();
}

class _addNoteViewState extends State<addNoteView> {
  final _formKey = GlobalKey<FormState>();
  XFile? _image;
  String? title;
  String? description;

  Future getImage() async {
    setState(() async {
      _image = await ImagePicker.platform.getImage(source: ImageSource.camera);
    });
  }

  submitData() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      Hive.box<Note>("note").add(Note(
          title: title ?? "",
          description: description ?? "",
          imageUrl: _image?.path ?? ""));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: submitData, icon: const Icon(Icons.save_outlined))
        ],
        title: Text("Add  a Note"),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                TextFormField(
                  autocorrect: false,
                  decoration: const InputDecoration(
                    label: Text("Title"),
                  ),
                  onChanged: (val) {
                    setState(() {
                      if (title == null) {
                        title = "";
                      } else {
                        title = val;
                      }
                    });
                  },
                ),
                TextFormField(
                  minLines: 2,
                  maxLines: 10,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    label: Text("Description"),
                  ),
                  onChanged: (val) {
                    setState(() {
                      if (description == null) {
                        description = "";
                      } else {
                        description = val;
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                _image == null
                    ? Container(
                        height: 50,
                        color: Colors.red,
                      )
                    : Image.file(File(_image!.path))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
