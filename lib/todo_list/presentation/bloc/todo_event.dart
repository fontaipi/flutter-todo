import 'package:equatable/equatable.dart';
import 'package:todo/todo_list/domain/entities/todo.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class GetTodos extends TodoEvent {
  const GetTodos();
}

class CreateTodo extends TodoEvent {
  final TodoEntity todoItem;

  const CreateTodo({required this.todoItem});

  @override
  List<Object?> get props => [todoItem];
}

class UpdateTodo extends TodoEvent {
  final TodoEntity todoItem;

  const UpdateTodo({required this.todoItem});

  @override
  List<Object?> get props => [todoItem];
}

class DeleteTodo extends TodoEvent {
  final int id;

  const DeleteTodo({required this.id});

  @override
  List<Object?> get props => [id];
}
