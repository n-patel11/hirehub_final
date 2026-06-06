import 'package:hirehub/data/models/job_model.dart';
import 'package:hirehub/data/services/job_service.dart';

class JobRepository {
  final JobService _jobService;

  JobRepository({JobService? jobService})
      : _jobService = jobService ?? JobService();

  Future<List<JobModel>> getJobs() async {
    return await _jobService.fetchJobs();
  }
}