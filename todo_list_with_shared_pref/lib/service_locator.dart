import 'package:get_it/get_it.dart';
import 'package:todo_list_with_shared_pref/cache_helper.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<CacheHelper>(CacheHelper());
}
