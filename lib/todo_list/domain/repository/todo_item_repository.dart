import 'package:dartz/dartz.dart';
import 'package:todo/todo_list/domain/entities/todo.dart';

abstract class TodoItemRepository {
  Future<Either<String, TodoEntity>> getTodoItem(int id);
  Future<Either<String, List<TodoEntity>>> getTodoItems();
  Future<Either<String, TodoEntity>> createTodoItem(TodoEntity todo);
  Future<Either<String, TodoEntity>> updateTodoItem(TodoEntity todo);
  Future<Either<int, bool>> deleteTodoItem(int id);
}