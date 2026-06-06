import 'package:get/get.dart';
import 'package:hirehub/data/repositories/job_repository.dart';
import 'package:hirehub/modules/jobs/controllers/jobs_controller.dart';

class JobsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobRepository>(() => JobRepository());
    Get.lazyPut<JobsController>(() => JobsController());
  }
}