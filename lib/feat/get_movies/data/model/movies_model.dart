import '../../domain/entity/load_movie.dart';
import 'movie_model.dart';

class LoadMoviesModel extends LoadMoviesEntity {
  const LoadMoviesModel({
    required int page,
    required List<MovieModel> movies,
    required int totalPages,
    required int totalResults,
  }) : super(
            page: page,
            movies: movies,
            totalPages: totalPages,
            totalResults: totalResults);

  factory LoadMoviesModel.fromJson(Map<String, dynamic> json) =>
      LoadMoviesModel(
        page: json["page"],
        movies: List<MovieModel>.from(
            json["results"].map((movie) => MovieModel.fromJson(movie))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(movies.map((movie) => movie.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
