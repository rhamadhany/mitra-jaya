import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_jaya/app/modules/splash/controllers/splash_controlller.dart';

class SplashScreen extends GetView<SplashControlller> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FadeTransition(
        opacity: controller.fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.electrical_services, size: Get.width * 0.75),
              SizedBox(height: 10),
              Text(
                'Mitra Jaya Elektronik',
                style: GoogleFonts.aladin(fontSize: Get.width * 0.075),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
