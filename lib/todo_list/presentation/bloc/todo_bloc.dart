import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/todo_list/domain/usecases/get_todos.dart';
import 'package:todo/todo_list/domain/usecases/create_todo.dart';
import 'package:todo/todo_list/presentation/bloc/todo_event.dart';
import 'package:todo/todo_list/presentation/bloc/todo_state.dart';
import 'package:todo/todo_list/domain/usecases/update_todo.dart';
import 'package:todo/todo_list/domain/usecases/delete_todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodosState> {
  final GetTodosUseCase _getTodoItemsUseCase;
  final CreateTodoUseCase _createTodoItemUseCase;
  final UpdateTodoUseCase _updateTodoItemUseCase;
  final DeleteTodoUseCase _deleteTodoItemUseCase;

  TodoBloc(this._getTodoItemsUseCase, this._createTodoItemUseCase,
      this._updateTodoItemUseCase, this._deleteTodoItemUseCase)
      : super(const TodosLoadingState()) {
    on<GetTodos>(onGetTodoItems);
    on<CreateTodo>(onCreateTodoItem);
    on<UpdateTodo>(onUpdateTodoItem);
    on<DeleteTodo>(onDeleteTodoItem);
  }

  void onGetTodoItems(GetTodos event, Emitter<TodosState> emit) async {
    final state = await _getTodoItemsUseCase();
    emit(state.fold(
        (errorMessage) => TodosError(errorMessage: errorMessage),
        (todoItems) => TodosDoneState(todoItems)));
  }

  void onCreateTodoItem(
      CreateTodo event, Emitter<TodosState> emit) async {
    await _createTodoItemUseCase(params: event.todoItem);
    final state = await _getTodoItemsUseCase();
    emit(state.fold(
        (errorMessage) => TodosError(errorMessage: errorMessage),
        (todoItems) => TodosDoneState(todoItems)));
  }

  void onUpdateTodoItem(
      UpdateTodo event, Emitter<TodosState> emit) async {
    await _updateTodoItemUseCase(params: event.todoItem);
    final state = await _getTodoItemsUseCase();
    emit(state.fold(
        (errorMessage) => TodosError(errorMessage: errorMessage),
        (todoItems) => TodosDoneState(todoItems)));
  }

  void onDeleteTodoItem(
      DeleteTodo event, Emitter<TodosState> emit) async {
    await _deleteTodoItemUseCase(params: event.id);
    final state = await _getTodoItemsUseCase();
    emit(state.fold(
        (errorMessage) => TodosError(errorMessage: errorMessage),
        (todoItems) => TodosDoneState(todoItems)));
  }
}
