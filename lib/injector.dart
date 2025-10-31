import 'package:english_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:english_app/features/login/datasources/login_remote_datasource.dart';
import 'package:english_app/features/login/domain/commands/login_command.dart';
import 'package:english_app/features/login/domain/repositories/login_repository.dart';
import 'package:english_app/features/login/presentation/viewmodel/login_Viewmodel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

void setupInjector() {
  // VIEWMODELS
  getIt.registerFactory<LoginViewModel>(
    () => LoginViewModel(loginCommand: getIt<LoginCommand>()),
  );

  // COMMANDS
  getIt.registerLazySingleton<LoginCommand>(
    () => LoginCommand(repository: getIt<LoginRepository>()),
  );

  // REPOSITORIES
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(remoteDatasource: getIt<LoginRemoteDatasource>()),
  );

  // DATASOURCES
  getIt.registerLazySingleton<LoginRemoteDatasource>(
    () => LoginRemoteDatasourceImpl(
      client: getIt<http.Client>(),
      baseUrl: dotenv.env['BASE_URL']!,
    ),
  );

  // DEPENDÊNCIAS EXTERNAS
  getIt.registerLazySingleton<http.Client>(() => http.Client());
}
