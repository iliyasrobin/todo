import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<TodoItem> _todos = [];
  final TextEditingController _controller = TextEditingController();

  // Add a new task
  void _addTodo() {
    if (_controller.text.isEmpty) return;

    setState(() {
      _todos.add(TodoItem(title: _controller.text));
    });
    _controller.clear();
  }

  // Mark a task as complete
  void _toggleComplete(int index) {
    setState(() {
      _todos[index].isComplete = !_todos[index].isComplete;
    });
  }

  // Delete a task
  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  // Build the task list
  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            _todos[index].title,
            style: TextStyle(
              decoration: _todos[index].isComplete
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteTodo(index),
          ),
          onTap: () => _toggleComplete(index),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do App"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Input field to add new task
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Enter task",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTodo,
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: _buildTodoList(),
            ),
          ],
        ),
      ),
    );
  }
}

// Task model
class TodoItem {
  String title;
  bool isComplete;

  TodoItem({required this.title, this.isComplete = false});
}
