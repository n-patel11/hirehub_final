import 'package:get/get.dart';
import 'package:hirehub/modules/job_detail/controllers/job_detail_controller.dart';

class JobDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobDetailController>(() => JobDetailController());
  }
}