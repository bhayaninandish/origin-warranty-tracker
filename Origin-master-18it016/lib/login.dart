import 'package:origin/afterlogin.dart';
import 'package:origin/flutter.dart';
import 'package:origin/forgot_pass.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                      controller: email,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email"
                      ),
                      validator: RequiredValidator(errorText: 'Required'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                          obscureText: true,
                          controller: pass,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password"
                          ),
                          validator: MultiValidator(
                              [
                                RequiredValidator(errorText: 'Required'),
                              ]
                          )
                      ),
                    ),
                    Container(width:200,height:65,decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 4),borderRadius: BorderRadius.circular(8),boxShadow: [new BoxShadow(color: Colors.green,offset: new Offset(6.0, 6.0))]),margin: EdgeInsets.fromLTRB(0, 30, 0, 10),child: RaisedButton(onPressed: ()async{if(formkey.currentState.validate()){bool shouldNavigate = await signIn(email.text, pass.text );if (shouldNavigate){Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));}}},color: Color(0xff0091EA),textColor: Colors.white, child: Text('Login',style: TextStyle(fontSize: 30),),)),
                    TextButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => forgot1()));}, child: Text('Forgot Password?',style: TextStyle(fontSize: 20),)),
                  ]
              ),
            ),

          ),

        ),
      ),
    );
  }
}
