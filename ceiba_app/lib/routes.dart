import 'package:ceiba_app/views/views.dart';
import 'package:get/get.dart';

final List<GetPage> appRoutes = [
  // Define tus páginas aquí
  GetPage(
    name: '/',
    page: () => const HomeView(),
  ),
  GetPage(
    name: '/details',
    page: () => UserDetailsView(userId: Get.arguments),
  ),
];
