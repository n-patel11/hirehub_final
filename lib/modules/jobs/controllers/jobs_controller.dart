import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirehub/data/models/job_model.dart';
import 'package:hirehub/data/repositories/job_repository.dart';
import 'package:hirehub/core/network/api_client.dart';

class JobsController extends GetxController {
  final JobRepository _jobRepository = Get.find<JobRepository>();

  final isLoading = true.obs;
  final jobs = <JobModel>[].obs;
  final filteredJobs = <JobModel>[].obs;
  final searchQuery = ''.obs;
  final errorMessage = ''.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
    ever(searchQuery, (_) => searchJobs());
  }

  Future<void> fetchJobs() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await _jobRepository.getJobs();
      jobs.value = result;
      filteredJobs.value = result;
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } on Exception {
      errorMessage.value = 'Something went wrong';
    } finally {
      isLoading.value = false;
    }
  }

  void searchJobs() {
    final query = searchQuery.value.toLowerCase().trim();
    if (query.isEmpty) {
      filteredJobs.value = jobs;
    } else {
      filteredJobs.value = jobs.where((job) {
        final titleMatch = job.title.toLowerCase().contains(query);
        final companyMatch = job.companyName.toLowerCase().contains(query);
        return titleMatch || companyMatch;
      }).toList();
    }
  }

  void toggleFavorite(int index) {
    final job = filteredJobs[index];
    final updatedJob = job.copyWith(isFavorite: !job.isFavorite);
    filteredJobs[index] = updatedJob;

    // Also update in the master jobs list
    final masterIndex = jobs.indexWhere((j) => j.url == job.url && j.title == job.title);
    if (masterIndex != -1) {
      jobs[masterIndex] = updatedJob;
    }

    // Trigger reactive updates
    filteredJobs.refresh();
    jobs.refresh();
  }

  void retry() {
    fetchJobs();
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}