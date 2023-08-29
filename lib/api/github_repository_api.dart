import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<String>> getRepositoriesByName(String name) async {
  final githubToken = dotenv.env['GITHUB_TOKEN'];
  if (name.isEmpty) {
    return [];
  }

  final url = Uri.https(
    'api.github.com',
    '/search/repositories',
    {
      'q': name,
      'per_page': '15',
      'sort': 'stars',
    },
  );

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $githubToken',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final items = data['items'] as List<dynamic>;

    final repoNames = items.map((item) => item['full_name'] as String).toList();
    return repoNames;
  } else {
    throw Exception('Failed to load repositories');
  }
}
