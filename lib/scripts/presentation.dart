import 'package:admission_app/scripts/elements.dart';
import 'package:flutter/material.dart';
import 'start.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';


class Presentation extends StatefulWidget{
  @override 
  PresentationState createState() => PresentationState();
}

class PresentationState extends State<Presentation> {
  String link;
  String id;
  String text = "";
  Color primary = Color(0xFF01497c);

  @override
  void initState() {
    _launchURL();
    super.initState();
  }

  _launchURL() async {
    const url = 'https://ibarraransoftware.com/admission/presentation';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override 
  Widget build(BuildContext context) {

    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Color(0xFF01497c),
              size: 50,
            ),
            title: Container(
              alignment: Alignment.topLeft,
              child: InkWell(
                child: Icon(
                  Icons.west_rounded,
                  color: Color(0xFF01497c),
                  size: 30,
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Start()));
                },
              ),
            ),
          ),
          body: new Column(
            children: [
              Container(
                margin: EdgeInsets.only(top:10, left:5, right:5),
                decoration: BoxDecoration(
                    color: Color(0xFFF9F9F9),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF000000),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(0, 0),
                      ),
                    ]
                ),

              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, right:20, top:30, bottom:30),
                        child: Text(
                          text.replaceAll("\\n", "\n"),
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: "Rope",
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}