import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirehub/core/routes/app_routes.dart';
import 'package:hirehub/core/routes/app_pages.dart';
import 'package:hirehub/core/theme/app_theme.dart';
import 'package:hirehub/core/constants/app_constants.dart';

void main() {
  runApp(const HireHubApp());
}

class HireHubApp extends StatelessWidget {
  const HireHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.jobs,
      getPages: AppPages.pages,
    );
  }
}