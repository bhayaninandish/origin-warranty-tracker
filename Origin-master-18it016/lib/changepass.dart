import 'package:origin/flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:origin/login.dart';
import 'package:form_field_validator/form_field_validator.dart';

class change extends StatefulWidget {
  @override
  _changeState createState() => _changeState();
}

class _changeState extends State<change> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void _changepass(String pass) async{
    User user = await FirebaseAuth.instance.currentUser;
    await user.updatePassword(pass).then((_){
      print("Success");
    }).catchError((error){
      print(pass);
    });
    if(user.providerData[0].providerId == 'google.com'){
      await gogleSignIn.disconnect();
    }
    await FirebaseAuth.instance.signOut();
  }
  TextEditingController pass = TextEditingController();
  TextEditingController pass_c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.purple,
          title: Text('Warranty Extender'),
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
                      obscureText: true,
                      controller: pass,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password"
                      ),
                      validator: MultiValidator(
                          [
                            RequiredValidator(errorText: 'Required'),
                            MinLengthValidator(8, errorText: '8 Characters Required'),
                            PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: '1 Special Character Required'),
                          ]
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
                        width:200,height:65,decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 4),borderRadius: BorderRadius.circular(8),boxShadow: [new BoxShadow(color: Colors.green,offset: new Offset(6.0, 6.0))]),margin: EdgeInsets.fromLTRB(0, 30, 0, 0),child: RaisedButton(onPressed: (){if(formkey.currentState.validate()){_changepass(pass.text);Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));}},color: Color(0xff0091EA),textColor: Colors.white, child: Text('Reset',style: TextStyle(fontSize: 30),),)),
                  ],
                ),
              )
          ),
        ),
    );
  }
}
