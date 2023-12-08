import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/network/network_utils.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  late NetworkUtils networkUtils;
  late String baseUrl;
  late String moviesPath;
  late String apiKey;
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());

  // Set up the test environment
  setUp(() async {
    // Load environment variables for testing
    await dotenv.load(fileName: '.env');
    apiKey = dotenv.env['TMDB_API_KEY']!;
    baseUrl = dotenv.env['BASE_URL']!;
    moviesPath = dotenv.env['MOVIES_PATH']!;
    
    // Initialize NetworkUtils with DioAdapter
    networkUtils = NetworkUtils(dio: dioAdapter.dio);
    
    // Set up Dio to use the mock adapter
    dio.httpClientAdapter = dioAdapter;
  });

  // Group of tests related to NetworkUtils - GET Method
  group('NetworkUtils - GET Method', () {
    // Test to ensure correct GET request with the API key
    test('should make a GET request to the correct endpoint with the API key', () async {
      dioAdapter.onGet(
        "$baseUrl$moviesPath?api_key=$apiKey",
        (request) {
          return request.reply(200, fixture("movies.json"));
        },       
      );

      final response = await networkUtils.get(path: "$moviesPath?api_key=$apiKey");

      // Expect the response to match the fixture data
      expect(response, fixture("movies.json"));
    });

    // Test to ensure DioException is thrown on 400 status code
    test('should throw a DioException on 400 status code', () async {
      dioAdapter.onGet(
        "$baseUrl$moviesPath?api_key=$apiKey",
        (request) {
          return request.reply(400, {'error': 'Bad Request'});
        },
        data: Matchers.any,
        queryParameters: {},
        headers: {},
      );

      // Expect an async function to throw a DioException
      expect(
        () async => await networkUtils.get(path: "$moviesPath?api_key=$apiKey"),
        throwsA(isA<DioException>())
      );
    });
  });
}
