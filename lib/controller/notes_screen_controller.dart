import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app_jan/core/constants/color_constants.dart';

class NoteScreenController {
  static List notesListKeys = [];

  static List<Color> colorList = [
    ColorConstants.clr1,
    ColorConstants.clr2,
    ColorConstants.clr3,
    ColorConstants.clr4,
  ];

  // hive reference
  static var myBox = Hive.box("noteBox");

  //add note

  static getInitKeys() {
    notesListKeys = myBox.keys.toList();
  }

  static Future<void> addNote({
    required String title,
    required String des,
    required String date,
    int clrIndex = 0,
  }) async {
    await myBox.add({
      "title": title,
      "des": des,
      "date": date,
      "colorIndex": clrIndex,
    });
    notesListKeys = myBox.keys.toList();
  }

  static Future<void> deleteNote(var key) async {
    await myBox.delete(key);
    notesListKeys = myBox.keys.toList();
  }

  static Future<void> editNote({
    required var key,
    required String title,
    required String des,
    required String date,
    int clrIndex = 0,
  }) async {
    await myBox.put(key, {
      "title": title,
      "des": des,
      "date": date,
      "colorIndex": clrIndex,
    });
  }
}
