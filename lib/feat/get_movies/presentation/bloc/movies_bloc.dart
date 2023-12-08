import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure_mapper.dart';
import '../../domain/entity/load_movie.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/usecase/get_movies.dart';
import 'movies_events.dart';
import 'movies_states.dart';

// Bloc responsible for managing the state of the Movies feature
class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMoviesUseCase getMoviesUseCase;

  // Constructor for initializing the MoviesBloc with the GetMoviesUseCase
  MoviesBloc({required this.getMoviesUseCase})
      : super(const MoviesState.initial()) {
    // Register the LoadMoviesEvent handler
    on<LoadMoviesEvent>(_loadMovies);
  }

  // Handler for the LoadMoviesEvent
  void _loadMovies(LoadMoviesEvent event, Emitter<MoviesState> emit) async {
    // Emit the loading state
    emit(const MoviesState.loading());
    // Invoke the GetMoviesUseCase to get the movies data
    final moviesOrError = await getMoviesUseCase();
    // Process the result and emit the corresponding state
    _eitherLoadedOrErrorState(moviesOrError, emit);
  }

  // Helper method to process the result of GetMoviesUseCase and emit the corresponding state
  _eitherLoadedOrErrorState(Either<Failure, LoadMoviesEntity> failureOrMoviesList,
      Emitter<MoviesState> emit) async {
    failureOrMoviesList.fold(
      // If a failure occurred, emit the error state
      (failure) {
        emit(MoviesState.error(
            FailureMapper.mapFailureToMessage(failure: failure)));
      },
      // If successful, emit the loaded state with the movies list
      (moviesList) {
        emit(MoviesState.loaded(moviesList));
      },
    );
  }
}
