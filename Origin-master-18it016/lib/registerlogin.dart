import 'package:origin/afterlogin.dart';
import 'package:origin/flutter.dart';
import 'package:origin/login.dart';
import 'package:origin/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:origin/aboutus.dart';


class RegisterLogin extends StatefulWidget {
  @override
  _RegisterLoginState createState() => _RegisterLoginState();
}

class _RegisterLoginState extends State<RegisterLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Warranty Extender'),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width:200,height:65,decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 4),borderRadius: BorderRadius.circular(8),boxShadow: [new BoxShadow(color: Colors.green,offset: new Offset(6.0, 6.0))]),child: RaisedButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => validate()));},color: Color(0xffFF1744),textColor:Colors.white,child: Text('Sign-up',style: TextStyle(fontSize: 30),),)),
            Container(width:200,height:65,decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 4),borderRadius: BorderRadius.circular(8),boxShadow: [new BoxShadow(color: Colors.green,offset: new Offset(6.0, 6.0))]),margin: EdgeInsets.fromLTRB(0, 30, 0, 0),child: RaisedButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));},color: Color(0xff0091EA),textColor: Colors.white, child: Text('Login',style: TextStyle(fontSize: 30),),)),
            Container(width:200,height:65,decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 4),borderRadius: BorderRadius.circular(8),boxShadow: [new BoxShadow(color: Colors.green,offset: new Offset(6.0, 6.0))]),margin: EdgeInsets.fromLTRB(0, 30, 0, 0),child: RaisedButton(onPressed: () =>googleSignIn().whenComplete(() => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Home()))),color: Color(0xffFf91EA),textColor: Colors.white, child: Text('Sign in with Google',style: TextStyle(fontSize: 18),),)),

          ],
        ),
        padding: EdgeInsets.all(4),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => Aboutus()));},
        child: Icon(Icons.info_outline_rounded,size: 40,),

      ),

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(() async{
      if(await FirebaseAuth.instance.currentUser!=null){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
      }
    });
  }

}

