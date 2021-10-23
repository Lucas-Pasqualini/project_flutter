import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet_flutter/model/character.dart';
import 'details_got_character.dart';

class ListGotApi extends StatefulWidget {
  const ListGotApi({Key? key}) : super(key: key);

  @override
  _ListGotApiState createState() => _ListGotApiState();
}

class _ListGotApiState extends State<ListGotApi> {
  List<Character> _characters = [];

  Future<void> getAllCharacters() async {
    var uri = Uri.parse('https://thronesapi.com/api/v2/Characters');

    var responseFromApi = await http.get(uri);
    if (responseFromApi.statusCode == 200) {
      setState(() {
        List jsonResponse = jsonDecode(responseFromApi.body);
        _characters = jsonResponse
            .map((character) => Character.fromJson(character))
            .toList();
      });
    }
  }

  Widget _getBuddy() {
    if (_characters.isNotEmpty) {
      return ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: _characters.length,
          itemBuilder: (context, index) {
            return displayName("", index);
          });
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    getAllCharacters();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Game of thrones"),
      ),
      body: _getBuddy(),
    );
  }

  Widget displayName(String name, int index) {
    if (name == _characters[index].fullName) {
      return ListTile(
        title: Text(_characters[index].fullName),
        leading: Hero(
          tag: _characters[index],
          child: CircleAvatar(
            backgroundImage: NetworkImage(_characters[index].imageUrl),
            radius: 30,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  DetailsGotCharacter(character: _characters[index])));
        },
      );
    } else {
      return Row(children: [
        Hero(
          tag: _characters[index],
          child: CircleAvatar(
            backgroundImage: NetworkImage(_characters[index].imageUrl),
            radius: 30,
          ),
        ),
        const TextField(),
        // TextButton(
        //   child: const Text("test"),
        //   onPressed: () {
        //     if (true) {}
        //   },
        // )
      ]);
    }
  }
}
