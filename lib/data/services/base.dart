import 'package:get_it/get_it.dart';
import 'package:test2/data/services/api.dart';
import 'package:test2/data/services/storage.dart';

abstract class BaseRepository {
  final api = GetIt.I<ApiService>();
  final storage = GetIt.I<Storage>();
}
