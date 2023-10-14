import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/todo_list/domain/entities/todo.dart';
import 'package:todo/todo_list/presentation/bloc/todo_bloc.dart';
import 'package:todo/todo_list/presentation/bloc/todo_state.dart';

import '../../bloc/todo_event.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodosState>(
      buildWhen: (previous, current) => current is! TodosError,
      builder: (context, state) {
        switch (state.runtimeType) {
          case TodosLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case TodosDoneState:
            return _buildTodoItemsList((state as TodosDoneState).todoItems);
          default:
            return const Center(
              child: Text('Aucun élément à afficher'),
            );
        }
      },
    );
  }

  _buildTodoItemsList(List<TodoEntity> todoItems) {
    return ListView.builder(
      itemCount: todoItems.length,
      itemBuilder: (context, index) {
        final todoItem = todoItems[index];
        // todo item with title and description as subtitle and checkbox
        return ListTile(
            leading: Checkbox(
              value: todoItem.isCompleted,
              onChanged: (value) {
                final updatedTodoItem = todoItem.copyWith(isCompleted: value!);
                context
                    .read<TodoBloc>()
                    .add(UpdateTodo(todoItem: updatedTodoItem));
              },
            ),
            title: Text(todoItem.title,
                style: TextStyle(
                    decoration: todoItem.isCompleted
                        ? TextDecoration.lineThrough
                        : null)),
            subtitle: Text(todoItem.description,
                style: TextStyle(
                    decoration: todoItem.isCompleted
                        ? TextDecoration.lineThrough
                        : null)),
            trailing: IconButton(
              icon: Icon(Icons.delete,
                  color: Theme.of(context).colorScheme.error),
              onPressed: () {
                context.read<TodoBloc>().add(DeleteTodo(id: todoItem.id));
              },
            ));
      },
    );
  }
}
