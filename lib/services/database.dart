import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');
  Future updateUserData(String name, String sugars, int strength) async {
    return await brewCollection
        .document(uid)
        .setData({'name': name, 'sugars': sugars, 'strength': strength});
  }

  List<Brew> _brewListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) => Brew(
            name: doc.data['name'],
            sugars: doc.data['sugars'],
            strength: doc.data['strength']))
        .toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapShot);
  }

  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
