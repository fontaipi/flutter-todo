import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/injection_container.dart';
import 'package:todo/todo_list/presentation/bloc/todo_bloc.dart';
import 'package:todo/todo_list/presentation/bloc/todo_event.dart';
import 'package:todo/todo_list/presentation/pages/home/todos.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (context) => getIt()..add(const GetTodos()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Todos(),
      ),
    );
  }
}
