import 'package:projet_flutter/model/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Details extends StatefulWidget {
  const Details({
    Key? key,
    required this.character,
  }) : super(key: key);

  static const String routeName = "/details";
  final Character character;

  @override
  DetailsState createState() => DetailsState();
}

class DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character.fullName),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.network(widget.character.imageUrl),
            Text('firstName: ' + widget.character.firstName),
            Text('lastName: ' + widget.character.lastName),
            Text('fullName: ' + widget.character.fullName),
            Text('title: ' + widget.character.title),
            Text('family: ' + widget.character.family),
          ],
        ),
      ),
    );
  }
}
