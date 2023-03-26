import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';

class ApiServiceProvider {
  Future<List?> fetchBudgets() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return Budget.budgetList(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
