import 'package:hirehub/core/constants/app_constants.dart';
import 'package:hirehub/core/network/api_client.dart';
import 'package:hirehub/data/models/job_model.dart';

class JobService {
  final ApiClient _apiClient;

  JobService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<List<JobModel>> fetchJobs() async {
    try {
      final response = await _apiClient.get(AppConstants.apiBaseUrl);
      final data = response['data'] as List<dynamic>? ?? [];
      return data.map((json) => JobModel.fromJson(json as Map<String, dynamic>)).toList();
    } on ApiException {
      rethrow;
    } on Exception {
      throw ApiException(message: AppConstants.defaultErrorMessage);
    }
  }

  void dispose() {
    _apiClient.dispose();
  }
}