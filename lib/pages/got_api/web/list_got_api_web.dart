import 'package:flutter/material.dart';
import 'package:projet_flutter/data/models/character.dart';
import '../../display_details_got/web/details_got_character_web.dart';
import 'package:projet_flutter/data/providers/remote/storage_firestore.dart';
import '../got_bloc.dart';

class ListGotApiWeb extends StatefulWidget {
  const ListGotApiWeb({Key? key}) : super(key: key);

  @override
  _ListGotApiState createState() => _ListGotApiState();
}

class _ListGotApiState extends State<ListGotApiWeb> {
  List<Character> _characters = [];
  late double width;
  final List<TextEditingController> _controllers = [];
  List _game = List.empty();

  Future<void> getAllCharacters() async {
    var characterList = await apiBloc.getCharacters();
    setState(() {
      _characters = characterList;
    });
  }

  Widget _getBuddy() {
    if (_characters.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: _characters.length,
            itemBuilder: (context, index) {
              _controllers.add(TextEditingController());
              return displayName(index);
            }),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    StorageHelper().getGame().then((value) => {
          setState(() {
            _game = value.toList();
          })
        });
    width = MediaQuery.of(context).size.width;

    getAllCharacters();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Game of thrones"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.help_outline_outlined),
              onPressed: () {
                _showMyDialog();
              },
            ),
          )
        ],
      ),
      body: _getBuddy(),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rules of the game'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    "To print an opinion, you must to find the correct character's name"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Play'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool checkListGame(String character) {
    return _game.map((item) => item["character"] == character).contains(true);
  }

  Widget displayName(int index) {
    if (_game.isNotEmpty && checkListGame(_characters[index].fullName)) {
      return Center(
        child: SizedBox(
          width: width * 0.6,
          child: ListTile(
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
                      DetailsGotCharacterWeb(character: _characters[index])));
            },
          ),
        ),
      );
    } else {
      return Center(
        child: SizedBox(
          width: width * 0.6,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: CircleAvatar(
                backgroundImage: NetworkImage(_characters[index].imageUrl),
                radius: 30,
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 20),
                width: width * 0.5,
                child: TextField(
                  controller: _controllers[index],
                )),
            IconButton(
                onPressed: () {
                  if (_controllers[index]
                          .text
                          .compareTo(_characters[index].fullName) ==
                      0) {
                    StorageHelper()
                        .saveGame(character: _characters[index].fullName);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailsGotCharacterWeb(
                            character: _characters[index])));
                  } else {
                    _controllers[index].text = "";
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Incorrect name",
                        style: TextStyle(fontSize: 16),
                      ),
                    ));
                  }
                },
                icon: const Icon(Icons.check))
          ]),
        ),
      );
    }
  }
}
