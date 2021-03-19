import 'package:origin/Nav.dart';
import 'package:origin/flutter.dart';
import 'package:origin/registerlogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:origin/camera.dart';
import 'package:origin/add_product.dart';
import 'package:origin/saved.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Camera(),
    Add_Product(),
    Saved(),

  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appbar'),
        backgroundColor: Colors.purple,
      ),
        body: _widgetOptions[_selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.camera,
                color: Colors.purple,

              ),
              title: Text(
                'Camera',

              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: Colors.purple,

              ),
              title: Text(
                'Add product',

              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.insert_drive_file,
                color: Colors.purple,
              ),
              title: Text(
                'Saved',
              ),
            ),


          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          selectedFontSize: 16.0,
          unselectedFontSize: 13.0,
        ),
      drawer: Nav(),
      );
  }
}
