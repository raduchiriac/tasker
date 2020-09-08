import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  Widget _createTask(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          ListTile(
            title: Text("Hello",
                style: TextStyle(decoration: TextDecoration.lineThrough)),
            subtitle: Text("Nov 11th 2020 • Low"),
            trailing: Checkbox(
                onChanged: (value) {
                  print(value);
                },
                activeColor: Theme.of(context).primaryColor,
                value: true),
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
          onPressed: () => print('Navigate to Add Task Screen'),
        ),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 80),
          itemCount: 11,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "My tasks",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "1 of 10",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ));
            }
            return _createTask(index);
          },
        ));
  }
}
