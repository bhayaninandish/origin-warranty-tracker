import 'package:origin/aboutus.dart';
import 'package:origin/profile.dart';
import 'package:origin/registerlogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:origin/flutter.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  String email = FirebaseAuth.instance.currentUser.email.toString();
  @override
  Widget build(BuildContext context) {
    return  Drawer(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Colors.purple,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 30),
                      child: CircleAvatar(
                        backgroundImage: getProfileImage(),
                        radius: 50,
                      ),
                    ),

                    Text(email,style: TextStyle(fontSize: 15,color: Colors.white),),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile',style: TextStyle(fontSize: 18),),
              onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => profile()));},
            ),
            ListTile(
              leading: Icon(Icons.info_outline_rounded),
              title: Text('About us',style: TextStyle(fontSize: 18),),
              onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => Aboutus()));},
            ),
            ListTile(
                leading: Icon(Icons.arrow_back),
                title: Text('Logout',style: TextStyle(fontSize: 18),),
                onTap: () async{
                  User user = await auth.currentUser;
                  if(user.providerData[0].providerId == 'google.com'){
                    await gogleSignIn.disconnect();
                  }

                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterLogin()));
                }
            )
          ],
        )
    );
  }
}
