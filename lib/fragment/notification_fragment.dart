import 'package:flutter/material.dart';
import 'package:stowaway_application/model/notification_model.dart';
class NotificationFragment extends StatefulWidget {
  @override
  _NotificationFragmentState createState() => new _NotificationFragmentState();
}

class _NotificationFragmentState extends State<NotificationFragment> {
  List<NotificationModel> dataList = new List();

  @override
  void initState() {
    // TODO: implement initState
    dataList.add(new NotificationModel("justified—text is aligned along the left margin, and letter- and word-spacing is adjusted so that the text falls flush with both margins, also known as fully","2016-06-11"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    clickOption() {
      print("Click option menu");
    }

    InkWell getListItem(text,date) {
      return new InkWell(
        child: new Padding(
            padding: new EdgeInsets.all(0.0),
            child: new Container(
              width: double.infinity,
              child: new Card(
                color: Colors.white,
                child: new Container(
                    child: new ListTile(
                  //  leading: new Image.asset('images/ring.png'),
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
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: getListItem('${dataList[index].Name}','${dataList[index].date}'),
          );
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
