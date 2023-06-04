import 'package:ceiba_app/services/user_service.dart';
import 'package:ceiba_app/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_view_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  testWidgets('HomeView shows message when user is not found',
      (WidgetTester tester) async {
    // Inicializar Getx para poder utilizar GetMaterialApp
    Get.testMode = true;

    // Crear un MockClient para simular las respuestas HTTP
    final mockClient = MockClient();

    // Configurar el UserService para utilizar el MockClient
    Get.put(UserService(client: mockClient));

    // Simular la respuesta del servicio de usuarios
    when(
      mockClient.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        '''
      [
        ${List.generate(
          10,
          (index) => '''
          {
            "id": ${index + 1},
            "name": "User Name $index",
            "email": "user$index@email.com",
            "phone": "1234567890"
          }
          ''',
        ).join(',')}
      ]
      ''',
        200,
      ),
    );

    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => HomeView(),
          ),
        ],
      ),
    );

    // Verificar que se muestra un indicador de carga mientras se cargan los datos
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Simular el paso del tiempo para que se carguen los datos
    await tester.pumpAndSettle();

    // Ingresar texto en el campo de búsqueda
    await tester.enterText(find.byType(TextField), 'Non-existent User');

    // Simular el paso del tiempo para que se actualice la lista de usuarios
    await tester.pumpAndSettle();

    // Verificar que se muestra un mensaje indicando que el usuario no fue encontrado
    expect(find.text('List is empty'), findsOneWidget);
  });
}
