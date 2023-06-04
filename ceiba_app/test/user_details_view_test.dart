import 'package:ceiba_app/services/user_service.dart';
import 'package:ceiba_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_details_view_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  testWidgets('UserDetailsView shows user details and posts',
      (WidgetTester tester) async {
    // Inicializar Getx para poder utilizar GetMaterialApp y pasar argumentos a la pantalla
    Get.testMode = true;
    final userId = 1; // ID del usuario a mostrar en la pantalla

    // Crear un MockClient para simular las respuestas HTTP
    final MockClient mockClient = MockClient();

    // Configurar el UserService para utilizar el MockClient
    Get.put(UserService(client: mockClient));

    // Simular la respuesta del servicio de usuarios
    when(
      mockClient.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users/$userId'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        '''
        {
          "id": $userId,
          "name": "Leanne Graham",
          "email": "Sincere@april.biz",
          "phone": "1-770-736-8031 x56442"
        }
        ''',
        200,
      ),
    );

    // Simular la respuesta del servicio de publicaciones
    when(
      mockClient.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts?userId=$userId'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        '''
        ${List.generate(
          10,
          (index) => '''
            {
              "id": ${index + 1},
              "userId": $userId,
              "title": "Post Title $index",
              "body": "Post Body $index"
            }
          ''',
        ).join(',')}
        ''',
        200,
      ),
    );

    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/details',
        getPages: [
          GetPage(
            name: '/details',
            page: () => UserDetailsView(userId: userId),
          ),
        ],
      ),
    );

    // Verificar que se muestra un indicador de carga mientras se cargan los datos
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Simular el paso del tiempo para que se carguen los datos
    await tester.pumpAndSettle();

    // Verificar que se muestra información detallada sobre el usuario
    expect(find.text('Nombre'), findsOneWidget);
    expect(find.text('Teléfono'), findsOneWidget);
    expect(find.text('Correo electrónico'), findsOneWidget);
  });
}
