// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i4;
import 'package:movies_app/core/network/network_info.dart' as _i5;
import 'package:movies_app/core/network/network_utils.dart' as _i6;
import 'package:movies_app/feat/get_movies/data/data_source/movies_data_source.dart'
    as _i7;
import 'package:movies_app/feat/get_movies/data/repository/load_movies_repository_impl.dart'
    as _i9;
import 'package:movies_app/feat/get_movies/domain/repository/movies_repository.dart'
    as _i8;
import 'package:movies_app/feat/get_movies/domain/usecase/get_movies.dart'
    as _i10;
import 'package:movies_app/feat/get_movies/presentation/bloc/movies_bloc.dart'
    as _i11;
import 'package:movies_app/injection_container.dart' as _i12;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    final appModule = _$AppModule(this);
    gh.lazySingleton<_i3.Dio>(() => registerModule.httpClient);
    gh.lazySingleton<_i4.InternetConnectionChecker>(
        () => registerModule.internetConnectionChecker);
    gh.factory<_i5.NetworkInfo>(() => _i5.NetworkInfoImpl(
        connectionChecker: gh<_i4.InternetConnectionChecker>()));
    gh.lazySingleton<_i5.NetworkInfoImpl>(() => appModule.networkInfo);
    gh.factory<_i6.NetworkUtils>(() => _i6.NetworkUtils(dio: gh<_i3.Dio>()));
    gh.factory<_i7.MoviesRemoteDataSource>(() =>
        _i7.MoviesRemoteDataSourceImpl(networkUtils: gh<_i6.NetworkUtils>()));
    gh.factory<_i8.MoviesRepository>(() => _i9.MoviesRepositoryImpl(
          moviesRemoteDataSource: gh<_i7.MoviesRemoteDataSource>(),
          networkInfo: gh<_i5.NetworkInfo>(),
        ));
    gh.lazySingleton<_i10.GetMoviesUseCase>(() => appModule.getMoviesUseCase);
    gh.factory<_i11.MoviesBloc>(() => appModule.moviesBloc);
    return this;
  }
}

class _$RegisterModule extends _i12.RegisterModule {}

class _$AppModule extends _i12.AppModule {
  _$AppModule(this._getIt);

  final _i1.GetIt _getIt;

  @override
  _i5.NetworkInfoImpl get networkInfo => _i5.NetworkInfoImpl(
      connectionChecker: _getIt<_i4.InternetConnectionChecker>());

  @override
  _i10.GetMoviesUseCase get getMoviesUseCase =>
      _i10.GetMoviesUseCase(moviesRepository: _getIt<_i8.MoviesRepository>());

  @override
  _i11.MoviesBloc get moviesBloc =>
      _i11.MoviesBloc(getMoviesUseCase: _getIt<_i10.GetMoviesUseCase>());
}
