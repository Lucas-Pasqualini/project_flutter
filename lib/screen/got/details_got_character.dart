import 'package:projet_flutter/model/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projet_flutter/service/storage.dart';
import 'package:simple_star_rating/simple_star_rating.dart';
import '../rating.dart';

class DetailsGotCharacter extends StatefulWidget {
  const DetailsGotCharacter({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  DetailsGotCharacterState createState() => DetailsGotCharacterState();
}

class DetailsGotCharacterState extends State<DetailsGotCharacter> {
  List _opinions = [];

  @override
  Widget build(BuildContext context) {
    StorageHelper().getOpinion(widget.character.fullName).then((value) => {
          setState(() {
            _opinions = value.toList();
          })
        });

    return Scaffold(
        appBar: AppBar(
          title: const Text("Opinion"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                    overflow: Overflow.visible,
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        "https://i1.wp.com/passionchateau.fr/wp-content/uploads/2014/07/3_w4q6s.jpg?resize=640%2C360",
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: -75,
                        child: Hero(
                          tag: widget.character,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  widget.character.imageUrl,
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(150),
                              border:
                                  Border.all(color: Colors.white, width: 10),
                            ),
                          ),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 75,
                ),
                Text(
                  widget.character.fullName,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  title: Text(widget.character.title),
                  leading: Image.network(
                    "https://cdn.iconscout.com/icon/premium/png-256-thumb/crown-3078851-2558867.png",
                    width: 30,
                    height: 30,
                  ),
                ),
                ListTile(
                    title: Text(widget.character.family),
                    leading: const Icon(
                      Icons.house,
                      size: 30,
                    )),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "OPINION : ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                _getOpinion()
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
            width: 40,
            height: 40,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Rating(name: widget.character.fullName)));
                },
                child: const Icon(Icons.add),
              ),
            )));
  }

  Widget _getOpinion() {
    if (_opinions.isNotEmpty) {
        return ListView.separated(
          shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: _opinions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_opinions[index]["opinion"]),
                leading: SimpleStarRating(
                  allowHalfRating: true,
                  starCount: 5,
                  rating: _opinions[index]["rating"],
                  size: 20,
                  isReadOnly: true,
                  spacing: 2,
                )
              );
            });
    } else {
      return const Center(child: Text("No opinion for this character"));
    }
  }
}
