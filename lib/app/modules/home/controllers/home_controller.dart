import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  late InAppWebViewController webviewController;
  final isLoading = true.obs;
  final isError = false.obs;
  final showDialog = false.obs;
  final isDownloading = false.obs;
  final downloadProgress = 0.0.obs;
  void launchIntent(Uri url) {
    try {
      launchUrl(url);
    } catch (_) {}
  }
}

void snackError({String? title, required String message}) {
  Get.snackbar(
    title ?? 'Gagal',
    message,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    backgroundColor: Colors.red,
  );
}

void snackSuceed({String? title, required String message}) {
  Get.snackbar(
    title ?? 'Berhasil',
    message,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    backgroundColor: Colors.blue,
  );
}
