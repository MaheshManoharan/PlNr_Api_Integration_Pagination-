import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../controllers/api_provider.dart';
import '../repository/api_repo.dart';
import 'app_constants.dart';
import 'dio_client.dart';

final sl = GetIt.instance;

Future<void> init() async
{
  sl.registerFactory(() => ApiProvider(apiRepo: sl()));
  sl.registerLazySingleton(() => ApiRepo(dioClient: sl()));

    sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(),));
     sl.registerLazySingleton(() => Dio());
}
