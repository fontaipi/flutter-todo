import 'package:todo/core/usecase/usecase.dart';
import 'package:todo/todo_list/domain/repository/todo_item_repository.dart';
import 'package:todo/todo_list/domain/entities/todo.dart';

class DeleteTodoUseCase extends UseCase<void, int> {
  final TodoItemRepository _todoRepository;

  DeleteTodoUseCase(this._todoRepository);

  @override
  Future<void> call({int? params}) async {
    await _todoRepository.deleteTodoItem(params!);
  }
}
