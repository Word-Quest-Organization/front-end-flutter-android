import 'package:english_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:english_app/features/auth/datasources/auth_remote_datasource.dart';
import 'package:english_app/features/auth/domain/commands/login_command.dart';
import 'package:english_app/features/auth/domain/commands/register_command.dart';
import 'package:english_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:english_app/features/auth/presentation/viewmodel/auth_Viewmodel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

void setupInjector() {
  // VIEWMODELS
  getIt.registerFactory<AuthViewModel>(
    () => AuthViewModel(
      loginCommand: getIt<LoginCommand>(),
      registerCommand: getIt<RegisterCommand>(),
    ),
  );

  // COMMANDS
  getIt.registerLazySingleton<LoginCommand>(
    () => LoginCommand(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterCommand>(
    () => RegisterCommand(repository: getIt<AuthRepository>()),
  );

  // REPOSITORIES
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDatasource: getIt<AuthRemoteDatasource>()),
  );

  // DATASOURCES
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      client: getIt<http.Client>(),
      baseUrl: dotenv.env['BASE_URL']!,
    ),
  );

  // DEPENDÊNCIAS EXTERNAS
  getIt.registerLazySingleton<http.Client>(() => http.Client());
}
