import 'package:flutter/material.dart';

class NotesTile extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onEdit;

  final VoidCallback onDelete;
  final VoidCallback onTap;

  const NotesTile(
      {Key? key,
      required this.title,
      required this.description,
      required this.onEdit,
      
      required this.onDelete,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.blue,
            ),
          ],
          color: const Color.fromARGB(255, 211, 232, 255),
          border: Border.all(width: 2, color: Colors.blue),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          subtitle: Text(
            description,
            style: TextStyle(fontSize: 16, color: Colors.blueGrey),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.lightBlue,
                ),
                onPressed: onEdit,
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.lightBlue,
                ),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
