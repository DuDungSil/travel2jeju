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
      appBar: AppBar(title: Text('결과'),),
      
      body: ListView.builder(
          itemCount: context.read<state.Store>().result.length,
          itemBuilder: (context, index){
              return Column(
                children: [
                  Text("유형 : ${context.read<state.Store>().result[index]['type']}"),
                  Text("사람수 : ${context.read<state.Store>().result[index]['nums']}"),
                  Text("기간 : ${context.read<state.Store>().result[index]['period']}"),
                  Text("키워드 : ${context.read<state.Store>().result[index]['kewords']}"),
                  Text("컨텐츠 : ${context.read<state.Store>().result[index]['content']}"),
                  Text(" ")
                ],
              );
            }
          ),
    );
  }
}
