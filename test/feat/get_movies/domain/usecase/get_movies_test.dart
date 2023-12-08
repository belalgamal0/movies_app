import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:movies_app/feat/get_movies/domain/entity/load_movie.dart';
import 'package:movies_app/feat/get_movies/domain/entity/movie.dart';
import 'package:movies_app/feat/get_movies/domain/repository/movies_repository.dart';
import 'package:movies_app/feat/get_movies/domain/usecase/get_movies.dart';

import 'get_movies_test.mocks.dart';


// Generate mock implementations for the specified mocks
@GenerateNiceMocks([MockSpec<MoviesRepository>()])
void main() {
  // Declare variables for the use case and mock repository
  late GetMoviesUseCase usecase;
  late MockMoviesRepository mockMoviesRepository;

  // Set up the test environment before each test
  setUp(() {
    // Create a mock instance of the MoviesRepository
    mockMoviesRepository = MockMoviesRepository();
    // Initialize the GetMoviesUseCase with the mock repository
    usecase = GetMoviesUseCase(moviesRepository: mockMoviesRepository);
  });

  // Define a sample LoadMoviesEntity for testing
  const LoadMoviesEntity loadMoviesEntity = LoadMoviesEntity(movies: [
    Movie(
      movieTitle: "movieTitle",
      movieOverview: "movieOverview",
      moviePoster: "moviePoster",
      movieRate: 1.0,
    )
  ], page: 1, totalPages: 1, totalResults: 1);

  // Test case to ensure that movies are loaded from the repository
  test(
    'should load movies from the repository',
    () async {
      // Arrange: Mock the behavior of the repository's getMoviesList method
      when(mockMoviesRepository.getMoviesList()).thenAnswer((_) async => const Right(loadMoviesEntity));

      // Act: Call the use case
      final result = await usecase();

      // Assert: Verify that the result matches the expected LoadMoviesEntity
      expect(result, const Right(loadMoviesEntity));
      // Verify that the getMoviesList method was called on the repository
      verify(mockMoviesRepository.getMoviesList());
      // Verify that there are no more interactions with the repository
      verifyNoMoreInteractions(mockMoviesRepository);
    },
  );
}
