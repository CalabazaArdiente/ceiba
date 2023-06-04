import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 11, 108, 15),
      ),
      title: 'Prueba de ingreso',
      initialRoute: '/',
      getPages: appRoutes, // Utiliza la propiedad getPages en lugar de routes
    );
  }
}
//  appBarTheme: const AppBarTheme(
//             color: Color.fromARGB(255, 11, 108, 15),
//           ),
//           textButtonTheme: TextButtonThemeData(
//             style: TextButton.styleFrom(
//               primary: Color.fromARGB(255, 11, 108, 15),
//             ),
//           ),
//           inputDecorationTheme: const InputDecorationTheme(
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: Color.fromARGB(255, 11, 108, 15),
//               ),
//             ),
//             labelStyle: TextStyle(
//               color: Color.fromARGB(255, 11, 108, 15),
//             ),
//           )