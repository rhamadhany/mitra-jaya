import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitra_jaya/app/modules/home/download/controllers/download_controller.dart';

class DownloadDialog extends GetView<DownloadController> {
  const DownloadDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        "Unduh aplikasi",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          TextField(
            controller: controller.nameController,
            maxLines: null,
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 10),
          Obx(
            () => Text(
              '* Aplikasi akan disimpan di /storage/emulated/0/${controller.outputName.value}',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: buttonStyle(Colors.grey),
          onPressed: () {
            Get.back();
          },
          child: Text('Batal'),
        ),

        ElevatedButton(
          style: buttonStyle(Colors.blue),
          onPressed: () {
            Get.back();
            controller.startDownload();
          },
          child: Text('Unduh'),
        ),
      ],
    );
  }

  ButtonStyle buttonStyle(Color? backgroundColor) {
    return ButtonStyle(
      textStyle: WidgetStatePropertyAll(TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: WidgetStatePropertyAll(backgroundColor),
      foregroundColor: WidgetStatePropertyAll(
        backgroundColor != null ? Colors.white : null,
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
