import 'package:dio/dio.dart' as dio;
import 'package:movies_app/injection_container.config.dart';
import 'feat/get_movies/domain/usecase/get_movies.dart';
import 'feat/get_movies/presentation/bloc/movies_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'core/network/network_info.dart';

@module
abstract class AppModule {
  // Register blocs
  @injectable
  MoviesBloc get moviesBloc;

  // Register use cases
  @lazySingleton
  GetMoviesUseCase get getMoviesUseCase;

  // Register other dependencies
  @lazySingleton
  NetworkInfoImpl get networkInfo;
}

@module
abstract class RegisterModule {
  @lazySingleton
  dio.Dio get httpClient => dio.Dio();
  @lazySingleton
  InternetConnectionChecker get internetConnectionChecker => InternetConnectionChecker();
}

final getIT = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIT.init();
