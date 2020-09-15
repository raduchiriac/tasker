import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasker/helpers/db_helper.dart';
import 'package:tasker/models/task_model.dart';
import 'package:tasker/screens/add_task_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  Future<List<Task>> _taskList;

  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  @override
  void initState() {
    super.initState();
    _updateTaskList();
  }

  _updateTaskList() {
    setState(() {
      _taskList = DBHelper.instance.getTaskList();
    });
  }

  Widget _createTask(Task task) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          ListTile(
            title: Text(task.title,
                style: TextStyle(
                    decoration: task.status == 0
                        ? TextDecoration.none
                        : TextDecoration.lineThrough,
                    fontSize: 20,
                    fontWeight:
                        task.status == 0 ? FontWeight.w500 : FontWeight.w200)),
            subtitle: Row(
              children: [
                task.date.isBefore(DateTime.now())
                    ? Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Icon(
                          task.status == 0 ? Icons.alarm : Icons.alarm_off,
                          size: 14,
                        ),
                      )
                    : SizedBox.shrink(),
                Text(
                  '${_dateFormatter.format(task.date)}',
                  style: TextStyle(
                      decoration: task.status == 0
                          ? TextDecoration.none
                          : TextDecoration.lineThrough),
                ),
                Text(' • '),
                Text('${task.priority}',
                    style: task.status == 0
                        ? TextStyle(
                            color: Theme.of(context).primaryColor,
                          )
                        : TextStyle(decoration: TextDecoration.lineThrough)),
              ],
            ),
            trailing: Checkbox(
                onChanged: (value) {
                  task.status = value ? 1 : 0;
                  DBHelper.instance.updateTask(task);
                  _updateTaskList();
                },
                activeColor: Theme.of(context).primaryColor,
                value: task.status == 1 ? true : false),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AddTaskScreen(
                        updateTaskList: _updateTaskList, task: task))),
          ),
          Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AddTaskScreen(
                      updateTaskList: _updateTaskList,
                    ))),
      ),
      body: FutureBuilder(
        future: _taskList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final int completedTaskCount = snapshot.data
              .where((Task task) => task.status == 1)
              .toList()
              .length;
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 70),
            itemCount: 1 + snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tasks",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 6, top: 6),
                        child: Text(
                          '$completedTaskCount of ${snapshot.data.length}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return _createTask(snapshot.data[index - 1]);
            },
          );
        },
      ),
    );
  }
}
