import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            padding: EdgeInsets.fromLTRB(0,70,0,30),
            child: Text('🏝️여행지🏝️',
              style: TextStyle(
                fontSize: 55,
                fontFamily: 'EF_jejudoldam',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: context.read<state.Store>().result.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            alignment: Alignment.center,
                            title: Text('🏝️ 추천 여행지 🏝️',
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'EF_jejudoldam',
                              ),
                            ),
                            content: Text(context.read<state.Store>().result[index]['spot']),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // 다이얼로그 닫기
                                },
                                child: Text('확인'),
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
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                              offset: Offset(-3, -3))
                        ],
                        color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.1),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("${context.read<state.Store>().result[index]['partner']}의 ", style: TextStyle(fontSize: 15,color: Colors.deepPurple ,fontFamily: 'EF_jejudoldam',),),
                              Text("${context.read<state.Store>().result[index]['period']}일 여행", style: TextStyle(fontSize: 15,color: Colors.deepPurple ,fontFamily: 'EF_jejudoldam',),),
                            ],
                          ),
                          Divider(),
                          Text("${context.read<state.Store>().result[index]['spot']}", style: TextStyle(fontSize: 20,fontFamily: 'EF_jejudoldam',), overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}