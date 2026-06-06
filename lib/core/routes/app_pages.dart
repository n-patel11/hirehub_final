import 'package:get/get.dart';
import 'package:hirehub/core/routes/app_routes.dart';
import 'package:hirehub/modules/jobs/bindings/jobs_binding.dart';
import 'package:hirehub/modules/jobs/views/jobs_view.dart';
import 'package:hirehub/modules/job_detail/bindings/job_detail_binding.dart';
import 'package:hirehub/modules/job_detail/views/job_detail_view.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.jobs,
      page: () => const JobsView(),
      binding: JobsBinding(),
    ),
    GetPage(
      name: AppRoutes.jobDetail,
      page: () => const JobDetailView(),
      binding: JobDetailBinding(),
    ),
  ];
}