import 'package:dio/dio.dart';
import '../utils/constants.dart';

class ApiService {
  final Dio _dio;

  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: AppConstants.nytBaseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

  Future<Map<String, dynamic>> fetchTopStories(String section) async {
    try {
      final response = await _dio.get(
        '$section.json',
        queryParameters: {'api-key': AppConstants.nytApiKey},
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load top stories');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 429) {
          throw Exception(
            'API Rate Limit Exceeded.\nPlease wait a minute and try again.',
          );
        }
        throw Exception(
          'API Error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
        );
      } else {
        throw Exception('Network Error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
