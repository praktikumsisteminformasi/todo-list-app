import 'package:flutter/material.dart';
import 'package:todo_list_app/pages/add_todo_page.dart';
import 'package:todo_list_app/pages/todos_page.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      routes: {
        '/': (context) => const TodosPage(),
        '/add-todo': (context) => const AddTodoPage()
      },
    );
  }
}