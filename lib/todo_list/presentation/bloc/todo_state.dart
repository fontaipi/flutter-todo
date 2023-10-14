import 'package:equatable/equatable.dart';
import 'package:todo/todo_list/domain/entities/todo.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object?> get props => [];
}

class TodosLoadingState extends TodosState {
  const TodosLoadingState();
}

class TodosDoneState extends TodosState {
  final List<TodoEntity> todoItems;

  const TodosDoneState(this.todoItems);

  @override
  List<Object?> get props => [todoItems];
}

class TodosError extends TodosState {
  final String errorMessage;
  final timestamp = DateTime.now().millisecondsSinceEpoch;

  TodosError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, timestamp];
}
