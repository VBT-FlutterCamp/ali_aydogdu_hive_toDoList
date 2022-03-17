import "package:hive_flutter/hive_flutter.dart";
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? imageUrl;

  Note({
    required this.title,
    required this.description,
    this.imageUrl,
  });
}
