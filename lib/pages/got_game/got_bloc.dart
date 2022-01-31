import 'package:projet_flutter/data/models/character.dart';
import 'package:projet_flutter/data/repositories/got_repository.dart';

class GotBloc {
  final _repository = GotRepository();

  Future<List<Character>> getCharacters() async {
    var characters = await _repository.getAllCharacters();
    return characters;
  }
}

final GotBloc apiBloc = GotBloc();
