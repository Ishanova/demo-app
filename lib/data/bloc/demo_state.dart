import 'package:equatable/equatable.dart';
import 'package:test2/data/models/demo_model.dart';

abstract class DemoState extends Equatable {
  const DemoState();

  @override
  List<Object?> get props => [];
}

class DemoInitial extends DemoState {}

class DemoLoading extends DemoState {}

class DemoLoaded extends DemoState {
  final List<DemoModel> demo;

  const DemoLoaded(this.demo);

  @override
  List<Object?> get props => [demo];
}

class DemoError extends DemoState {
  final String error;

  const DemoError(this.error);

  @override
  List<Object?> get props => [error];
}

