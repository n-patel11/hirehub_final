import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hirehub/core/constants/app_constants.dart';

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> get(String url) async {
    try {
      final response = await _client
          .get(Uri.parse(url))
          .timeout(AppConstants.apiTimeout);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw ApiException(
          message: AppConstants.serverErrorMessage,
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException {
      throw ApiException(message: AppConstants.noInternetMessage);
    } on FormatException {
      throw ApiException(message: AppConstants.parsingErrorMessage);
    } on Exception {
      throw ApiException(message: AppConstants.timeoutMessage);
    }
  }

  void dispose() {
    _client.close();
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() => message;
}