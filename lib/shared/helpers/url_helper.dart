import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static Future<bool> launchUrlString(String url) async {
    try {
      final uri = Uri.parse(url);
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } on Exception {
      return false;
    }
  }
}