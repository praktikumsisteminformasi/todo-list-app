import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  List<Map> todos = [];

  void fetchTodos() async {
    Response response = await dio.get('https://jsonplaceholder.typicode.com/todos');
    
    setState(() {
      todos = List<Map>.from(response.data);
    });
  }

  void toggleTodoStatus(int index, bool? isComplete) {
    setState(() {
      todos[index]['completed'] = isComplete;
    });
  }

  @override
  void initState() {
    fetchTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todos App',
          style: TextStyle(color: Colors.white)
        ),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: todos.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          return TodoItem(
            index: index,
            title: todos[index]['title'],
            completed: todos[index]['completed'],
            toggleTodoStatus: toggleTodoStatus,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-todo');
        },
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  final int index;
  final String title;
  final bool completed;
  final void Function(int index, bool? isComplete) toggleTodoStatus;

  const TodoItem({
    super.key,
    required this.index,
    required this.title,
    required this.completed,
    required this.toggleTodoStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shadowColor: Colors.blueGrey,
      child: ListTile(
        title: Text(title),
        trailing: Checkbox(
          checkColor: Colors.white,
          value: completed,
          onChanged: (bool? isChecked) {
            toggleTodoStatus(index, isChecked);
          },
        ),
      ),
    );
  }
}