import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'start.dart';

class AddApplicant extends StatefulWidget{
  @override
  AddApplicantState createState() => AddApplicantState();
}

class AddApplicantState extends State<AddApplicant> {

  @override
  void initState(){
    super.initState();
    _loadElements();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  final myController = TextEditingController();

  List<Widget> elements = <Widget>[
    Container(height:20),
  ];
  Map<String,dynamic> applicant = {};
  Color primary = Color(0xFF01497c);

  _loadElements() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonElements = jsonDecode(prefs.getString("elements") ?? "{}");
    List<Widget> options = <Widget>[];
    elements = <Widget>[
      Container(height:20),
    ];

    jsonElements.forEach((key, value) {
      bool hasOptions = false;
      String type;
      jsonDecode(value).forEach((_key, _value){

          
        
        print("Helloooo " + _key);
          if (_key=="options"){
            print("Helloooo");
            hasOptions=true;
            var optionlist = jsonDecode(_value);
            print(applicant);
            applicant[key]["value"] = applicant[key]["value"]==null||applicant[key]["value"].isEmpty? {
              
                "options": {},
                "optionsList": []
              
            }: applicant[key]["value"];
            print(applicant);
            options = [];
            for(var i = 0; i<optionlist.length; i++){
              var name = optionlist[i];
              applicant[key]["value"]["options"][name] = applicant[key]["value"]["options"][name]== null ? false : applicant[key]["value"]["options"][name];
              options.add(
                Container(
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: primary,
                        value: applicant[key]["value"]["options"][name],
                        onChanged: (value){
                          setState(() {
                            applicant[key]["value"]["options"][name] = value;
                            if(value == true){
                              applicant[key]["value"]["optionsList"].add(name);
                            }else{
                              applicant[key]["value"]["optionsList"].remove(name);
                            }
                          });
                          _loadElements();
                        }
                      ),
                      Container(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontFamily: "Rope",
                            color: primary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }else{
            applicant[key] = applicant[key]==null? {
              "type": _value,
              "value": ""
            }: applicant[key];
            type = _value;
          }

          
        
      });

      elements.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFF9F9F9),
            border: Border.all(
              color: primary,
              width: 3
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  key,
                  style: TextStyle(
                    fontFamily: "Rope",
                    color: primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              hasOptions==true ? Container(
                child: Column(
                  children: options,
                ),
              ) : Container(
                child: TextField(
                  controller: new TextEditingController(
                    text: applicant[key]["value"],
                  ),
                  style: TextStyle(
                    fontFamily: "Rope"
                  ),
                  cursorColor: primary,
                  onChanged: (value){
                    if(type!="Options"){
                      applicant[key]["value"] = value;
                    }
                  },
                  keyboardType: type=="Text Input"? TextInputType.text:TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                        width: 2,
                        color: primary,
                      ),
                    ),
                    hintText: "write here",
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });

    elements.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Color(0xFF01497c),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color(0x9901497c),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ]
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          child: Text(
            "add",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Rope",
              fontWeight: FontWeight.w800,
              fontSize: 25
            ),
          ),
          onTap: (){
            _saveApplicant();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddApplicant()));
          },
        ),
      ),
    );

    print(applicant);

    setState(() {
      elements = elements;
    });
  }

  _saveApplicant() async {
    final prefs = await SharedPreferences.getInstance();
    var applicants = jsonDecode(prefs.getString("applicants") ?? "{}");
    var lastNum = (prefs.getInt("lastNum") ?? 0)+1;
    prefs.setInt("lastNum", lastNum);
    applicants[lastNum.toString()] = applicant;
    prefs.setString("applicants", jsonEncode(applicants));
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
                  "add\napplicant",
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
                child: elements.length == 2 ? ListView(
                  children: [
                    Container(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "oops, looks like you haven't created any elements",
                        style: TextStyle(
                          fontFamily: "Rope",
                          fontSize: 20,
                          color: Color(0xFF01497c)
                        ),
                      ),
                    )
                  ],
                ): ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView(
                    children: elements,
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