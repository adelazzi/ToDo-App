import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../data/database.dart';
import '../util/NotesTile.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _myBox = Hive.box('mybox');
  final NotesDatabase db = NotesDatabase();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (_myBox.get("NOTESLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void saveNewNote() {
    setState(() {
      db.notesList.add({
        "title": _titleController.text,
        "content": _contentController.text,
      });
      _titleController.clear();
      _contentController.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewNote() {
    _titleController.text = '';
    _contentController.text = '';
    showDialog(
      context: context,
      builder: (context) {
        return DialogBoxNotes(
          titleController: _titleController,
          contentController: _contentController,
          onSave: saveNewNote,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteNote(int index) {
    setState(() {
      db.notesList.removeAt(index);
    });
    db.updateDataBase();
  }

  void editNoteTitle(int index, String newTitle) {
    setState(() {
      db.notesList[index]['title'] = newTitle;
    });
    db.updateDataBase();
  }

  void editNoteContent(int index, String newContent) {
    setState(() {
      db.notesList[index]['content'] = newContent;
    });
    db.updateDataBase();
  }

  void startEditNote(BuildContext context, int index) {
    _titleController.text = db.notesList[index]['title'];
    _contentController.text = db.notesList[index]['content'];
    showDialog(
      context: context,
      builder: (context) {
        return DialogBoxNotes(
          titleController: _titleController,
          contentController: _contentController,
          onSave: () {
            editNoteTitle(index, _titleController.text);
            editNoteContent(index, _contentController.text);
            Navigator.of(context).pop();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void showNoteDetails(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.lightBlue.shade100,
          title: Text(title,style: TextStyle(color: Colors.blue),),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  content,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close',style: TextStyle(color: Colors.blue),),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 232, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 2,
                color: Theme.of(context).primaryColor,
              ),
            ),
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              icon: Icon(
                Icons.task,
                color: Colors.lightBlue,
              ),
            ),
          )
        ],
        backgroundColor: Color.fromARGB(255, 211, 232, 255),
        centerTitle: true,
        title: Text(
          'Notes',
          style: TextStyle(
            color: Colors.lightBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewNote,
        child: Icon(
          Icons.add,
          color: Colors.blue,
        ),
        backgroundColor: Color.fromARGB(255, 211, 232, 255),
      ),
      body: db.notesList.isEmpty
          ? Center(
              child: Text(
                'No Notes yet \n Use the + button to add notes.',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: db.notesList.length,
              itemBuilder: (context, index) {
                return NotesTile(
                    title: db.notesList[index]['title'],
                    description: db.notesList[index]['content'],
                    onEdit: () => startEditNote(context, index),
                    onDelete: () => deleteNote(index),
                    onTap: () => showNoteDetails(
                          db.notesList[index]['title'],
                          db.notesList[index]['content'],
                        ));
              },
            ),
    );
  }
}


class DialogBoxNotes extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBoxNotes({
    Key? key,
    required this.titleController,
    required this.contentController,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  _DialogBoxNotesState createState() => _DialogBoxNotesState();
}

class _DialogBoxNotesState extends State<DialogBoxNotes> {
  String? errorMessage;

  void _validateAndSave() {
    if (widget.titleController.text.isEmpty || widget.contentController.text.isEmpty) {
      setState(() {
        errorMessage = 'Title and Content cannot be empty';
      });
      return;
    }
    widget.onSave();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.lightBlue.shade100,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: widget.titleController,
            decoration: InputDecoration(
              hintText: 'Title',
              errorText: errorMessage,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: widget.contentController,
            decoration: InputDecoration(
              hintText: 'Content',
              errorText: errorMessage,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: widget.onCancel,
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        TextButton(
          onPressed: _validateAndSave,
          child: Text(
            'Save',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
