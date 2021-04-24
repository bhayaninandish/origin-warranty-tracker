import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './User.dart';


class DatabaseService{
  String uid;

  DatabaseService(this.uid);

  CollectionReference obj=FirebaseFirestore.instance.collection("users");

  Future CreateUser(UserObj user) async {
    // print("inside updateworker ${req['workername']}");
    return await obj.doc(uid).set({
      "items": user.items,
      "name":user.name,
    }).then((value) => print('create'));
  }


  Future updateItem(dynamic req) async {
    // print("inside updateworker ${req['workername']}");
    return await obj.doc(uid).update({
      "items": FieldValue.arrayUnion([
        {
          "name":req.name,
          "date":req.Date,
          "duration":req.duration,
        }
      ]),
    }).then((value) => print('added'));
  }

  Stream<UserObj> get getcurrentUser {
    // obj.snapshots().
    return obj.snapshots().map(_currentHirer);
  }

  UserObj _currentHirer(QuerySnapshot snapshot) {
    return snapshot.docs.map((element) {
      return UserObj(
        name: element.get('name'),
        items: element.get('items'),
        uid:element.id,
      );
    }).singleWhere((element){
      if(element.uid.compareTo(uid)==0){
        return true;
      } else
        return false;
    });
  }

  Future removeField(dynamic req) async {
    return await obj.doc(uid).update({
      "items": FieldValue.arrayRemove([
        {
          "name":req["name"],
          "date":req["date"],
          "duration":req["duration"],
        }
      ]),
    }).then((value) => print('remove'));
  }

}