import 'dart:convert';
import 'package:projet_flutter/data/models/character.dart';
import 'package:http/http.dart' as http;

class GotApiProvider {
  GotApiProvider._();

  static final GotApiProvider _singleton = GotApiProvider._();

  factory GotApiProvider() => _singleton;

  Future<List<Character>> getAllCharacters() async {
    var uri = Uri.parse('https://thronesapi.com/api/v2/Characters');

    var responseFromApi = await http.get(uri);
    List jsonResponse = jsonDecode(responseFromApi.body);
    return jsonResponse
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
