import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TodoPage(),
    ),
  );
}

class TodoItem { //objek buat nyimpen input user
  String title;
  bool isDone;
  int priority; // 1 = High, 2 = Medium, 3 = Low

  //constructor
  TodoItem({required this.title, this.isDone = false, required this.priority});
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<TodoItem> todos = [];
  final TextEditingController textController = TextEditingController();

  int selectedPriority = 3; //variabel simpen value radio button defaultnya low

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

  void _deleteAll(){ //apus semua item kalo tombol delete all dipencet
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
                    Expanded( //buat stretch
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

                    SizedBox(width: 20), //jarak antar input dan button

                    ElevatedButton( //button add buat nambah item to do
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

                Row( //baris buat pilih prioritas
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Priority:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        )
                    ),

                    RadioGroup<int>( //radio group simpen value int, 1 paling tinggi
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
                          Text('High'),

                          Radio<int>(
                              value: 2
                          ),
                          Text('Med'),

                          Radio<int>(
                              value: 3
                          ),
                          Text('Low'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Divider(), //garis pemisah

          Expanded(
            child: ListView.builder( //daftar bisa discroll
              itemCount: todos.length, //jumlah baris
              itemBuilder: (context, index) { //loop seperti mapping
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: ListTile( //buat bagi jadi 3bagian
                    leading: Checkbox( //bagian kiri
                      value: todos[index].isDone,
                      onChanged: (bool? value) {
                        _toggleDone(index);
                      },
                    ),
                    title: Text( //bagian tengah
                      todos[index].title,
                      style: TextStyle(
                        decoration: todos[index].isDone //kalo udah done text dicoret
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: todos[index].isDone ? Colors.grey : Colors.black,
                      ),
                    ),

                    trailing: Row( //bagian kanan
                      mainAxisSize: MainAxisSize.min, //biar ga error overflow layout
                      children: [
                        Icon(
                          Icons.circle,
                          size: 14,
                          color: todos[index].priority == 1 //branching prioritas to do
                              ? Colors.red
                              : (todos[index].priority == 2 ? Colors.orange : Colors.green),
                        ),
                        SizedBox(width: 25), //buat kasih space antar icon dan button

                        ElevatedButton( //tombol delete per item
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
      floatingActionButton: FloatingActionButton.extended( //tombol apus semua to do
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