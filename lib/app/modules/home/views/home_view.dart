import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:mitra_jaya/app/modules/home/download/controllers/download_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (context, pop) async {
        if (await controller.webviewController.canGoBack()) {
          controller.webviewController.goBack();
        } else {
          controller.webviewController.reload();
        }
      },
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: Obx(() {
          return Stack(
            children: [
              controller.isError.value || GlobalVarible.initialLoading.value
                  ? Center(child: CircularProgressIndicator(color: Colors.blue))
                  : InAppWebView(
                      initialSettings: InAppWebViewSettings(
                        javaScriptEnabled: true,
                        forceDark:
                            Theme.of(context).brightness == Brightness.dark
                            ? ForceDark.ON
                            : ForceDark.OFF,
                        useOnDownloadStart: true,
                        userAgent: 'random',
                      ),
                      initialUrlRequest: URLRequest(
                        url: WebUri('https://mitrajaya.duckdns.org/'),
                      ),
                      onWebViewCreated: (webController) {
                        controller.webviewController = webController;
                      },
                      onDownloadStartRequest: (webController, webUri) {
                        // controller.downloadApk(webUri.url);
                        Get.put(DownloadController(url: webUri.url));
                      },
                      onReceivedError: (webController, webUri, error) {
                        final scheme = webUri.url.scheme;
                        if (scheme == 'whatsapp') {
                          controller.isError.value = true;

                          controller.webviewController.goBack().then((_) {
                            controller.launchIntent(webUri.url);
                            controller.isError.value = false;
                          });
                        }
                      },
                      onLoadStart: (webController, url) {
                        controller.isLoading.value = true;
                      },
                      onLoadStop: (webController, url) {
                        controller.isLoading.value = false;
                      },
                    ),
              if (controller.isLoading.value &&
                  !GlobalVarible.initialLoading.value)
                Positioned(
                  top: 0,
                  child: SizedBox(
                    height: 5,
                    width: double.maxFinite,
                    child: LinearProgressIndicator(color: Colors.blue),
                  ),
                ),

              // if (controller.isDownloading.value)
              // Positioned(
              //   bottom: Get.width * 0.1,
              //   right: Get.width * 0.1,
              //   child: Container(
              //     padding: EdgeInsets.all(12),
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: Colors.blue,
              //     ),
              //     child: Obx(
              //       () => Text(
              //         controller.downloadProgress.value.toStringAsFixed(0),
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          );
        }),
      ),
    );
  }
}

class GlobalVarible {
  static final initialLoading = false.obs;
}
