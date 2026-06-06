import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirehub/core/routes/app_routes.dart';
import 'package:hirehub/modules/jobs/controllers/jobs_controller.dart';
import 'package:hirehub/modules/jobs/widgets/job_card.dart';
import 'package:hirehub/shared/widgets/custom_error_widget.dart';

class JobsView extends GetView<JobsController> {
  const JobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HireHub'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: TextField(
        controller: controller.searchController,
        onChanged: (value) => controller.searchQuery.value = value,
        decoration: InputDecoration(
          hintText: 'Search by job title or company...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: controller.clearSearch,
                )
              : const SizedBox.shrink()),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (controller.errorMessage.value.isNotEmpty) {
        return CustomErrorWidget(
          message: controller.errorMessage.value,
          onRetry: controller.retry,
        );
      }

      if (controller.filteredJobs.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.work_off_outlined, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'No jobs found',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 8),
              Text(
                'Try a different search term',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: controller.fetchJobs,
        child: ListView.builder(
          itemCount: controller.filteredJobs.length,
          padding: const EdgeInsets.only(bottom: 16),
          itemBuilder: (context, index) {
            final job = controller.filteredJobs[index];
            return JobCard(
              job: job,
              index: index,
              onFavoriteToggle: () => controller.toggleFavorite(index),
              onTap: () => Get.toNamed(
                AppRoutes.jobDetail,
                arguments: job,
              ),
            );
          },
        ),
      );
    });
  }
}