import 'dart:js';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter/model/character.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:projet_flutter/screen/got/details.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({ Key? key }) : super(key: key);


static Future<List<Character>> _fetchCharacters() async {
    final charactersListUrl = Uri.parse('https://thronesapi.com/api/v2/Characters');
    final response = await http.get(charactersListUrl);

    if (response.statusCode == 200) {
      print("toto---------------------");
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((character) => new Character.fromJson(character)).toList();
    }
    else {
      throw Exception("faile to load");
    }
  }

  @override
  Widget build(BuildContext context) {

 return Scaffold(
   body: FutureBuilder(
     future: _fetchCharacters(),
     builder: (BuildContext context, AsyncSnapshot<List<Character>> character){
       if (character.hasData) {
          return ListView.builder(
            itemCount: character.data!.length,
            itemBuilder: (context, position){
              return (
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(backgroundImage: NetworkImage(character.data![position].imageUrl),),
                        title: Text(character.data![position].fullName),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_right_outlined),
                              onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Details(character.data![position]))
                              );
                            },
                            )
                          ],
                        )
                      ),
                    ],
                  )
              ,)
              );
            },
            
          );
         
       } else {
         return CircularProgressIndicator();
       }
     },
     ),
 );
}
}