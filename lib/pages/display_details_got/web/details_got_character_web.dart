import 'package:projet_flutter/data/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projet_flutter/data/providers/remote/storage_firestore.dart';
import 'package:simple_star_rating/simple_star_rating.dart';
import '../../display_rating/web/display_rating_web.dart';

class DetailsGotCharacterWeb extends StatefulWidget {
  const DetailsGotCharacterWeb({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  DetailsGotCharacterState createState() => DetailsGotCharacterState();
}

class DetailsGotCharacterState extends State<DetailsGotCharacterWeb> {
  List _opinions = [];
  late double height;
  late double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
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
                      SizedBox(
                        height: height * 0.5,
                        width: double.infinity,
                        child: Image.network(
                          "https://www.wallpapertip.com/wmimgs/1-12470_game-of-thrones-wallpapers-game-of-thrones-sigils.jpg",
                          fit: BoxFit.cover,
                        ),
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
                Padding(
                  padding: EdgeInsets.only(left: width * 0.2),
                  child: ListTile(
                    title: Text(widget.character.title),
                    leading: Image.network(
                      "https://cdn.iconscout.com/icon/premium/png-256-thumb/crown-3078851-2558867.png",
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.2),
                  child: ListTile(
                      title: Text(widget.character.family),
                      leading: const Icon(
                        Icons.house,
                        size: 30,
                      )),
                ),
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
                          DisplayRatingWeb(name: widget.character.fullName)));
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
                ));
          });
    } else {
      return const Center(child: Text("No opinion for this character"));
    }
  }
}
