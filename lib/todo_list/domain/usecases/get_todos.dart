import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../entities/todo.dart';
import '../repository/todo_item_repository.dart';

class GetTodosUseCase implements UseCase<Either<String, List<TodoEntity>>, void> {
  final TodoItemRepository _repository;

  GetTodosUseCase(this._repository);

  @override
  Future<Either<String, List<TodoEntity>>> call({void params}) {
    return _repository.getTodoItems();
  }
}
