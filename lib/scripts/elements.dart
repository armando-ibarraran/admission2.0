import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'start.dart';

class Elements extends StatefulWidget{
  @override
  ElementsState createState() => ElementsState();
}



class ElementsState extends State<Elements>{

  @override
  void initState() {
    super.initState();
    loadElements();
  }

  List<Widget> elements = <Widget>[
    Container(
      height: 20,
    ),
  ];


  loadElements() async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> jsonElements = jsonDecode(prefs.getString("elements") ?? "{}");
    String type;
    bool hasOptions = false;

    elements = <Widget>[
      Container(
        height: 20,
      ),
    ];

    jsonElements.forEach((key, value) { 

      List<Widget> optionsWidgets = <Widget>[];

      jsonDecode(value).forEach((_key, _value){
        if(_key == "type"){
          type = _value;
          print("Type: " + type);
        }else if(_key=="options"){
          hasOptions = true;
          List<dynamic> optionsValues = jsonDecode(_value);
          for(var i = 0; i<optionsValues.length; i++){
            optionsWidgets.add(
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "- " + optionsValues[i].toString(),
                  style: TextStyle(
                    fontFamily: "Rope",
                    color: Color(0xFF01497c),
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            );
          }
        }
      });

      

      elements.add(
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFF9F9F9),
            border: Border.all(
              color: Color(0xFF01497c),
              width: 3
            ),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom:5),
                    alignment: Alignment.topLeft,
                    child: Text(
                      key,
                      style: TextStyle(
                        fontFamily: "Rope",
                        color: Color(0xFF01497c),
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Possible values: ",
                      style: TextStyle(
                        fontFamily: "Rope",
                        color: Color(0xFF01497c),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  hasOptions == true ? Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            type+":",
                            style: TextStyle(
                              fontFamily: "Rope",
                              color: Color(0xFF01497c),
                              fontSize: 18,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: optionsWidgets,
                          ),
                        ),
                      ],
                    ),
                  ) : Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      type,
                      style: TextStyle(
                        fontFamily: "Rope",
                        color: Color(0xFF01497c),
                        fontSize: 18,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(
                child: Container(
                alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Icon(
                      Icons.delete_rounded,
                      color: Color(0xFF01497c),
                      size: 30,
                    ),
                    onTap: (){
                      jsonElements.remove(key);
                      prefs.setString("elements", jsonEncode(jsonElements));
                      loadElements();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        
      );
    });
    
    setState(() {
      elements = elements;
    });
    
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            new Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20),
              child: new Text(
                "application\nelements",
                style: TextStyle(
                  fontFamily: "Rope",
                  fontSize: 30,
                  color: Color(0xFF01497c)
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFF9F9F9),
                border: Border.all(
                  color: Color(0xFF01497c),
                  width: 3
                ),
              ),
              
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "add element",
                        style: TextStyle(
                          fontFamily: "Rope",
                          color: Color(0xFF01497c),
                          fontWeight: FontWeight.w700,
                          fontSize: 17.5,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.add_rounded,
                      color: Color(0xFF01497c),
                      size: 30,
                    ),
                  ],
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddElement())
                  );
                },
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
                child: ScrollConfiguration(
                  behavior: MyBehavior(),

                  child: elements.length == 1 ? ListView(
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
                  ): ListView(
                    children: elements,
                  ),
                ),
              ),
            ),
          ],
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


class AddElement extends StatefulWidget {
  @override
  AddElementState createState() => AddElementState();
}

class AddElementState extends State<AddElement>{

  String categoryValue = "Text Input";
  String categoryName;
  String currentOption;
  List<Widget> options = <Widget>[];
  List<String> optionsNames = <String>[];
  TextEditingController categoryController = TextEditingController();
  Map<String, dynamic> elements = {};
 

  _loadElements() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    elements = jsonDecode(prefs.getString("elements") ?? "{}");
    print("Making sure: " + elements.toString());
    if(categoryValue == "Options"){
      elements[categoryName] = jsonEncode({
        "type": categoryValue,
        "options": jsonEncode(optionsNames)
      });
    }else{
      elements[categoryName] = jsonEncode({
        "type": categoryValue
      });
    }
  
    _saveElement("elements", elements);
    
    Navigator.push(context, MaterialPageRoute(builder: (context) => Elements()));
  }

  _saveElement(name, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, jsonEncode(value));
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Elements()));
              },
            ),
          ),
        ),
        body: new Column(
          children: [
            new Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20, bottom: 10),
              child: new Text(
                "add\nelement",
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
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top:20, bottom: 5),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Element name:",
                        style: TextStyle(
                          fontFamily: "Rope",
                          fontSize: 20,
                          color: Color(0xFF01497c)                
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        cursorColor: Color(0xFF01497c),
                        decoration: InputDecoration(
                          focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                              width: 2,
                              color: Color(0xFF01497c),
                            ),
                          ),
                          hintText: "e.g. Name, GPA...",
                        ),
                        onChanged: (value){
                          setState(() {
                            categoryName = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top:40, bottom: 5),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Possible values:",
                        style: TextStyle(
                          fontFamily: "Rope",
                          fontSize: 20,
                          color: Color(0xFF01497c)                
                        ),
                      ),
                    ),
                    
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "Type: ",
                              style: TextStyle(
                                color: Color(0xFF01497c),
                                fontFamily: "Rope",
                                fontSize: 15
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: DropdownButton<String>(
                              value: categoryValue,
                              iconSize: 40,
                              icon: Icon(
                                Icons.expand_more_rounded,
                                color: Color(0xFF01497c),
                              ),
                              style: TextStyle(
                                color: Color(0xFF01497c)
                              ),
                              underline: Container(
                                height: 2,
                                color: Color(0xFF01497c),
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  categoryValue = newValue;
                                });
                              },
                              items: <String>['Text Input', 'Number Input', 'Options'].map<DropdownMenuItem<String>>((String value){
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      fontFamily: "Rope",
                                      fontSize: 15
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    categoryValue == "Options" ? Container(
                      margin: EdgeInsets.only(left:20, right: 20),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Color(0xFFF9F9F9),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Color(0xFF01497c),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(right: 50),
                                    child: TextField(
                                      controller: categoryController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "Name of new option",
                                      ),
                                      cursorColor: Color(0xFF01497c),
                                      onChanged: (value){
                                        currentOption = value;
                                      },
                                    ),
                                  ),
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.add_rounded,
                                    color: Color(0xFF01497c),
                                    size: 30,
                                  ),
                                  onTap: (){
                                    if(currentOption.isNotEmpty){
                                      categoryController.clear();
                                      optionsNames.add(currentOption);
                                      options.add(
                                        new Container(
                                          margin: EdgeInsets.symmetric(vertical: 5),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "- ${currentOption}",
                                            style: TextStyle(
                                              color: Color(0xFF01497c),
                                              fontFamily: "Rope",
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        )
                                      );
                                      setState(() {
                                        
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: options,
                          ),
                        ],
                      ),
                    ) : Container(),

                    Container(
                      margin: EdgeInsets.only(right: 20, left:20, top:20, bottom: 20),
                      padding: EdgeInsets.symmetric(vertical: 10),
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
                          if(categoryName.isNotEmpty){
                            _loadElements();
                            
                            
                          }
                        },
                      )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}