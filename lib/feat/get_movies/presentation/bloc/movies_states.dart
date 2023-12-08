import 'package:equatable/equatable.dart';
import '../../domain/entity/load_movie.dart';

// Enum representing the different states of the movies feature
enum MoviesStatus { initial, loading, loaded, error }

// Class representing the state of the movies feature
class MoviesState extends Equatable {
  // Private constructor with default values
  const MoviesState._({
    this.status = MoviesStatus.initial,
    this.loadMoviesEntity,
    this.errorMessage,
  });

  // Factory constructor for the initial state
  const MoviesState.initial() : this._();

  // Factory constructor for the loading state
  const MoviesState.loading() : this._(status: MoviesStatus.loading);

  // Factory constructor for the loaded state with movie data
  const MoviesState.loaded(LoadMoviesEntity loadMoviesEntity)
      : this._(status: MoviesStatus.loaded, loadMoviesEntity: loadMoviesEntity);

  // Factory constructor for the error state with an error message
  const MoviesState.error(String errorMessage)
      : this._(status: MoviesStatus.error, errorMessage: errorMessage);

  // Properties representing the state values
  final MoviesStatus status;
  final LoadMoviesEntity? loadMoviesEntity;
  final String? errorMessage;

  // Override the Equatable props to include all state properties
  @override
  List<Object?> get props => [status, loadMoviesEntity, errorMessage];
}
