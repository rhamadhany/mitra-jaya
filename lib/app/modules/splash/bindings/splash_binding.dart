import 'package:get/get.dart';
import 'package:mitra_jaya/app/modules/splash/controllers/splash_controlller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashControlller>(() => SplashControlller());
  }
}
