import 'package:origin/changepass.dart';
import 'package:origin/flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:origin/registerlogin.dart';
import 'package:origin/register.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  String email = FirebaseAuth.instance.currentUser.email.toString();
  String cuser= FirebaseAuth.instance.currentUser.displayName.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warranty Extender'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              //margin: EdgeInsets.only(top: 30),
              child: CircleAvatar(
                backgroundImage: getProfileImage(),
                radius: 50,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 30),
                child:
                Text(email,style: TextStyle(fontSize: 25))
            ),
            //Text(,style: TextStyle(fontSize: 25),)
            Container(width:200,height:65,decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 4),borderRadius: BorderRadius.circular(8),boxShadow: [new BoxShadow(color: Colors.green,offset: new Offset(6.0, 6.0))]),margin: EdgeInsets.fromLTRB(0, 30, 0, 0),child: RaisedButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => change()));},color: Color(0xff0091EA),textColor: Colors.white, child: Text('Change',style: TextStyle(fontSize: 30),),)),
          ],
        ),
      ),
    );
  }
}
