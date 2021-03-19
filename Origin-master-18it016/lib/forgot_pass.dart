import 'package:origin/afterlogin.dart';
import 'package:origin/flutter.dart';
import 'package:origin/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class forgot1 extends StatefulWidget {
  @override
  _forgot1State createState() => _forgot1State();
}

class _forgot1State extends State<forgot1> {
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warranty Extender'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email"
                  ),
                  validator: RequiredValidator(errorText: 'Required'),
                ),
                Container(width:200,height:65,decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 4),borderRadius: BorderRadius.circular(8),boxShadow: [new BoxShadow(color: Colors.green,offset: new Offset(6.0, 6.0))]),margin: EdgeInsets.fromLTRB(0, 30, 0, 0),child: RaisedButton(onPressed: (){if(formkey.currentState.validate()){FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));}},color: Color(0xff0091EA),textColor: Colors.white, child: Text('Reset',style: TextStyle(fontSize: 30),),)),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
