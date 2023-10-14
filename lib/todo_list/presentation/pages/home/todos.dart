import 'package:flutter/material.dart';
import 'package:todo/todo_list/presentation/bloc/todo_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/todo_list/domain/entities/todo.dart';
import 'package:todo/todo_list/presentation/pages/home/todo_screen.dart';
import 'package:todo/todo_list/presentation/bloc/todo_event.dart';
import 'package:todo/todo_list/presentation/bloc/todo_state.dart';

class Todos extends StatefulWidget {
  const Todos({super.key});

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocListener<TodoBloc, TodosState>(
        listener: (context, state) {
          if (state is TodosError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        child: const TodoScreen(),
      ),
      floatingActionButton: _buildFab(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Todo List'),
    );
  }

  Widget _buildFab(context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Ajouter un élément'),
            icon: const Icon(Icons.add),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                      controller: _titleController,
                      autofocus: true,
                      decoration: const InputDecoration(
                          labelText: 'Titre', hintText: 'Entrez le titre'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un titre';
                        }
                        return null;
                      }),
                  TextFormField(
                    controller: _descriptionController,
                    autofocus: true,
                    decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: 'Entrez la description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une description';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Annuler'),
                child: const Text('Annuler'),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _onCreateTodo(
                      context,
                      TodoEntity(
                        id: 0,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        isCompleted: false,
                      ),
                    );
                    _titleController.clear();
                    _descriptionController.clear();

                    Navigator.pop(context, 'Ajouter');
                  }
                },
                child: const Text('Ajouter'),
              ),
            ],
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  void _onCreateTodo(BuildContext context, TodoEntity todo) {
    BlocProvider.of<TodoBloc>(context).add(CreateTodo(todoItem: todo));
  }
}
