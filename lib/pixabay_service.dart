import 'dart:convert';
import 'package:http/http.dart' as http;

class PixabayService {
  final String apiKey = '43814678-2c3ebe31e0e4fd543a1d148bc';
  final String baseUrl = 'https://pixabay.com/api/';

  Future<List<dynamic>> fetchImages({String query = '', int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseUrl?key=$apiKey&q=$query&page=$page&per_page=20'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['hits'];
    } else {
      throw Exception('Failed to load images');
    }
  }
}
