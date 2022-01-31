import 'package:flutter/material.dart';
import 'package:projet_flutter/data/models/character.dart';
import 'package:projet_flutter/data/providers/remote/storage_firestore.dart';
import 'package:projet_flutter/pages/display_details_got/web/details_got_character_web.dart';
import '../got_bloc.dart';
import 'package:flutter/material.dart';

class GotApiWeb extends StatefulWidget {
  const GotApiWeb({Key? key}) : super(key: key);

  @override
  _ListGotApiState createState() => _ListGotApiState();
}

class _ListGotApiState extends State<GotApiWeb> {
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

  @override
  Widget build(BuildContext context) {
    StorageHelper().getGame().then((value) => {
          setState(() {
            _game = value.toList();
          })
        });
    width = MediaQuery.of(context).size.width;

    var _selectedIndex;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Game of thrones quizz"),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
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

  _getBuddy() {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            "https://cdn.pixabay.com/photo/2017/02/21/21/13/unicorn-2087450_1280.png",
          ),
        ],
      ),
    ));
  }

  Widget displayName(int index) {
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
  