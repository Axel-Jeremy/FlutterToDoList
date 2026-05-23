import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoScreen(),
    );
  }
}

//class buat simpen judul sama sudah beres/belum
class TodoItem {
  String title;
  bool isDone;

  //constructor
  TodoItem({required this.title, this.isDone = false});
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<TodoItem> todos = [];
  final TextEditingController _textController = TextEditingController();

  void _addTodo() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        todos.add(TodoItem(title: _textController.text));
        _textController.clear();
      });
    }
  }

  void _deleteTodo(int index) {
    setState(() {
      todos.removeAt(index); // hapus item berdasarkan urutannya di list
    });
  }

  void _toggleDone(int index) {
    setState(() {
      todos[index].isDone = !todos[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To Do List',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Input new to do...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _addTodo,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  ),
                  child: Text(
                    'Add',
                    style:
                    TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(),

          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: ListTile(
                    leading: Checkbox(
                      value: todos[index].isDone,
                      onChanged: (bool? value) {
                        _toggleDone(index); // Panggil fungsi ubah status saat dicentang
                      },
                    ),

                    title: Text(
                      todos[index].title,
                      style: TextStyle(
                        decoration: todos[index].isDone //branching tulisan dicoret ato ga sesuai isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        // branching warna abu kalo udah beres
                        color: todos[index].isDone ? Colors.grey : Colors.black,
                      ),
                    ),

                    trailing: ElevatedButton(
                      onPressed: (){
                        _deleteTodo(index);
                      },
                      child: Text(
                        'Delete',
                        style:
                        TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}