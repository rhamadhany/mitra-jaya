import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitra_jaya/app/modules/home/controllers/home_controller.dart';
import 'package:mitra_jaya/app/modules/home/download/views/download_dialog.dart';
import 'package:mitra_jaya/app/modules/home/services/notification_service.dart';

class DownloadController extends GetxController {
  final nameController = TextEditingController(text: 'Mitra-Jaya.apk');
  final Uri url;
  final dio = Dio();
  DownloadController({required this.url});

  @override
  void onInit() {
    super.onInit();
    showDialog();
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  void showDialog() {
    nameController.text = url.queryParameters['file'] ?? nameController.text;
    Get.dialog(DownloadDialog());
  }

  Future<void> startDownload() async {
    final controller = Get.find<HomeController>();
    controller.isDownloading.value = true;
    controller.downloadProgress.value = 0.0;
    final output = "/storage/emulated/0/Download/${nameController.text}";

    try {
      await dio.download(
        url.toString(),
        output,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            // controller.downloadProgress.value = (received / total * 100);
            final progress = (received / total * 100).toInt();
            final body =
                "Status: ${formatSize(received)} / ${formatSize(total)}";

            NotificationService.showProgressNotification(
              -1,
              'Mengunduh',
              body,
              progress,
              100,
              null,
            );
          }
        },
        options: Options(responseType: ResponseType.bytes),
      );

      snackSuceed(message: 'Berhasil di unduh ke $output');
      NotificationService.showProgressNotification(
        -1,
        'Unduhan selesai',
        'Aplikasi di unduh ke $output',
        100,
        100,
        output,
      );
    } catch (e) {
      snackError(message: 'Gagal $e');
    } finally {
      controller.isDownloading.value = false;
    }
  }

  String formatSize(int bytes) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB'];
    int i = 0;
    double size = bytes.toDouble();

    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }

    return '${size.toStringAsFixed(1)} ${suffixes[i]}';
  }
}
