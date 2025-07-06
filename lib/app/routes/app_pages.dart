// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:mitra_jaya/app/modules/splash/bindings/splash_binding.dart';
import 'package:mitra_jaya/app/modules/splash/views/splash_screen.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
