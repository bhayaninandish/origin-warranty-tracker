import 'package:firebase_auth/firebase_auth.dart';
import 'package:origin/DatabaseService.dart';
import 'package:flutter/material.dart';
import './User.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view/shape_of_view.dart';
import './afterlogin.dart';

class Saved extends StatelessWidget {
  String newDate;

  @override
  Widget build(BuildContext context) {
    List<dynamic> save_item = [];

    var obj = Provider.of<UserObj>(context);
    if (obj != null) {
      obj.items.forEach((element) {
        // print(element['workername']);
        save_item.add(element);
      });
    }

    void _onPressed(int index) {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          context: context,
          builder: (context) {
            return Container(
              height: 100,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Colors.red[900],
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    onPressed: () async {
                      DatabaseService(FirebaseAuth.instance.currentUser.uid)
                          .removeField(save_item[index]);

                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Delete Item',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
    }

    String calDuration(String dur, int index){
      if(dur.compareTo('3 months')==0){
        int month=int.parse(save_item[index]['date'].toString().split("-")[1]);
        int year=int.parse(save_item[index]['date'].toString().split("-")[2]);
        int duration=month+3;
        if(duration>12){
          duration=duration-12;
          ++year;
          newDate=save_item[index]['date'].toString().split("-")[0] + "-"+duration.toString()+"-"+year.toString();
        }else{
          newDate=save_item[index]['date'].toString().split("-")[0] + "-"+duration.toString()+"-"+year.toString();
        }
        return newDate;
      }else if(dur.compareTo('6 months')==0){
        int month=int.parse(save_item[index]['date'].toString().split("-")[1]);
        int year=int.parse(save_item[index]['date'].toString().split("-")[2]);
        int duration=month+6;
        if(duration>12){
          duration=duration-12;
          ++year;
          newDate=save_item[index]['date'].toString().split("-")[0] + "-"+duration.toString()+"-"+year.toString();
        }else{
          newDate=save_item[index]['date'].toString().split("-")[0] + "-"+duration.toString()+"-"+year.toString();
        }
        return newDate;
      }else{
        int month=int.parse(save_item[index]['date'].toString().split("-")[1]);
        int year=int.parse(save_item[index]['date'].toString().split("-")[2]);
        ++year;
        newDate=save_item[index]['date'].toString().split("-")[0] + "-"+month.toString()+"-"+year.toString();
        return newDate;
      }
    }

    Color checkExp(){

      DateTime currDate=DateTime.now();
      int expMonth=int.parse(newDate.split("-")[1]);
      int expDate=int.parse(newDate.split("-")[0]);
      int expYear=int.parse(newDate.split("-")[2]);
      if(currDate.year>expYear){
        return Colors.redAccent;
      }else if(currDate.year==expYear && currDate.month>expMonth){
        return Colors.redAccent;
      }else if(currDate.year==expYear && currDate.month==expMonth && currDate.day>expDate){
        return Colors.redAccent;
      }else if(currDate.year==expYear && currDate.month==expMonth && currDate.day>expDate-7){
        return Colors.yellow;
      }else{
        return Colors.green;
      }

    }

    return Container(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        itemCount: save_item.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => _onPressed(index),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ShapeOfView(
                shape: CutCornerShape(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 20,
                child: Container(
                  // color: Colors.white,
                  width: 500,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        save_item[index]["name"],
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.access_time,
                            color: Colors.grey,
                            size: 18,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            calDuration(save_item[index]["duration"].toString(), index),
                            style: TextStyle(fontSize: 18,color: checkExp()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
