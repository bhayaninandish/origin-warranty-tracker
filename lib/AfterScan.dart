import 'package:flutter/material.dart';
import './DatabaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './item.dart';
import './User.dart';
import './afterlogin.dart';

class AfterScan extends StatefulWidget {
  String scanvalue;
  UserObj user;

  AfterScan({this.scanvalue, this.user});

  @override
  _AfterScanState createState() => _AfterScanState();
}

class _AfterScanState extends State<AfterScan> {
  int _value = 1;
  Item obj1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  initialValue: widget.scanvalue.split('\n')[0],
                  readOnly: true,
                  // controller: product,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Product"),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: TextFormField(
                    initialValue: widget.scanvalue.split('\n')[1],
                    readOnly: true,
                    // controller: product,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Date"),
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
                    )),
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
                    child: RaisedButton(
                      onPressed: () {
                        if (_value == 1) {
                          obj1 = Item(widget.scanvalue.split('\n')[0],
                              widget.scanvalue.split('\n')[1], '3 months');
                        } else if (_value == 2) {
                          obj1 = Item(widget.scanvalue.split('\n')[0],
                              widget.scanvalue.split('\n')[1], '6 months');
                        } else {
                          obj1 = Item(widget.scanvalue.split('\n')[0],
                              widget.scanvalue.split('\n')[1], '1 year');
                        }
                        //
                        print(widget.user.name);
                        print(widget.user.items);
                        widget.user.items.add(obj1);
                        //
                        if (!widget.user.items.isEmpty) {
                          widget.user.items.add(obj1);
                          widget.user.items.forEach((element) {
                            DatabaseService(
                                FirebaseAuth.instance.currentUser.uid)
                                .updateItem(element);
                          });
                        } else {
                          DatabaseService(FirebaseAuth.instance.currentUser.uid)
                              .updateItem(obj1);
                        }
                        //
                        //
                        Navigator.of(context).pop();
                      },
                      color: Color(0xff0091EA),
                      textColor: Colors.white,
                      child: Text(
                        'Add',
                        style: TextStyle(fontSize: 30),
                      ),
                    )),
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
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Color(0xff0091EA),
                      textColor: Colors.white,
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 30),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
