import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stowaway_application/activity/home.dart';
import 'package:stowaway_application/activity/logout.dart';
import 'package:stowaway_application/activity/payment_activity.dart';
import 'package:stowaway_application/activity/profile_edit.dart';
import 'package:stowaway_application/activity/startscreen.dart';
import 'package:stowaway_application/common/UserPreferences.dart';
import 'package:stowaway_application/common/socket_activity.dart';
import 'package:stowaway_application/fragment/booking_fragment.dart';
import 'package:stowaway_application/fragment/first_fragment.dart';
import 'package:stowaway_application/fragment/mapactivity.dart';
import 'package:stowaway_application/fragment/notification_fragment.dart';
import 'package:stowaway_application/fragment/payment_fragment.dart';
class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Home", Icons.home),
    new DrawerItem("Payment", Icons.payment),
    new DrawerItem("My Bookings", Icons.update),
    new DrawerItem("Notification", Icons.notifications),
    new DrawerItem("Setting", Icons.settings),
    new DrawerItem("Help", Icons.help),
    new DrawerItem("Logout", Icons.exit_to_app)
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  String userId,_name,_email,_mobile;
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new Home();
      case 1:
        return new PaymentFragment();
      case 2:
        return new BookingFragment();
      case 3:
        return new NotificationFragment();
        case 4:
        return new Home();

        case 5:
        return new Home();

      case 6:
      return  new Logout();
      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getString(UserPreferences.USER_ID);
      _name = prefs.getString(UserPreferences.USER_NAME);
      _email = prefs.getString(UserPreferences.USER_EMAIL);
      _mobile = prefs.getString(UserPreferences.USER_MOBILE);
    String  toke = prefs.getString(UserPreferences.USER_TOKEN);
      print('userID'+userId+" : "+_name+" : "+_email+" : "+_mobile+" : "+toke);
    });

  }


  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

     prefs.setString(UserPreferences.LOGIN_STATUS, "FALSE");
    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                StartScreen()));

  }

 /* final textName =new Padding(padding: EdgeInsets.all(2.0),
  child: new Text('${_name}'),
  );
  final textEmail =new Padding(padding: EdgeInsets.all(2.0),
  child: new Text("${_email}"),
  );*/

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(

          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          ),
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can inste  ad choose to have a static title
         backgroundColor: Colors.orange,
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      /*  actions: [

          new IconButton(
            icon: new Image.asset('images/logout.png'),
            //tooltip: 'Closes application',
            onPressed: () =>   Fluttertoast.showToast(
                msg: "Logout",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0),
          ),

        ],*/
      ),
      drawer:  new Drawer(
        child: new SingleChildScrollView(child:new Column(children: <Widget>[ new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(

        decoration: new BoxDecoration(color: Colors.orange),
        currentAccountPicture:

        new Center(

            child: new Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (BuildContext context) =>  ProfileEdit()));
                    },
                    child:new Container(
                      width: 60.0,
                      height: 60.0,

                      decoration: new BoxDecoration(

                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,

                              image: new AssetImage('images/man.png'),

                          )
                      ),

                    ),

                  ),
           ] ),
            ),
                accountName: new Text('${_name}'),
                accountEmail :new Text('${_email}')
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ],),),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}