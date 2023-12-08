import 'package:dartz/dartz.dart';
import '../model/movies_model.dart';
import '../../domain/repository/movies_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/failure/exception.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/network_info.dart';
import '../data_source/movies_data_source.dart';

@Injectable(as: MoviesRepository)
class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource moviesRemoteDataSource;
  final NetworkInfo networkInfo;

  MoviesRepositoryImpl(
      {required this.moviesRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, LoadMoviesModel>> getMoviesList() async {
    return await _getMoviesRemote();
  }

  Future<Either<Failure, LoadMoviesModel>> _getMoviesRemote() async {
    if (await networkInfo.isConnected) {
      try {
        final loadMovies = await moviesRemoteDataSource.getMovies();
        return Right(loadMovies);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
