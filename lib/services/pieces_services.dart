import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_pieces/models/piece.dart';
import 'package:music_pieces/services/authentication_services.dart';
import 'package:music_pieces/services/platform_services.dart';

class PiecesServices {
  static final String _baseApi = PlatformServices.isAndroid
      ? 'http://10.0.2.2:8000/api'
      : 'http://127.0.0.1:8000/api';

  // Read pieces
  static Future<List<Piece>> getAll() async {
    final response = await http.get(
      Uri.parse('$_baseApi/pieces'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AuthenticationServices.getBearerToken()}'
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to retrieve pieces. Status code: ${response.statusCode}');
    }

    List<Piece> pieces = [];
    final json = jsonDecode(response.body);

    for (int i = 0; i < json['data'].length; i++) {
      pieces.add(Piece(
          id: json['data'][i]['id'],
          name: json['data'][i]['name'],
          composer: json['data'][i]['composer'],
          link: json['data'][i]['link'],
          genreId: json['data'][i]['genre_id']));
    }

    AuthenticationServices.setBearerToken(json['access_token']);
    return pieces;
  }

  // Read pieces by genre
  static Future<List<Piece>> getAllByGenre({
    required int genreId,
  }) async {
    final response = await http.get(
      Uri.parse('$_baseApi/genres/$genreId/pieces'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AuthenticationServices.getBearerToken()}'
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to retrieve pieces by genre. Status code: ${response.statusCode}');
    }

    List<Piece> pieces = [];
    final List<dynamic> json = jsonDecode(response.body);

    for (int i = 0; i < json.length; i++) {
      pieces.add(Piece(
        id: json[i]['id'],
        name: json[i]['name'],
        composer: json[i]['composer'],
        link: json[i]['link'],
        genreId: json[i]['genre_id'],
      ));
    }
    print(
        'This is from reading piece by genre: ${AuthenticationServices.getBearerToken()}');

    // Return the list of pieces.
    return pieces;
  }

  // Create
  static Future<Piece> create({
    required String name,
    required String composer,
    required String link,
    required int genreId,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseApi/pieces'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AuthenticationServices.getBearerToken()}'
      },
      body: jsonEncode({
        'name': name,
        'composer': composer,
        'link': link,
        'genre_id': genreId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to create piece. Status code: ${response.statusCode}');
    }

    final json = jsonDecode(response.body);
    final piece = Piece(
      id: json['data']['id'],
      name: json['data']['name'],
      composer: json['data']['composer'],
      link: json['data']['link'],
      genreId: json['data']['genre_id'],
    );

    AuthenticationServices.setBearerToken(json['access_token']);
    print(
        'This is from creating piece: ${AuthenticationServices.getBearerToken()}');
    // Return the created piece.
    return piece;
  }

  // Update
  static Future<Piece> update({
    required int pieceId,
    required String name,
    required int genreId,
    required String composer,
    required String link,
  }) async {
    final response = await http.patch(
      Uri.parse('$_baseApi/pieces/$pieceId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AuthenticationServices.getBearerToken()}'
      },
      body: jsonEncode({
        'id': pieceId,
        'name': name,
        'composer': composer,
        'link': link,
        'genre_id': genreId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to update piece. Status code: ${response.statusCode}');
    }

    final json = jsonDecode(response.body);
    final piece = Piece(
      id: pieceId,
      name: json['data']['name'],
      composer: json['data']['composer'],
      link: json['data']['link'],
      genreId: json['data']['genre_id'],
    );

    AuthenticationServices.setBearerToken(json['access_token']);
    print(
        'This is from updating piece: ${AuthenticationServices.getBearerToken()}');

    // Return the updated piece.
    return piece;
  }

  // Delete
  static Future<void> delete({
    required int pieceId,
  }) async {
    final response = await http.delete(
      Uri.parse('$_baseApi/pieces/$pieceId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AuthenticationServices.getBearerToken()}'
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to delete piece. Status code: ${response.statusCode}');
    }

    final json = jsonDecode(response.body);

    AuthenticationServices.setBearerToken(json['access_token']);
    print(
        'This is from deleting piece: ${AuthenticationServices.getBearerToken()}');
  }
}
