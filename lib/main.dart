import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stowaway_application/activity/splash_screen.dart';
import 'package:stowaway_application/activity/startscreen.dart';
import 'package:stowaway_application/common/UserPreferences.dart';
import 'package:stowaway_application/navigation_drawer/home_pages.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),

    routes: <String, WidgetBuilder>{
        '/StartScreen': (BuildContext context) => new StartScreen(),
        '/HomePage': (BuildContext context) => new HomePage()
    },
  )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
String login_status = 'FALSE',rout='/StartScreen';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      login_status = prefs.getString(UserPreferences.LOGIN_STATUS);
      if (login_status=='TRUE'){
        rout='/HomePage';
      }else if(login_status=='FALSE'){
        rout='/StartScreen';
      }
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Center(child:  new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: rout,
      imageBackground: new AssetImage("images/splash.jpg"),
      //  title:  new Text("Shuddh H2o"),
      //  image: new Image(image: new AssetImage("images/launcher.gif")),
      // image: new Image.asset(name),
      // image: new Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcxx9ypeeGCqaz5GJXY6gMoGIFlfeqKRQvXltqFA66_mSNPHBkPg'),
      // image: new Image.network('https://flutter.io/images/catalog-widget-placeholder.png'),
      gradientBackground: new LinearGradient(
          colors: [Colors.cyan, Colors.white10],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight),
      backgroundColor: Colors.blue,
      photoSize: 100.0,

    ),
      //  loaderColor: Colors.red,
    );
  }
}