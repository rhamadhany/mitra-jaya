import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  late InAppWebViewController webviewController;
  final isLoading = true.obs;
  final isError = false.obs;
  final showDialog = false.obs;
  void launchIntent(Uri url) {
    try {
      launchUrl(url);
    } catch (_) {}
  }

  void downloadApk(Uri url) async {
    final output = '/storage/emulated/0/mitra-jaya.apk';
    await FlutterDownloader.enqueue(
      url: url.toString(),
      headers: {}, // optional: header send with url (auth token etc)
      savedDir: output,
      showNotification: true,
      openFileFromNotification: true,
    );
  }
}
