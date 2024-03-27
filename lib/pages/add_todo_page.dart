import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  bool isLoading = false;

  void addTodo() async {
    // Kode "formKey.currentState!.validate()" dipakai untuk memvalidasi Widget TextFormField yang ada di widget Form
    if (formKey.currentState!.validate()) {
      // Loading kan tombol-nya
      setState(() {
        isLoading = true;
      });

      // Tembak API untuk menambah todo
      // Kita pakai HTTP Method POST karena mau nambah data todos yang ada di server
      Response response = await dio.post(
        'https://jsonplaceholder.typicode.com/todos',
        data: { 'title': titleController.text }
      );

      if (response.statusCode == 201) {
        // Tampilkan pesan sukses menggunakan Snackbar
        const snackBar = SnackBar(content: Text('Berhasil menambah todo.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        // Kembali ke halaman awal
        Navigator.pop(context);
      }

      // Setop loading tombolnya
      setState(() {
        isLoading = false;
      });
    }
  }

  String? validateTitle(String? title) {
    // Cek apakah title-nya belum diisi
    if (title!.trim().isEmpty) {
      return 'Judul todo harus diisi';
    }

    return null;
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
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Judul todo
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Judul')
                ),
                validator: validateTitle,
              ),
          
              const SizedBox(height: 20,),
          
              // Tombol tambah todo
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : addTodo,
                  child: Builder(
                    builder: (context) {
                      // Kalau loading, tampilkan animasi loading
                      if (isLoading) {
                        return const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        );
                      }

                      return const Text('Tambah todo');
                    }
                  )
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}