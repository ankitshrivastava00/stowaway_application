import 'package:flutter/material.dart';


class PaymentActivity extends StatefulWidget {
  @override
  _PaymentActivityState createState() => _PaymentActivityState();
}

class _PaymentActivityState extends State<PaymentActivity> {
  var publicKey = '[YOUR_PAYSTACK_PUBLIC_KEY]';

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(0XFF00b1e1),
          body: new Container(
            margin: const EdgeInsets.symmetric(
              vertical: 100.0,
              horizontal: 24.0,
            ),
            child: new Stack(
              children: <Widget>[
                new Container(
                  child: new Container(
                    constraints: new BoxConstraints.expand(),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          height: 80.0,
                          color: Color(0xFFE2E2E2),
                        ),
                        new Container(height: 16.0),
                        new Text(
                          "Razorpay T-Shirt",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        new Container(height: 8.0),
                        new Text("INR 1.0"),
                        new Container(height: 8.0),
                        new Text(
                          "This is a real transcation",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        new Container(height: 16.0),
                        new RaisedButton(
                          onPressed: () {
                            //startPayment();
                          },
                          child: new Text(
                            "Purchase",
                            style: TextStyle(color: Colors.white),

                          ),
                          color: Colors.green,
                          splashColor: Colors.blue,
                        )
                      ],
                    ),
                  ),
                  height: 280.0,
                  margin: new EdgeInsets.only(top: 72.0),
                  decoration: new BoxDecoration(
                    color: new Color(0xFFFFFFFF),
                    shape: BoxShape.rectangle,
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.symmetric(vertical: 16.0),
                  alignment: FractionalOffset.topCenter,
                  child: Column(
                    children: <Widget>[
                      new Image.network(
                        "https://www.73lines.com/web/image/12427",
                        width: 92.0,
                        height: 92.0,
                      ),
                      new Container(height: 12.0),
                      new Text("Order #RZP42"),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
/*
  startPayment() async {
    Map<String, dynamic> options = new Map();
    options.putIfAbsent("name", () => "Razorpay T-Shirt");
    options.putIfAbsent("image", () => "https://www.73lines.com/web/image/12427");
    options.putIfAbsent("description", () => "This is a real transaction");
    options.putIfAbsent("amount", () => "100");
    options.putIfAbsent("email", () => "test@testing.com");
    options.putIfAbsent("contact", () => "9988776655");
    //Must be a valid HTML color.
    options.putIfAbsent("theme", () => "#FF0000");
    options.putIfAbsent("api_key", () => "rzp_live_jvB6dYPSWVYnEp");
    Map<dynamic,dynamic> paymentResponse = new Map();
    paymentResponse = await Razorpay.showPaymentForm(options);
    print("response $paymentResponse");
  }*/
/*
 startPayment() async {
    Map<String, dynamic> options = new Map();
    options.putIfAbsent("name", () => "Razorpay T-Shirt");
    options.putIfAbsent("image", () => "https://www.73lines.com/web/image/12427");
    options.putIfAbsent("description", () => "This is a real transaction");
    options.putIfAbsent("amount", () => "100");
    options.putIfAbsent("email", () => "test@testing.com");
    options.putIfAbsent("contact", () => "9988776655");
    //Must be a valid HTML color.
    options.putIfAbsent("theme", () => "#FF0000");
    options.putIfAbsent("api_key", () => "haha");
    //Notes -- OPTIONAL
    Map<String, String> notes = new Map();
    notes.putIfAbsent('key', () => "value");
    notes.putIfAbsent('randomInfo', () => "haha");
    options.putIfAbsent("notes", () => notes);
    Map<dynamic,dynamic> paymentResponse = new Map();
    paymentResponse = await Razorpay.showPaymentForm(options);
    print("response $paymentResponse");

  }


startPayment() async {
    Map<String, dynamic> options = new Map();
    options.putIfAbsent("name", () => "Razorpay T-Shirt");
    options.putIfAbsent("image", () => "https://www.73lines.com/web/image/12427");
    options.putIfAbsent("description", () => "This is a real transaction");
    options.putIfAbsent("amount", () => "100");
    options.putIfAbsent("email", () => "test@testing.com");
    options.putIfAbsent("contact", () => "9988776655");
    //Must be a valid HTML color.
    options.putIfAbsent("theme", () => "#FF0000");
    //Notes -- OPTIONAL
    Map<String, String> notes = new Map();
    notes.putIfAbsent('key', () => "value");
    notes.putIfAbsent('randomInfo', () => "haha");
    options.putIfAbsent("notes", () => notes);
    options.putIfAbsent("api_key", () => "rzp_live_jvB6dYPSWVYnEp");
    Map<dynamic,dynamic> paymentResponse = new Map();
    paymentResponse = await Razorpay.showPaymentForm(options);
    print("response $paymentResponse");
}*/
/*
  Future<Null> startPayment() async {
    String apiKey = "rzp_test_xDhZniW6E8lmwa";
    Map<String, String> notes = new Map();
    notes.putIfAbsent('billing_address', () => "Somewhere on earth");
    notes.putIfAbsent('shipping_address', () => "Somewhere near India");

    Map<String, dynamic> options = new Map();
    options.putIfAbsent("name", () => "Laptop");
    options.putIfAbsent("image", () => "https://s3.amazonaws.com/rzp-mobile/images/rzp.png"); // optional arguement
    options.putIfAbsent("description", () => "Testing razorpay transaction");
    options.putIfAbsent("amount", () => "100");
    options.putIfAbsent("email", () => "test@gmail.com");
    options.putIfAbsent("contact", () => "+919825123456");

    // additional notes support. https://docs.razorpay.com/docs/notes
    options.putIfAbsent("notes", () => notes);

    options.putIfAbsent("theme", () => "#4D68FF"); // optional arguement
    options.putIfAbsent("api_key", () => apiKey);

    Map<dynamic,dynamic> paymentResponse = new Map();
    paymentResponse = await FlutterRazorpaySdk.openPaymentDialog(options);
    print("response $paymentResponse");

  }*/
  }