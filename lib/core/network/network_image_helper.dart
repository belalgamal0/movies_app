import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkImageHelper {
  static String getImageUrl({required String imagePath}) {
    final String imageBaseUrl = dotenv.env['IMAGE_BASE_URL']!;
    return '$imageBaseUrl$imagePath';
  }
}
