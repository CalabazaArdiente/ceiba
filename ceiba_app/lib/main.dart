import 'package:ceiba_app/tools/design_system.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        appBarTheme: const AppBarTheme(color: primaryColor),
        // color del AppBar
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
                primaryColorLight), // color del TextButton
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: primaryColor), // color del borde inferior
          ),
          labelStyle: TextStyle(color: primaryColor), // color del labelText
        ),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: primaryColor),
      ),
      title: 'Prueba de ingreso',
      initialRoute: '/',
      getPages: appRoutes,
    );
  }
}
