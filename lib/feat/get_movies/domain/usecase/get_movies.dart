import 'package:dartz/dartz.dart';
import '../entity/load_movie.dart';
import '../../../../core/failure/failure.dart';
import '../repository/movies_repository.dart';

class GetMoviesUseCase {
  final MoviesRepository moviesRepository;
  GetMoviesUseCase({required this.moviesRepository});

  Future<Either<Failure, LoadMoviesEntity>> call() async {
    return await moviesRepository.getMoviesList();
  }
}