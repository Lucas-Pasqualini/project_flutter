import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet_flutter/data/providers/remote/authentication_firebase.dart';

class StorageHelper {
  CollectionReference opinions =
      FirebaseFirestore.instance.collection('opinion');

  CollectionReference game =
  FirebaseFirestore.instance.collection('game');

  var uid = AuthenticationHelper().getUid();

  void saveOpinion({opinion, rating, character}) {
    opinions
        .add({
          "character": character,
          "uid": uid,
          "opinion": opinion,
          "rating": rating,
        })
        .then((value) => print("Opinion Added"))
        .catchError((error) => print("Failed to add opinion: $error"));
  }

  Future<List> getOpinion(character) async {
    var res = [];
    await opinions
        .where("character", isEqualTo: character)
        .get()
        .then((querySnapshot) => {
              for (var document in querySnapshot.docs)
                {res.add(document.data())}
            });
    return res;
  }

  Future<List> getGame() async {
    var res = [];
    await game
        .where("uid", isEqualTo: uid)
        .get()
        .then((querySnapshot) => {
      for (var document in querySnapshot.docs)
        {res.add(document.data())}
    });
    return res;
  }

  void saveGame({character}) {
    game
        .add({
      "uid": uid,
      "character": character,
    })
        .then((value) => print("Game Added"))
        .catchError((error) => print("Failed to add game: $error"));
  }
}
