import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet_flutter/service/authentication.dart';

class StorageHelper {
  CollectionReference opinions =
      FirebaseFirestore.instance.collection('opinion');
  var uid = AuthenticationHelper().getUid();

  void saveOpinion({opinion, rating, character}) {
    opinions
        .add({
          "character": character,
          "uid": uid,
          "opinion": opinion,
          "rating": rating,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
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
}
