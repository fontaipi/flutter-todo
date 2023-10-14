import 'package:get_it/get_it.dart';
import 'package:todo/todo_list/data/repository/todo_repository_impl.dart';
import 'package:todo/todo_list/domain/repository/todo_item_repository.dart';
import 'package:todo/todo_list/domain/usecases/create_todo.dart';
import 'package:todo/todo_list/domain/usecases/delete_todo.dart';
import 'package:todo/todo_list/domain/usecases/get_todos.dart';
import 'package:todo/todo_list/domain/usecases/update_todo.dart';
import 'package:todo/todo_list/presentation/bloc/todo_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Repositories
  getIt.registerSingleton<TodoItemRepository>(
    TodoRepositoryImpl(),
  );

  // Use cases
  getIt.registerSingleton<GetTodosUseCase>(
    GetTodosUseCase(getIt()),
  );

  getIt.registerSingleton<CreateTodoUseCase>(
    CreateTodoUseCase(getIt()),
  );

  getIt
      .registerSingleton<UpdateTodoUseCase>(UpdateTodoUseCase(getIt()));

  getIt
      .registerSingleton<DeleteTodoUseCase>(DeleteTodoUseCase(getIt()));

  // Blocs
  getIt.registerFactory<TodoBloc>(
    () => TodoBloc(getIt(), getIt(), getIt(), getIt()),
  );
}
