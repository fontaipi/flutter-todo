import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:todo/todo_list/data/models/todo.dart';
import 'package:todo/todo_list/domain/entities/todo.dart';
import 'package:todo/todo_list/domain/repository/todo_item_repository.dart';

class TodoRepositoryImpl implements TodoItemRepository {
  var todos = <TodoModel>[
    const TodoModel(
      id: 1,
      title: 'Todo 1',
      description: 'Description 1',
      isCompleted: false,
    ),
    const TodoModel(
      id: 2,
      title: 'Todo 2',
      description: 'Description 2',
      isCompleted: true,
    ),
    const TodoModel(
      id: 3,
      title: 'Todo 3',
      description: 'Description 3',
      isCompleted: false,
    ),
  ];

  @override
  Future<Either<String, TodoModel>> createTodoItem(TodoEntity todo) async {
    todos.add(todo.copyWith(id: todos.map((e) => e.id).reduce(max) + 1));
    return Future.value(Right(TodoModel.fromEntity(todo)));
  }

  @override
  Future<Either<int, bool>> deleteTodoItem(int id) async {
    todos.removeWhere((element) => element.id == id);
    return Future.value(const Right(true));
  }

  @override
  Future<Either<String, TodoModel>> getTodoItem(int id) async {
    return Future.value(Right(todos[id]));
  }

  @override
  Future<Either<String, List<TodoModel>>> getTodoItems() async {
    return Future.value(Right([...todos]));
  }

  @override
  Future<Either<String, TodoModel>> updateTodoItem(TodoEntity todo) async {
    final todoModel = TodoModel.fromEntity(todo);
    todos[todos.indexWhere((element) => element.id == todo.id)] = todoModel;
    return Future.value(Right(todoModel));
  }
}
