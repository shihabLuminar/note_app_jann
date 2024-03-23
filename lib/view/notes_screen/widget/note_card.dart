import 'package:flutter/material.dart';
import 'package:note_app_jan/core/constants/color_constants.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: ColorConstants.clr2, borderRadius: BorderRadius.circular(13)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Title"),
              Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 15),
                  Icon(Icons.delete)
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Text("Description"),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text("Date"), SizedBox(width: 20), Icon(Icons.share)],
          )
        ],
      ),
    );
  }
}
