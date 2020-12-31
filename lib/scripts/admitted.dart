import 'dart:convert';

import 'package:admission_app/scripts/start.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Decision extends StatefulWidget{

  final bool admittedPage;
  Decision({Key key, this.admittedPage}) : super(key:key);

  @override 
  DecisionState createState()=>DecisionState();
}

class DecisionState extends State<Decision> {

  @override
  void initState(){
    super.initState();
    _loadElements();
  }

  List<Widget> applicantsWidgets = [
    Container(height: 20),
  ];
  Map applicant;
  Color primary = Color(0xFF01497c);

  _loadElements() async {
    final prefs = await SharedPreferences.getInstance();
    Map list = jsonDecode(prefs.getString(widget.admittedPage ? "admitted" : "rejected") ?? "[]");
    List<Widget> subWidgets = <Widget>[];
    applicantsWidgets = [
      Container(height: 20),
    ];
    
    list.forEach((_key, _value) { 
      applicant = _value;

      subWidgets = [];
      applicant.forEach((key, value){
        if(key != "admitted"){
          String valueTaken;
        
          
          if(value["type"] == "Options"){
            
            valueTaken = value["value"]["optionsList"].toString();
            
          }else{
            valueTaken = value["value"];
          }

          
          subWidgets.add(
            Container(
              margin: EdgeInsets.symmetric(vertical:2.5),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      key+":   ",
                      style: TextStyle(
                        fontFamily: "Rope",
                        color: primary,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      valueTaken,
                      style: TextStyle(
                        fontFamily: "Rope",
                        color: primary,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        
      });
      
      applicantsWidgets.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          padding: EdgeInsets.symmetric(vertical:10, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFF9F9F9),
            border: Border.all(
              color: primary,
              width: 2
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x9901497c),
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            children: subWidgets,
          ),
        ),
      );
    });

    for(var i = 0; i<list.length; i++){

      
    }


    setState(() {
      applicantsWidgets = applicantsWidgets;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
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
        body: Container(
          child: new Column(
            children: [
              new Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 20, bottom: 10),
                child: new Text(
                  widget.admittedPage ? "admitted\napplicants":"rejected\napplicants",
                  style: TextStyle(
                    fontFamily: "Rope",
                    fontSize: 30,
                    color: Color(0xFF01497c)
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 2,
                indent: 15,
                endIndent: 15,
              ), 
              Expanded(
                child: applicantsWidgets.length == 1 ? Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.admittedPage ? "oops, looks like you haven't admitted anyone" : "oops, looks like you haven't rejected anyone",
                    style: TextStyle(
                      fontFamily: "Rope",
                      fontSize: 20,
                      color: Color(0xFF01497c)
                    ),
                  ),
                ) : ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView(
                    children: applicantsWidgets,
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}