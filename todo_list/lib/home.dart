import 'package:flutter/material.dart';
import 'package:todo_list/add_task.dart';
import 'tasks.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> tasks = [];

  void toggleCheckBox(int index, bool? value) {
    setState(() {
      tasks[index].isChecked = value ?? false;
    });
  }

  void addTaskCallback(Task newTask) {
    setState(() {
      tasks.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.all(15.0),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return AddTask(
                  tasklist: tasks,
                  onTaskAdded: addTaskCallback,
                );
              },
            );
          },
          backgroundColor: Colors.blueGrey[900],
          foregroundColor: Colors.white38,
          child: Icon(Icons.add),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        color: Colors.blueGrey[900],
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "To-Do List",
                  style: TextStyle(
                    color: Colors.white38,
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                    decoration: TextDecoration.none,
                  ),
                ),Expanded(child: SizedBox(width: 50,)),
                TextButton(
                  onPressed: () {
                    setState(() {
                      tasks.clear();
                    });
                  },
                  child: Icon(Icons.refresh),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white38,
                      foregroundColor: Colors.blueGrey[900]),
                )
              ],
            ),
            Row(
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${tasks.length} task(s) remaining",
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ), SizedBox(width: 1,)
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return BuildListTile(
                      tasks[index].label,
                      tasks[index].isChecked,
                      (value) => toggleCheckBox(index, value),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildListTile extends StatelessWidget {
  final bool isChecked;
  final String trailText;
  final void Function(bool?) toggleChkBox;

  BuildListTile(this.trailText, this.isChecked, this.toggleChkBox);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        trailText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.blueGrey[900],
          decoration:
              isChecked ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: BuildChkBox(isChecked, toggleChkBox),
    );
  }
}

class BuildChkBox extends StatelessWidget {
  final bool isChecked;
  final void Function(bool?) toggleChkBox;

  BuildChkBox(this.isChecked, this.toggleChkBox);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.blueGrey[900],
      value: isChecked,
      onChanged: toggleChkBox,
    );
  }
}
