import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:origin/DatabaseService.dart';
import 'package:origin/User.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final gogleSignIn = GoogleSignIn();


Future<bool> googleSignIn() async {
  GoogleSignInAccount googleSignInAccount = await gogleSignIn.signIn();
  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
        .authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result = await auth.signInWithCredential(credential);
    User user = await auth.currentUser;
    print(user.uid);
    DatabaseService(user.uid).CreateUser(UserObj(name:user.displayName,uid:user.uid,items:[]));
    return Future.value(true);
  }
}
getProfileImage(){
  if(FirebaseAuth.instance.currentUser.photoURL != null){
    return NetworkImage(FirebaseAuth.instance.currentUser.photoURL);
  }else{
    return NetworkImage('https://www.searchpng.com/wp-content/uploads/2019/02/Profile-ICon.png');
  }

}
void _changepass(String pass) async{
  User user = await FirebaseAuth.instance.currentUser;
  user.updatePassword(pass).then((_){
    print("Success");
  }).catchError((error){
    print("cant change");
  });
}
Future<bool> signIn(String email, String pass) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: pass);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> register(String email, String pass) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: pass);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('Password is too weak.');
    } else if (e.code == 'email already in use') {
      print('Account already exists');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
