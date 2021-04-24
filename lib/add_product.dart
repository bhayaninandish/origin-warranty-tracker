import 'package:flutter/material.dart';
import 'package:origin/camera.dart';
import './afterlogin.dart';
import './item.dart';
import './DatabaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './User.dart';
import 'package:provider/provider.dart';

class Add_Product extends StatefulWidget {

  @override
  _Add_ProductState createState() => _Add_ProductState();
}

class _Add_ProductState extends State<Add_Product> {
  int _value=1;
  Item obj1;
  // List<Item> itmes=[];



  DateTime pickedDate;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController product = TextEditingController();


  @override
  Widget build(BuildContext context) {
    UserObj user=Provider.of<UserObj>(context);

    void datePicker() async {
      DateTime curDate = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime
            .now()
            .year - 1),
        lastDate: DateTime(DateTime
            .now()
            .year + 2),
      );
      setState(() {
        pickedDate = curDate;
      });
    }
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: product,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Product"
                    ),
                    // onChanged: (text){
                    //   value = text;
                    // },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // elevation: 15,
                      onPressed: datePicker,
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(width: 90,),
                          Text(
                            pickedDate.day.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),

                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: DropdownButton(
                        value: _value,
                        items: [
                          DropdownMenuItem(
                            child: Text('3 months'),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text('6 months'),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text('1 year'),
                            value: 3,
                          )
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });
                        },
                      )
                  ),
                  Container(
                      width: 200,
                      height: 65,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 4),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.green, offset: new Offset(6.0, 6.0))
                          ]),
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: RaisedButton(onPressed: () {
                        String date=pickedDate.day.toString() +"-"+ pickedDate.month.toString() + "-" + pickedDate.year.toString();
                        print(pickedDate.month);

                        if(_value==1){
                          obj1=Item(product.value.text,date,'3 months');
                        }else if(_value==2){
                          obj1=Item(product.value.text,date,'6 months');
                        }else{
                          obj1=Item(product.value.text,date,'1 year');
                        }

                        print(user.name);
                        print(user.items);
                        // user.items.add(obj1);

                        if(!user.items.isEmpty) {
                          user.items.add(obj1);
                          user.items.forEach((element) {
                            DatabaseService(FirebaseAuth.instance.currentUser.uid)
                                .updateItem(element);
                          });

                        }else{
                          DatabaseService(FirebaseAuth.instance.currentUser.uid).updateItem(obj1);
                        }


                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
                      },
                        color: Color(0xff0091EA),
                        textColor: Colors.white,
                        child: Text('Add', style: TextStyle(fontSize: 30),),)),
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickedDate = DateTime.now();
  }
}