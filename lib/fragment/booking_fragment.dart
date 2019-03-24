import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stowaway_application/common/UserPreferences.dart';
import 'dart:convert';

import 'package:stowaway_application/model/order_model.dart';

class BookingFragment extends StatefulWidget {
  @override
  _BookingFragmentState createState() => new _BookingFragmentState();
}

class _BookingFragmentState extends State<BookingFragment> {
  List<OrderModel> list = List();
  var isLoading = false;
  String    userId;



  _fetchData(String token) async {
    setState(() {
      isLoading = true;
    });
    final response =
    await http.get("https://floating-brushlands-52313.herokuapp.com/authentication/order_history",
      headers: {HttpHeaders.authorizationHeader: 'Bearar '+token,
                HttpHeaders.contentTypeHeader : "application/json"},
    );
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new OrderModel.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    getSharedPreferences();
    super.initState();

  }
  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getString(UserPreferences.USER_TOKEN);
      _fetchData(userId);
    });

  }


  /*@override
  Widget build(BuildContext context) {
    // TODO: implement build
    clickOption() {
      print("Click option menu");
    }

    InkWell getListItem(image,text,date) {
      return new InkWell(
        child: new Padding(
            padding: new EdgeInsets.all(0.0),
            child: new Container(
              width: double.infinity,
              child: new Card(
                color: Colors.white,
                child: new Container(
                    child: new ListTile(
                    leading: new Image.network(image),
                  subtitle: new Container(
                    child: new Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Text(date,
                          textAlign: TextAlign.right,
                          style: new TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Roboto',
                          )),
                    ),
                    margin: EdgeInsets.all(5.0),
                  ),

                  title: new Text(text,
                      textAlign: TextAlign.start,
                      style: new TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold)),
                )),
              ),
            )),
      );
    }

    return new Scaffold(

      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: getListItem('${list[index].Image}','${list[index].Title}','${dataList[index].date}'),
          );
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
          title: Text("Fetch Data JSON"),
        ),*/
      /*  bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: new Text("More"),
            onPressed: _fetchData,
          ),
        ),*/
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return /*ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: new Text(list[index].Title),
                trailing: new Image.network('https://sheltered-woodland-33544.herokuapp.com/product_image'+
                  list[index].Image,
                  fit: BoxFit.cover,
                  height: 40.0,
                  width: 40.0,
                ),
              );*/
                new InkWell(
                  child: new Padding(
                      padding: new EdgeInsets.all(0.0),
                      child: new Container(
                        width: double.infinity,
                        child: new Card(
                          color: Colors.white,
                          child: new Container(
                              child: new ListTile(
                              /*  leading: new Image.asset('images/hydroberry.png', fit: BoxFit.cover,
                                  height: 40.0,
                                  width: 40.0,),*/

                                subtitle:
                                new Padding(padding: EdgeInsets.all(0.0),

                                child: new Column(
                                  children: <Widget>[
                                    new Row(
                                     children: <Widget>[
                                 new Expanded(
                                     child: new Container(
                                  child: new Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: new Text('Name : '+list[index].Giver_Name,
                                        textAlign: TextAlign.start,
                                        style: new TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: 'Roboto',
                                        )),
                                  ),
                                  margin: EdgeInsets.all(5.0),
                                ),
                                 ),
                          new Expanded(
                            child:
                              new Container(
                                  child: new Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: new Text('Commodity : '+list[index].Commodity,
                                        textAlign: TextAlign.start,
                                        style: new TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: 'Roboto',
                                        )),
                                  ),
                                  margin: EdgeInsets.all(5.0),
                                ),
                                ),
                                     ],
                                    ),
                        new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new Container(
                                  child: new Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: new Text('Reciver Name : '+list[index].Recevier_Name,
                                        textAlign: TextAlign.start,
                                        style: new TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: 'Roboto',
                                        )),
                                  ),
                                  margin: EdgeInsets.all(5.0),
                                ),
                                ),
                            new Expanded(
                              child:   new Container(
                                  child: new Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: new Text('Reciver Email : '+list[index].Recevier_Email,
                                        textAlign: TextAlign.start,
                                        style: new TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: 'Roboto',
                                        )),
                                  ),
                                  margin: EdgeInsets.all(5.0),
                                ),
                                ),
                                    ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Expanded(
                              child:new Container(
                                  child: new Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: new Text('Reciver Number : '+list[index].Recevier_Phone,
                                        textAlign: TextAlign.start,
                                        style: new TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: 'Roboto',
                                        )),
                                  ),
                                  margin: EdgeInsets.all(5.0),
                                ),
                                ),
                  new Expanded(
                    child:new Container(
                                  child: new Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: new Text('Price : '+list[index].Price,
                                        textAlign: TextAlign.start,
                                        style: new TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: 'Roboto',
                                        )),
                                  ),
                                  margin: EdgeInsets.all(5.0),
                                ),
                                ),
                          ],), new Row(
                        children: <Widget>[
                          new Expanded(
                            child:new Container(
                                  child: new Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: new Text('Receiving Address : '+list[index].Receving_Address,
                                        textAlign: TextAlign.start,
                                        style: new TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: 'Roboto',
                                        )),
                                  ),
                                  margin: EdgeInsets.all(5.0),
                                ),
                                ),
                  new Expanded(
                    child:new Container(
                                  child: new Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: new Text('Delivery Address : '+list[index].Delivery_Address,
                                        textAlign: TextAlign.start,
                                        style: new TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: 'Roboto',
                                        )),
                                  ),
                                  margin: EdgeInsets.all(5.0),
                                ),
                                ),
                    ],),
                                    new Container(
                                      child: new Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: new Text('Order Status : Not Accepted',
                                            textAlign: TextAlign.start,
                                            style: new TextStyle(
                                              fontSize: 13.0,
                                              fontFamily: 'Roboto',
                                              color:Colors.green,
                                              fontWeight: FontWeight.bold
                                            )),
                                      ),
                                      margin: EdgeInsets.all(5.0),
                                    ),      ],
                                ),  ),

                                title: new Text('Order Id : '+list[index].Id,
                                    textAlign: TextAlign.start,
                                    style: new TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold)),
                              )
              ),
                        ),
                      )),
                );
            }));
  }
}
