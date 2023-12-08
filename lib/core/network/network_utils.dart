import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import '../failure/exception.dart';
import '../failure/failure.dart';

@injectable
class NetworkUtils {
  final Dio dio;
  NetworkUtils({required this.dio});
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<dynamic> get({required String path}) async {
    try {
      final response = await dio.get(baseUrl + path);
      return returnResponse(response: response);
    } on ServerException {
      throw ServerFailure();
    }
  }

  dynamic returnResponse({required Response response}) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else{
      throw ServerException();
    }
  }
}
