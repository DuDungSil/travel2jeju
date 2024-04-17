import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import './state.dart' as state;

class resultpage extends StatefulWidget {
  const resultpage({super.key});

  @override
  State<resultpage> createState() => _resultpageState();
}

class _resultpageState extends State<resultpage> {

  void initState(){
    super.initState();
    context.read<state.Store>().getResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0,70,0,0),
            child: Text('🏝️여행지🏝️',
              style: TextStyle(
                fontSize: 55,
                fontFamily: 'EF_jejudoldam',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0,0,0,20),
            child: Text('(실제 여행객 기반의 데이터입니다)',
              style: TextStyle(fontSize: 15),
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: context.watch<state.Store>().result.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('🔍 목록 🔍' , style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'EF_jejudoldam'),
                              textAlign: TextAlign.center,
                            ),
                            content: Container(
                              width: double.maxFinite,
                              height: 300,
                              child: ListView.builder(
                                itemCount: getSpot(context.watch<state.Store>().result[index]['spot']).length,
                                itemBuilder: (context, i) {
                                  String item = getSpot(context.watch<state.Store>().result[index]['spot'])[i];
                                  return GestureDetector(
                                    onTap: () {
                                      launchUrl(Uri.parse('https://search.naver.com/search.naver?query=$item'));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: Text("🔸 $item", overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold),),
                                    ),
                                  );
                                },
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('확인', style: TextStyle(color: Colors.deepPurple),),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 100,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white24,
                              blurRadius: 20.0,
                              spreadRadius: 2.0,
                              offset: Offset(-5, -5))
                        ],
                        color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.1),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("${context.watch<state.Store>().result[index]['partner']}", style: TextStyle(fontSize: 16,color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                              Text("이(가) ", style: TextStyle(fontSize: 15)),
                              Text("${context.watch<state.Store>().result[index]['period']}", style: TextStyle(fontSize: 16,color: Colors.deepPurple, fontWeight: FontWeight.bold),),
                              Text("일간 떠났던 여행지!", style: TextStyle(fontSize: 15),),
                            ],
                          ),
                          Divider(),
                          Text("${context.watch<state.Store>().result[index]['spot']}", style: TextStyle(fontSize: 20,fontFamily: 'EF_jejudoldam',), overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 100,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            context.read<state.Store>().reset();
          },
          child : Text("다시하기", style: TextStyle(fontSize: 20),),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
        ),
      )
    );
  }
}

getSpot(String str) {
  List<String> spotList = str.split(',').map((e) => e.trim()).toList();
  return spotList;
}