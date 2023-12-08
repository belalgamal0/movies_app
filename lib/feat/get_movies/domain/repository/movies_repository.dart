import 'package:dartz/dartz.dart';
import '../entity/load_movie.dart';
import '../../../../core/failure/failure.dart';

abstract class MoviesRepository {
    Future<Either<Failure,LoadMoviesEntity>> getMoviesList();
}