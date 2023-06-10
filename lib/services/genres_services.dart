import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_pieces/models/genre.dart';
import 'package:music_pieces/services/platform_services.dart';
import 'package:music_pieces/services/authentication_services.dart';

class GenreServices {
  static final String _baseApi = PlatformServices.isAndroid
      ? 'http://10.0.2.2:8000/api'
      : 'http://127.0.0.1:8000/api';

  static Future<List<Genre>> getAll() async {
    final response = await http.get(
      Uri.parse('$_baseApi/genres'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Charset': 'utf-8',
        'Authorization': 'Bearer ${AuthenticationServices.getBearerToken()}'
      },
    );

    // If the request to retrieve genres is unsuccessful, throw an exception.
    if (response.statusCode != 200) {
      throw Exception(
          'Failed to retrieve genres. Status code: ${response.statusCode}');
    }

    List<Genre> genres = [];
    final json = jsonDecode(response.body);

    // Iterate over each genre data in the response and create Genre objects.
    for (var genreData in json['data']) {
      genres.add(Genre(
        id: genreData['id'],
        name: genreData['name'],
      ));
    }

    // Set the bearer token from the response in the authentication service.
    AuthenticationServices.setBearerToken(json['access_token']);
    print(
        'This is from reading genre: ${AuthenticationServices.getBearerToken()}');

    // Return the list of genres.
    return genres;
  }
}
