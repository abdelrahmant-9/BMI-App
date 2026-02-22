import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey = "db2c79f4-601a-40fe-992c-190b239ed59a";
  static const String _baseUrl = "https://api.apiverve.com/v1/randomquote";

  Future<String> fetchRandomQuote() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'x-api-key': _apiKey,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final data = jsonResponse['data'];
        String quote;
        if (data is List) {
          quote = data[0]['quote'];
        } else if (data is Map) {
          quote = data['quote'];
        } else {
          quote = "Could not parse quote.";
        }
        return quote;
      } else {
        return "Failed to load quote. Status code: ${response.statusCode}";
      }
    } catch (e) {
      return "Failed to load quote: $e";
    }
  }
}
