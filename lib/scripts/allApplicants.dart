import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'start.dart';

class AllApplicants extends StatefulWidget{
  @override
  AllApplicantsState createState()=>AllApplicantsState();
}

class AllApplicantsState extends State<AllApplicants>{

  Map <String, dynamic> applicant;

  @override
  void initState(){
    super.initState();
    _loadElements();
  }

  List<Widget> applicantsWidgets = [
    Container(height: 20),
  ];
  Color primary = Color(0xFF01497c);

  _submitDecision(thisApplicant,_key) async {
    final prefs = await SharedPreferences.getInstance();
    
    if(thisApplicant["admitted"] == true){
      Map admittedStudents = jsonDecode(prefs.getString("admitted") ?? "{}");
      admittedStudents[_key] = thisApplicant;
      prefs.setString("admitted", jsonEncode(admittedStudents));
    }else{
      Map rejectedStudents = jsonDecode(prefs.getString("rejected") ?? "{}");
      rejectedStudents[_key] = thisApplicant;
      prefs.setString("rejected", jsonEncode(rejectedStudents));
    }
    
  }

  _loadElements() async {
    final prefs = await SharedPreferences.getInstance();
    Map list = jsonDecode(prefs.getString("applicants") ?? "{}");
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
            children: [
              Column(
                children: subWidgets,
              ),
              Container(
                margin: EdgeInsets.only(top:20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical:10, horizontal:30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primary
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                          child: Text(
                          "admit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF9F9F9),
                            fontFamily: "Rope",
                            fontSize: 18
                          ),
                        ),
                        onTap: (){
                          applicant = list[_key];
                          applicant["admitted"] = true;
                          _submitDecision(applicant, _key);
                          list.remove(_key);
                          print(list);
                          prefs.setString("applicants", jsonEncode(list));
                          _loadElements();
                        },
                      )
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical:10, horizontal:30),
                      decoration: BoxDecoration(
                        color: Color(0xFFF9F9F9),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: primary,
                          width: 1
                        )
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                          child: Text(
                          "reject",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: primary,
                            fontFamily: "Rope",
                            fontSize: 18
                          ),
                        ),
                        onTap: (){
                          applicant = list[_key];
                          applicant["admitted"] = false;
                          _submitDecision(applicant, _key);
                          list.remove(_key);
                          prefs.setString("applicants", jsonEncode(list));
                          _loadElements();
                        },
                      )
                    ),
                  ],
                ),
              ),
             
            ],
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
          child: Column(
            children: [
               new Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 20, bottom: 10),
                child: new Text(
                  "pending\napplicants",
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
                child: Container(
                  padding: EdgeInsets.only(top:20),
                  child: applicantsWidgets.length!=1? ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView(
                      children: applicantsWidgets,
                    ),
                  ):Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "oops, looks like you there aren't any pending applications",
                        style: TextStyle(
                          fontFamily: "Rope",
                          fontSize: 20,
                          color: Color(0xFF01497c)
                        ),
                      ),
                  ),
                ),
              ),
            ],
          ),
        ),
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