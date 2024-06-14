import 'package:flutter/material.dart';
import 'tasks.dart';

class AddTask extends StatefulWidget {
  final List<Task> tasklist;
  final Function(Task) onTaskAdded;

  AddTask({required this.tasklist, required this.onTaskAdded});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _controller = TextEditingController();

  void addToList() {
    if (_controller.text.isNotEmpty) {
      final newTask = Task(label: _controller.text);
      widget.onTaskAdded(newTask);  // Notify the Home widget
      _controller.clear();  // Clear the text field
      Navigator.pop(context);  // Close the bottom sheet after adding the task
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Add Task",
              style: TextStyle(
                color: Colors.white38,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              autofocus: true,
              cursorColor: Colors.white38,
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: addToList,
              style: TextButton.styleFrom(
                backgroundColor: Colors.white38,
              ),
              child: Icon(
                Icons.add,
                color: Colors.blueGrey[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
