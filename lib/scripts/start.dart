import 'package:admission_app/scripts/Applicants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';
import 'elements.dart';
import 'allApplicants.dart';
import 'admitted.dart';
import 'presentation.dart';

class Start extends StatefulWidget {
  @override
  StartState createState() => StartState();
}

class StartState extends State<Start> {

  TextStyle cardStyle = TextStyle(color: Color(0xFF01497c), fontFamily: "Poppins", fontSize: 22.5, fontWeight: FontWeight.w700);
  var slideSelected = 1;

  final dataKey1 = new GlobalKey();
  final dataKey2 = new GlobalKey();
  final dataKey3 = new GlobalKey();
  final dataKey4 = new GlobalKey();

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
    return new Scaffold(
      body: new Stack(
        children: [
          new ClipPath(
            clipper: StartClipper(),
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x9989c2d9),
                    Color(0xFF01497c),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  new Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 35, left: 20),
                    child: new Text(
                      "ADMISSION \nTOOL",
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: "Rope",
                        fontWeight: FontWeight.w800,
                        fontSize: 33,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(right: 40),
                        child: new Image(
                          height: 240,
                          image: AssetImage('assets/images/Frame1.png'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),

          Container(
            height: 300,
            child: Container(
              padding: EdgeInsets.only(left: 15),
              alignment: Alignment.bottomLeft,
              child: Text(
                "By\nArmando Ibarrarán",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontSize: 15,
                  fontFamily: "Rope"
                ),
              ),
            ),
          ),

          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Container(
                height: 330,
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Container(
                    height: 70,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xFF01497c),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x9901497c),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        )
                      ],
                    ),
                    child: InkWell(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "watch presentation",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                      onTap: (){
                        _launchURL();
                      },
                    ),
                  ),
                ],
              ),
              new Divider(
                color: Colors.grey,
                thickness: 2,
                indent: 40,
                endIndent: 40,
                height: 47,
              ),
              /*

              new Container(
                width: 300,
                height: 40,
                margin: EdgeInsets.only(bottom: 30),
                
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    new Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: slideSelected == 1 ? Color(0xFF01497c):Color(0xFFF9F9F9),
                        border: Border.all(
                          color: Color(0xFF01497c),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Icon(
                          Icons.add,
                          color: slideSelected == 1 ? Color(0xFFF9F9F9):Color(0xFF01497c),
                          size: 30,
                        ),
                        onTap: (){
                          setState(() {
                            slideSelected = 1;
                          });
                        },
                      ),
                    ),
                    new Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: slideSelected == 2 ? Color(0xFF01497c):Color(0xFFF9F9F9),
                        border: Border.all(
                          color: Color(0xFF01497c),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Icon(
                          Icons.group,
                          color: slideSelected == 2 ? Color(0xFFF9F9F9):Color(0xFF01497c),
                          size: 30,
                        ),
                        onTap: (){
                          setState(() {
                            slideSelected = 2;
                            Scrollable.ensureVisible(dataKey2.currentContext);
                          });
                        },
                      ),
                    ),
                    new Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: slideSelected == 3 ? Color(0xFF01497c):Color(0xFFF9F9F9),
                        border: Border.all(
                          color: Color(0xFF01497c),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Icon(
                          Icons.check,
                          color: slideSelected == 3 ? Color(0xFFF9F9F9):Color(0xFF01497c),
                          size: 30,
                        ),
                        onTap: (){
                          setState(() {
                            slideSelected = 3;
                          });
                        },
                      ),
                    ),
                    new Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: slideSelected == 4 ? Color(0xFF01497c):Color(0xFFF9F9F9),
                        border: Border.all(
                          color: Color(0xFF01497c),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Icon(
                          Icons.close,
                          color: slideSelected == 4 ? Color(0xFFF9F9F9):Color(0xFF01497c),
                          size: 30,
                        ),
                        onTap: (){
                          setState(() {
                            slideSelected = 4;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              */
              new Container(
                margin: EdgeInsets.only(top: 0),
                height: 220,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: new ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      new Container(
                        width: 60,
                      ),
                      new Container(
                        width: 200,
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xFFF9F9F9),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x9901497c),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: InkWell(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 30),
                                child: Text(
                                  "Add Applicant",
                                  textAlign: TextAlign.center,
                                  style: cardStyle,
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.add_rounded,
                                  color: Color(0xFF01497c),
                                  size: 60,
                                ),
                              ),
                            ],
                          ),
                          onTap:(){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddApplicant())
                            );
                          },
                        ),
                      ),
                      new Container(
                        width: 200,
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xFFF9F9F9),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x9901497c),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 30),
                                child: Text(
                                  "Application\nElements",
                                  textAlign: TextAlign.center,
                                  style: cardStyle,
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.list,
                                  color: Color(0xFF01497c),
                                  size: 60,
                                ),
                              ),
                            ],
                          ),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Elements())
                            );
                          },
                        ),
                      ),
                      new InkWell(
                        borderRadius: BorderRadius.circular(25),
                        child: new Container(
                          width: 200,
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xFFF9F9F9),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x9901497c),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(0, 0),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 30),
                                child: Text(
                                  "Pending Applicants",
                                  textAlign: TextAlign.center,
                                  style: cardStyle,
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.group,
                                  color: Color(0xFF01497c),
                                  size: 60,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AllApplicants()));
                        },
                      ),
                      Container(
                        height: 165,
                        width: 200,
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xFFF9F9F9),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x9901497c),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Text(
                                  "Admitted\nApplicants",
                                  textAlign: TextAlign.center,
                                  style: cardStyle,
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.check,
                                  color: Color(0xFF01497c),
                                  size: 60,
                                ),
                              ),
                            ],
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Decision(admittedPage: true)));
                          },
                        ),
                      ),
                      Container(
                        height: 165,
                        width: 200,
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xFFF9F9F9),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x9901497c),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Text(
                                  "Rejected\nApplicants",
                                  textAlign: TextAlign.center,
                                  style: cardStyle,
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.close,
                                  color: Color(0xFF01497c),
                                  size: 60,
                                ),
                              ),
                            ],
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Decision(admittedPage: false)));
                          },
                        ),
                      ),
                      new Container(
                        width: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class StartClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size){
    var path = Path();
    path.lineTo(0, size.height-150);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}