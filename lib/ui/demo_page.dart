import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/bloc/demo_bloc.dart';
import '../data/bloc/demo_event.dart';
import '../data/bloc/demo_repo.dart';
import '../data/bloc/demo_state.dart';

class DemoPage extends StatelessWidget {
  final DemoRepository repository;

  const DemoPage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DemoBloc(repository: repository)..add(FetchDemo()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Demo App'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: DemoContent(),
        ),
      ),
    );
  }
}

class DemoContent extends StatelessWidget {
  const DemoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DemoBloc, DemoState>(
      builder: (context, state) {
        if (state is DemoLoading) {
          return const LoadingWidget();
        } else if (state is DemoLoaded) {
          return DemoList(demo: state.demo);
        } else if (state is DemoError) {
          return ErrorWidget(errorMessage: state.error);
        }
        return const NoDataWidget();
      },
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class DemoList extends StatelessWidget {
  final List demo;

  const DemoList({super.key, required this.demo});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: demo.length,
      itemBuilder: (context, index) {
        final item = demo[index];
        return ListTile(
          title: Text(item.title),
          subtitle: Text(item.description),
        );
      },
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final String errorMessage;

  const ErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No data available'));
  }
}
