import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GitHubClient {
  final githubToken = dotenv.env['GITHUB_TOKEN'];

  // TODO: add paggination and endless scroll
  Future<List<String>> getRepositoriesByName(String name) async {
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

    final data = await _get(url);

    final items = data['items'] as List<dynamic>;

    final repoNames = items.map((item) => item['full_name'] as String).toList();
    return repoNames;
  }

  Future _get(Uri url) async {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $githubToken',
      },
    );

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        return data;
      } catch (e) {
        throw Exception('Failed to parse repositories');
      }
    } else {
      print(response);
      throw Exception('Failed to load repositories');
    }
  }
}
