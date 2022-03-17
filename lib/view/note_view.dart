import 'dart:io';

import 'package:flutter/material.dart';

class noteView extends StatelessWidget {
  final String? title;
  final String? description;
  final String? imageUrl;
  const noteView(
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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
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
                child: imageUrl == "https://kocel.com.tr/img/notfound.png"
                    ? Image.network("https://kocel.com.tr/img/notfound.png")
                    : Image.file(File(imageUrl ?? ""))),
          ],
        ),
      )),
    );
  }
}
