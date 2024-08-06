import 'package:flutter/material.dart';
import 'package:todos/widgets/add.dart';
import 'package:todos/widgets/detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _todos = [
    {
      "name": "Learn Navigation",
      "description": "Learn Basic Navigation",
      "place": "Online meet",
      "completed":true
    },
    {
      "name": "Learn ListView",
      "description": "ListView and ListTile",
      "place": "Online Meet",
      "completed":true

    },
    {
      "name": "Have Lunch",
      "description": "1h lunch break",
      "place": "Own home/office",
      "completed":true

    },
    {
      "name": "Storage",
      "description": "Using shared pref",
      "place": "Online meet",
      "completed":false

    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home Page",style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _todos.length,
          itemBuilder: (BuildContext context, int index) {
            // return Container(
            //   height: 50,
            //   color: Colors.amber,
            //   child: Center(child: Text(_todos[index]["name"]!)),
            // );
            return Card(
              color: Colors.redAccent,
              child: ListTile(
                leading: _todos[index]["completed"] == true ? Icon(Icons.check,color: Colors.white,) : SizedBox(),
                title: Text(_todos[index]["name"]!,style: TextStyle(color: Colors.white),),
                subtitle: Text(_todos[index]["place"]!,style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.chevron_right, color: Colors.white,),
                onTap: () async {
                  var response = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailPage(item: _todos[index],index: index,)));
                  if (response != null){
                    if (response["action"] == 1){
                    // Delete
                    _todos.removeAt(response["index"]);
                    setState(() {
                    _todos;
                    });
                  }
                  else {
                  // Mark as complete
                      _todos[response["index"]]["completed"] = ! _todos[response["index"]]["completed"];
                      setState(() {
                      _todos;
                    });
                  }
                  }
                  },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        onPressed: () async {
          print("Add pressed");
          var item = await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage()));
          if (item != null){
            _todos.add(item);
            setState(() {
              _todos ; // same as _todos = _todos (refresh the UI)
            });
          }

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
