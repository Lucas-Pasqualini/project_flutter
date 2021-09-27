import 'dart:convert';
import 'package:projet_flutter/model/character.dart';
import 'package:http/http.dart' as http;

class GotService {

  static Future<List<Character>> _fetchCharacters() async {
    final charactersListUrl = Uri.parse('https://thronesapi.com/api/v2/Characters');
    final response = await http.get(charactersListUrl);

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((character) => new Character.fromJson(character)).toList();
    }
    else {
      throw Exception("faile to load");
    }
  }
  
}