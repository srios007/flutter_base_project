import 'package:flutter_base_project/app/modules/onboarding/login/bindings/login_binding.dart';
import 'package:flutter_base_project/app/modules/onboarding/login/views/login_view.dart';
import 'package:flutter_base_project/app/modules/onboarding/signin/bindings/signin_binding.dart';
import 'package:flutter_base_project/app/modules/onboarding/signin/views/signin_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
