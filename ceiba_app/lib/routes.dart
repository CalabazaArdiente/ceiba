import 'package:ceiba_app/views/view.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  '/': (context) => HomeView(),
  '/details': (context) => UserDetailsView(),
};
