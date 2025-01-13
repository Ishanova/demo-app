import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/bloc/demo_repo.dart';
import 'data/services/api.dart';
import 'data/services/storage.dart';
import 'ui/demo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final getIt = GetIt.instance;
  getIt.registerSingleton<ApiService>(ApiService(baseUrl: 'https://demo.com'));
  final storage = await Storage().initialize();
  getIt.registerSingleton<Storage>(storage);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DemoPage(repository: DemoRepository(api: GetIt.I<ApiService>())),
    );
  }
}
