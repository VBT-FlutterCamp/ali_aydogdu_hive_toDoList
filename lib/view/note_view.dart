import 'dart:io';
import 'dart:js';

import 'package:flutter/material.dart';
import '../constants/strings.dart';
import 'package:kartal/kartal.dart';

class NoteView extends StatelessWidget {
  final String? title;
  final String? description;
  final String? imageUrl;
  const NoteView(
      {Key? key,
      required this.title,
      required this.description,
      required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title.toString()),
      ),
      body: listViewBuilder(),
    );
  }

  SafeArea listViewBuilder() {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.all(12),
      child: ListView(
        children: [
          Text(
            description?.toString() ?? "",
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(50)),
              child: imageUrl == noImageUrl
                  ? Image.network(noImageUrl)
                  : Image.file(File(imageUrl ?? ""))),
        ],
      ),
    ));
  }
}
