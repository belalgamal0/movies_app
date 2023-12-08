import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/failure/exception.dart';
import '../../../../core/network/network_utils.dart';
import '../model/movies_model.dart';

abstract class MoviesRemoteDataSource {
  Future<LoadMoviesModel> getMovies();
}

@Injectable(as: MoviesRemoteDataSource)
class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final NetworkUtils networkUtils;
  const MoviesRemoteDataSourceImpl({required this.networkUtils});

  @override
  Future<LoadMoviesModel> getMovies() => _getMoviesFromApi();
  Future<LoadMoviesModel> _getMoviesFromApi() async {
    final String moviesPath = dotenv.env['MOVIES_PATH']!;
    final String apiKey = dotenv.env['TMDB_API_KEY']!;
    try {
      final response =
          await networkUtils.get(path: "$moviesPath?api_key=$apiKey");
      return LoadMoviesModel.fromJson(response);
    } catch (e) {
      throw ServerException();
    }
  }
}
