import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  const Movie(
      {required this.movieTitle,
      required this.movieOverview,
      required this.moviePoster,
      required this.movieRate});
  final String movieTitle;
  final String movieOverview;
  final String moviePoster;
  final double movieRate;

  @override
  List<Object?> get props => [movieTitle, movieOverview, moviePoster, movieRate];

  toJson() {}
}
