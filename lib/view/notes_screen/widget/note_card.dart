// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:note_app_jan/controller/notes_screen_controller.dart';
import 'package:note_app_jan/core/constants/color_constants.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.title,
    required this.des,
    required this.date,
    required this.clrindex,
    this.onDeletePressed,
    this.onEditPressed,
  });

  final String title;
  final String des;
  final String date;
  final int clrindex;
  final void Function()? onDeletePressed;
  final void Function()? onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: NoteScreenController.colorList[clrindex],
          borderRadius: BorderRadius.circular(13)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Row(
                children: [
                  InkWell(onTap: onEditPressed, child: Icon(Icons.edit)),
                  SizedBox(width: 15),
                  InkWell(onTap: onDeletePressed, child: Icon(Icons.delete))
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(des),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text(date), SizedBox(width: 20), Icon(Icons.share)],
          )
        ],
      ),
    );
  }
}
