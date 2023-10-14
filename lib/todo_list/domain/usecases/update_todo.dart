import 'package:todo/core/usecase/usecase.dart';
import 'package:todo/todo_list/domain/repository/todo_item_repository.dart';
import 'package:todo/todo_list/domain/entities/todo.dart';

class UpdateTodoUseCase extends UseCase<void, TodoEntity> {
  final TodoItemRepository _todoRepository;

  UpdateTodoUseCase(this._todoRepository);

  @override
  Future<void> call({TodoEntity? params}) async {
    await _todoRepository.updateTodoItem(params!);
  }
}
