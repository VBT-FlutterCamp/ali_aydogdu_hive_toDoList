import 'dart:io';

import 'package:hive/hive.dart';
import "package:hive_flutter/hive_flutter.dart";
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'package:images_picker/images_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/strings.dart';
import 'package:kartal/kartal.dart';

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

  getImage() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  submitData() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      Hive.box<Note>("note").add(Note(
          title: title ?? "",
          description: description ?? "",
          imageUrl: _image?.path ?? noImageUrl));
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
        title: Text(addANote),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                titleTextForm(),
                descriptionTextForm(),
                sizedBox(),
                _image == null ? Container() : Image.file(File(_image!.path))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: cameraButton(),
    );
  }

  TextFormField titleTextForm() {
    return TextFormField(
      autocorrect: false,
      decoration: InputDecoration(
        label: Text(labelTitle),
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
    );
  }

  TextFormField descriptionTextForm() {
    return TextFormField(
      minLines: 2,
      maxLines: 10,
      autocorrect: false,
      decoration: InputDecoration(
        label: Text(labelDescription),
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
    );
  }

  SizedBox sizedBox() {
    return SizedBox(
      height: context.dynamicHeight(0.2),
    );
  }

  FloatingActionButton cameraButton() {
    return FloatingActionButton(
      onPressed: getImage,
      child: const Icon(Icons.camera_alt),
    );
  }
}
