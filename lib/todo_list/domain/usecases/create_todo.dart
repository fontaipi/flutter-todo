import 'package:todo/core/usecase/usecase.dart';
import 'package:todo/todo_list/domain/repository/todo_item_repository.dart';
import 'package:todo/todo_list/domain/entities/todo.dart';

class CreateTodoUseCase extends UseCase<void, TodoEntity> {
  final TodoItemRepository _todoRepository;

  CreateTodoUseCase(this._todoRepository);

  @override
  Future<void> call({TodoEntity? params}) async {
    await _todoRepository.createTodoItem(params!);
  }
}
