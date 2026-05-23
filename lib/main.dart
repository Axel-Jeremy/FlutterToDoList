import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TodoScreen(),
  ),
  );
}

class TodoItem {
  String title;
  bool isDone;
  int priority; // 1 = High, 2 = Medium, 3 = Low

  //constructor
  TodoItem({required this.title, this.isDone = false, required this.priority});
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<TodoItem> todos = [];
  final TextEditingController textController = TextEditingController();

  int selectedPriority = 3; //variabel simpen value radio button default = low

  //function buat item baru kalo tombol add dipencet
  void _addTodo() {
    if (textController.text.isNotEmpty) {
      setState(() {
        todos.add(TodoItem(
          title: textController.text,
          priority: selectedPriority,
        ));
        textController.clear(); //apus input sebelumnya
      });
    }
  }

  void _deleteTodo(int index) { //apus item kalo tombol delete dipencet
    setState(() {
      todos.removeAt(index);
    });
  }

  void _deleteAll(){
    setState(() {
      todos.clear();
    });
  }

  void _toggleDone(int index) { //kalo tombol check dipencet
    setState(() {
      todos[index].isDone = !todos[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textController,
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
                        backgroundColor: Color(0xFF42A5F5),
                      ),
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Priority:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        )
                    ),

                    RadioGroup<int>( //radio group simpen value int
                      groupValue: selectedPriority,
                      onChanged: (int? value) {
                        setState(() {
                          selectedPriority = value!; //cek value gaboleh null
                        });
                      },
                      child: Row(
                        children: [
                          Radio<int>(
                              value: 1
                          ),
                          Text(
                              'High'
                          ),

                          Radio<int>(
                              value: 2
                          ),
                          Text(
                              'Med'
                          ),

                          Radio<int>(
                              value: 3
                          ),
                          Text(
                              'Low'
                          ),
                        ],
                      ),
                    ),
                  ],
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
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: ListTile(
                    leading: Checkbox(
                      value: todos[index].isDone,
                      onChanged: (bool? value) {
                        _toggleDone(index);
                      },
                    ),
                    title: Text(
                      todos[index].title,
                      style: TextStyle(
                        decoration: todos[index].isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: todos[index].isDone ? Colors.grey : Colors.black,
                      ),
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min, //menghindari error
                      children: [
                        Icon(
                          Icons.circle,
                          size: 14,
                          color: todos[index].priority == 1
                              ? Colors.red
                              : (todos[index].priority == 2 ? Colors.orange : Colors.green),
                        ),
                        SizedBox(width: 25), //buat kasih space antar icon dan button

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[700],
                          ),

                          onPressed: () {
                            _deleteTodo(index);
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _deleteAll,
        label: Text(
          'Remove All',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        icon: Icon(
          Icons.delete_forever_rounded,
          color: Colors.white,
        ),
        backgroundColor: Colors.red[700],
      ),
    );
  }
}