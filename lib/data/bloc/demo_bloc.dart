import 'package:flutter_bloc/flutter_bloc.dart';
import 'demo_event.dart';
import 'demo_state.dart';
import 'demo_repo.dart';

class DemoBloc extends Bloc<DemoEvent, DemoState> {
  final DemoRepository repository;

  DemoBloc({required this.repository}) : super(DemoInitial()) {
    on<FetchDemo>((event, emit) async {
      emit(DemoLoading());
      try {
        final events = await repository.fetchDemo();
        emit(DemoLoaded(events));
      } catch (e) {
        emit(DemoError(e.toString()));
      }
    });
  }
}
