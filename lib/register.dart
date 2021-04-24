import 'package:firebase_auth/firebase_auth.dart';
import 'package:origin/DatabaseService.dart';
import 'package:origin/afterlogin.dart';
import 'package:origin/flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'User.dart';
class validate extends StatefulWidget {
  @override
  _validateState createState() => _validateState();
}

class _validateState extends State<validate> {
  bool shouldNavigate;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController pass_c = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warranty Extender'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Center(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username"
                    ),
                    onChanged: (text){
                      value = text;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Email"
                        ),
                        validator: MultiValidator(
                            [
                              RequiredValidator(errorText: 'Required'),
                              EmailValidator(errorText: "Not a Valid email"),
                            ]
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      obscureText: true,
                      controller: pass,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password'
                      ),
                      validator: MultiValidator(
                          [
                            RequiredValidator(errorText: 'Required'),
                            MinLengthValidator(8, errorText: '8 Characters Required'),
                            PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: '1 Special Character Required'),
                          ]
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        obscureText: true,
                        controller: pass_c,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Re-Enter Password'
                        ),
                        validator:(value){
                          if(value.isEmpty){
                            return 'Required';
                          }
                          if(value!=pass.text){
                            return 'Not match';
                          }else{
                            return null;
                          }
                        },
                      )

                  ),
                  Container(
                      width:200,height:65,
                      decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 4),borderRadius: BorderRadius.circular(8),boxShadow: [new BoxShadow(color: Colors.green,offset: new Offset(6.0, 6.0))]),margin: EdgeInsets.fromLTRB(0, 30, 0, 0),child: RaisedButton(onPressed: () async{if(formkey.currentState.validate()){print("inside");shouldNavigate = await register(email.text, pass.text );
                  if( shouldNavigate){
                    UserObj user=UserObj(
                      name: username.value.text,
                      items: [],
                      uid: FirebaseAuth.instance.currentUser.uid,
                    );
                    DatabaseService(FirebaseAuth.instance.currentUser.uid).CreateUser(user);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
                  }
                  }},color: Color(0xff0091EA),textColor: Colors.white, child: Text('Signup',style: TextStyle(fontSize: 30),),)),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
