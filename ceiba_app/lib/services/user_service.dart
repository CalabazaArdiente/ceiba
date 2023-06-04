import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$_baseUrl/users'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> getUserById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/users/$id'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load user');
    }
  }
}
