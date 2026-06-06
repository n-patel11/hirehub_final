import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hirehub/data/models/job_model.dart';

class JobDetailController extends GetxController {
  final job = Rx<JobModel?>(null);
  final isLaunchingUrl = false.obs;

  @override
  void onInit() {
    super.onInit();
    job.value = Get.arguments as JobModel?;
  }

  Future<void> applyNow() async {
    if (job.value == null) return;

    isLaunchingUrl.value = true;
    try {
      final uri = Uri.parse(job.value!.url);
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        Get.snackbar(
          'Cannot Open URL',
          'Unable to launch the job application link.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900,
          margin: const EdgeInsets.all(16),
        );
      }
    } on Exception {
      Get.snackbar(
        'Error',
        'Something went wrong while opening the link.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLaunchingUrl.value = false;
    }
  }
}