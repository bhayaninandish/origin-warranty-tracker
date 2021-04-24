
import 'package:flutter/material.dart';

class Aboutus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Warranty Extender'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(margin: EdgeInsets.fromLTRB(0, 10, 0, 30),child: Text('1] Origin is an app built for Android users to keep track of warranty',style: TextStyle(fontSize: 25),)),
              Container(margin: EdgeInsets.fromLTRB(0, 0, 0, 30),child: Text('2] We make sure that none of our user misses any deadline regarding the warranty of there appliances',style: TextStyle(fontSize: 25),)),
              Text('3] They are able to retain the best deals and hence are carefree regarding the maintenance of there appliances giving them a longer life.',style: TextStyle(fontSize: 25),)
            ],
          ),
        ),
      ),
    );
  }
}
