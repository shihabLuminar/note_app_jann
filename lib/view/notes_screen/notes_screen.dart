import 'package:flutter/material.dart';
import 'package:note_app_jan/controller/notes_screen_controller.dart';
import 'package:note_app_jan/view/notes_screen/widget/note_card.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  int selectedClrIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        itemBuilder: (context, index) => NoteCard(
          title: NoteScreenController.notesList[index]["title"],
          date: NoteScreenController.notesList[index]["date"],
          des: NoteScreenController.notesList[index]["des"],
          clrindex: NoteScreenController.notesList[index]["colorIndex"],
          onDeletePressed: () {
            NoteScreenController.deleteNote(index);
            setState(() {});
          },
          onEditPressed: () {
            titleController.text =
                NoteScreenController.notesList[index]["title"];
            desController.text = NoteScreenController.notesList[index]["des"];

            dateController.text = NoteScreenController.notesList[index]["date"];

            selectedClrIndex =
                NoteScreenController.notesList[index]["colorIndex"];

            customBottomSheet(context: context, isEdit: true, index: index);
          },
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: NoteScreenController.notesList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleController.clear();
          desController.clear();

          dateController.clear();

          selectedClrIndex = 0;

          customBottomSheet(context: context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // to build bottom sheet
  Future<dynamic> customBottomSheet(
      {required BuildContext context, bool isEdit = false, int? index}) {
    return showModalBottomSheet(
      backgroundColor: Colors.grey.shade800,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, bottomSetState) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isEdit ? "Update Note" : "Add Note",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "Title",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: desController,
                  maxLines: 4,
                  decoration: InputDecoration(
                      hintText: "Description",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(
                      hintText: "Date",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      suffixIcon: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.date_range_rounded,
                            color: Colors.black,
                            size: 25,
                          ))),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      4,
                      (index) => InkWell(
                            onTap: () {
                              selectedClrIndex = index;
                              print(selectedClrIndex);
                              bottomSetState(() {});
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: selectedClrIndex == index ? 5 : 0),
                                  borderRadius: BorderRadius.circular(10),
                                  color: NoteScreenController.colorList[index]),
                            ),
                          )),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        if (isEdit == true) {
                          NoteScreenController.editNote(
                              index: index!,
                              title: titleController.text,
                              des: desController.text,
                              date: dateController.text,
                              clrIndex: selectedClrIndex);
                        } else {
                          NoteScreenController.addNote(
                              title: titleController.text,
                              des: desController.text,
                              date: dateController.text,
                              clrIndex: selectedClrIndex);
                        }

                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Container(
                        width: 100,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: Text(
                            isEdit == true ? "Edit" : "Add",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 100,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
