
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stowaway_application/common/UserPreferences.dart';

const String URID = "https://floating-brushlands-52313.herokuapp.com/";
const String URI = "https://fast-reef-53121.herokuapp.com/";

class SocketActivity extends StatefulWidget {
  @override
  _SocketActivityState createState() => _SocketActivityState();
}

class _SocketActivityState extends State<SocketActivity> {
  String userId,_name,_email,_mobile;

  List<String> toPrint = ["trying to conenct"];
  SocketIOManager manager;
  SocketIOManager managerD;
  SocketIO socket;
  SocketIO socketD;
  bool isProbablyConnected = false;
  bool isProbablyConnectedD = false;

  @override
  void initState() {
    super.initState();
    manager = SocketIOManager();
    managerD = SocketIOManager();
    initSocket();
    getSharedPreferences();
  }



  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getString(UserPreferences.USER_ID);
      _name = prefs.getString(UserPreferences.USER_NAME);
      _email = prefs.getString(UserPreferences.USER_EMAIL);
      _mobile = prefs.getString(UserPreferences.USER_MOBILE);
    });

  }

  initSocket() async {
    setState(() => isProbablyConnected = true
    );
    socket = await manager.createInstance(
      //Socket IO server URI
        URI,
        //Query params - can be used for authentication
        query: {
          "auth": "--SOME AUTH STRING---",
          "info": "new connection from adhara-socketio",
          "timestamp": DateTime.now().toString()
        },
        //Enable or disable platform channel logging
        enableLogging: false
    );
    socket.onConnect((data) {
      pprint("connected...");
      pprint(data);
    });
    socket.onConnectError(pprint);
    socket.onConnectTimeout(pprint);
    socket.onError(pprint);
    socket.onDisconnect(pprint);
    socket.on("request_accepted_driver", (data) {
      pprint("news");
      pprint(data);
    });
    socket.connect();

    socketD = await managerD.createInstance(
      //Socket IO server URI
        URID,
        //Query params - can be used for authentication
        query: {
          "auth": "--SOME AUTH STRING---",
          "info": "new connection from adhara-socketio",
          "timestamp": DateTime.now().toString()
        },
        //Enable or disable platform channel logging
        enableLogging: false
    );
    socketD.onConnect((data) {
      pprint("connected...");
      pprint(data);
     // sendMessage();
    });
    socketD.onConnectError(pprint);
    socketD.onConnectTimeout(pprint);
    socketD.onError(pprint);
    socketD.onDisconnect(pprint);
   socketD.on("request_accepted_driver", (data) {
      pprint("news");
      pprint('AnkitData'+data);
    });

    socketD.connect();
  }

  disconnect() async {
    await manager.clearInstance(socket);
    await managerD.clearInstance(socketD);
    setState(() => isProbablyConnected = false);
  }

  sendMessage() {
    if (socketD != null) {
      pprint("sending message...");

 Map map = {

        "email":_email,
        "name":_name,
        "mobile":_mobile,
        "userid":userId
      };

      String jsonData = '{"type":"Text"}';

      socketD.emit("request",  [
        {"User_id":"5c8aa68390c88700248c574a",
        "Commodity":"Laptop",
        "Receving_Address":"assa",
        "Delivery_Address":"dgdhdh",
        "Giver_Name":"aditya",
        "Giver_Phone":"9051571833",
        "Recevier_Phone":"123456789",
        "Recevier_Name":"Atharva",
        "Recevier_Email":"atharvamungee@gmail.com",
        "Price":"123",
        "Weight":"2kg",
        "Date":"34534545",
        "Name": "sdfdf",
        "MobileNo": "Sdfgsdfg",
        "Email": "SDfgsdfg",
        "_id": "sdfgdsfgdsfg"},
      ]);

      pprint("Message emitted...");
    }
  }

  pprint(data) {
    setState(() {
     /* if (data is Map) {
        data = json.encode(data);
        String status = data['Commodity'];
        toPrint.add(data);

      }*/
      print(data);
      toPrint.add(data);

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: TextTheme(
            title: TextStyle(color: Colors.white),
            headline: TextStyle(color: Colors.white),
            subtitle: TextStyle(color: Colors.white),
            subhead: TextStyle(color: Colors.white),
            body1: TextStyle(color: Colors.white),
            body2: TextStyle(color: Colors.white),
            button: TextStyle(color: Colors.white),
            caption: TextStyle(color: Colors.white),
            overline: TextStyle(color: Colors.white),
            display1: TextStyle(color: Colors.white),
            display2: TextStyle(color: Colors.white),
            display3: TextStyle(color: Colors.white),
            display4: TextStyle(color: Colors.white),
          ),
          buttonTheme: ButtonThemeData(
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              disabledColor: Colors.lightBlueAccent.withOpacity(0.5),
              buttonColor: Colors.lightBlue,
              splashColor: Colors.cyan
          )
      ),
      home: Scaffold(

        body: Container(
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Center(
                    child: ListView(
                      children: toPrint.map((String _) => Text(_ ?? "")).toList(),
                    ),
                  )),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   /*  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: RaisedButton(
                      child: Text("Connect"),
                      onPressed: isProbablyConnected?null:initSocket,
                    ),
                  ),
*/
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: RaisedButton(
                        child: Text("Accept"),
                        onPressed: isProbablyConnected?sendMessage:null,
                      )
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: RaisedButton(
                        child: Text("Deny"),
                        onPressed: isProbablyConnected?disconnect:null,
                      )
                  ),
                ],
              ),
              SizedBox(height: 12.0,)
            ],
          ),
        ),
      ),
    );
  }
}
