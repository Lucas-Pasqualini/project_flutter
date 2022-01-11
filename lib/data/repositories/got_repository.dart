import 'package:projet_flutter/data/models/character.dart';
import 'package:projet_flutter/data/providers/remote/got_api_provider.dart';

class GotRepository {
  static final GotRepository _singleton = GotRepository._internal();

  factory GotRepository() => _singleton;

  GotRepository._internal();

  Future<List<Character>> getAllCharacters() async {
    return GotApiProvider().getAllCharacters();
  }
}
