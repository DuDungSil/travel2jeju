import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:numberpicker/numberpicker.dart';
import './state.dart' as state;
import './resultpage.dart' as resultpage;

class selectpage extends StatefulWidget {
  const selectpage({super.key});

  @override
  State<selectpage> createState() => _selectpageState();
}

class _selectpageState extends State<selectpage> {

  var index = 0;
  var last_index = 2;

  @override
  void initState() {
    super.initState();
    context.read<state.Store>().getSelectable_kewords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.only(top: 100),
        child: [typepage(),periodnumpage(),kewordpage()][index],
      ),

      bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: (){
                    setState(() {
                      if(index == 0) Navigator.pop(context);
                      else index--;
                    });
                }, icon: Icon(Icons.arrow_back)
              ),
              index != last_index
              ? IconButton(
                  onPressed: (){
                    setState(() {
                      index++;
                    });
                  }, icon: Icon(Icons.arrow_forward)
                )
              : TextButton(
                  onPressed: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => resultpage.resultpage()));
                    });
                  }, child: Text('검색'))
            ],
          ),
      )

    );
  }
}




class typepage extends StatelessWidget {
  const typepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        verticalDirection: VerticalDirection.down,
        children: [
          Text('누구와?', style: TextStyle(
            fontSize: 50,
            fontFamily: 'EF_jejudoldam',
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.all(5),
            width: 200,
            child: Text('${context.watch<state.Store>().co_type}', style: TextStyle(fontSize: 35, fontFamily: 'EF_jejudoldam',),),
          ),
          Container(
              height: 3,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.purple, width: 3))
              )
          ),
          Container(height: 40),
          TextButton(onPressed: (){
            context.read<state.Store>().changeCo_type('친구');
          }, child: Text('친구', style: TextStyle(color: Colors.deepPurple, fontSize: 25, fontFamily: 'EF_jejudoldam',),)),
          TextButton(onPressed: (){
            context.read<state.Store>().changeCo_type('부모');
          }, child: Text('부모', style: TextStyle(color: Colors.deepPurple, fontSize: 25, fontFamily: 'EF_jejudoldam',),)),
          TextButton(onPressed: (){
            context.read<state.Store>().changeCo_type('아이');
          }, child: Text('아이', style: TextStyle(color: Colors.deepPurple, fontSize: 25, fontFamily: 'EF_jejudoldam',),)),
          TextButton(onPressed: (){
            context.read<state.Store>().changeCo_type('커플');
          }, child: Text('커플', style: TextStyle(color: Colors.deepPurple, fontSize: 25, fontFamily: 'EF_jejudoldam',),)),
          TextButton(onPressed: (){
            context.read<state.Store>().changeCo_type('혼자');
          }, child: Text('혼자', style: TextStyle(color: Colors.deepPurple, fontSize: 25, fontFamily: 'EF_jejudoldam',),)),
        ],
      ),
    );
  }
}

class periodnumpage extends StatelessWidget {
  periodnumpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        verticalDirection: VerticalDirection.down,
        children: [
          Text('몇 일?', style: TextStyle(
            fontSize: 50,
            fontFamily: 'EF_jejudoldam',
          ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.all(5),
            width: 200,
            child: Text('${context.watch<state.Store>().travel_period}', style: TextStyle(fontSize: 35, fontFamily: 'EF_jejudoldam',),),
          ),
          Container(
              height: 3,
              width: 100,
              margin: EdgeInsets.only(bottom: 50),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.purple, width: 3))
              )
          ),
          NumberPicker(
            axis: Axis.vertical,
            step: 1,
            minValue: 0,
            maxValue: 30,
            itemCount: 5,
            value: context.watch<state.Store>().travel_period,
            onChanged: (value) => context.read<state.Store>().changetravel_period(value),
            textStyle: TextStyle(fontSize: 20, fontFamily: 'EF_jejudoldam',),
            selectedTextStyle: TextStyle(fontSize: 30, fontFamily: 'EF_jejudoldam', color: Colors.deepPurple, ),
          ),
        ],
      ),
    );
  }
}



class kewordpage extends StatefulWidget {
  const kewordpage({super.key});

  @override
  State<kewordpage> createState() => _kewordpageState();
}

class _kewordpageState extends State<kewordpage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          child: Text('테마는?',
            style: TextStyle(
              fontSize: 50,
              fontFamily: 'EF_jejudoldam',
            ),
          ),
        ),
        Container(
          height: 550,
          child: GridView.builder(
            itemCount: context.read<state.Store>().selectable_kewords.length - 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3/1,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(5),
                color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2),
                alignment: Alignment.center,
                child: Text(
                  context.read<state.Store>().selectable_kewords[index],
                  style: TextStyle(fontSize: 20, fontFamily: 'EF_jejudoldam',),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class MyListview extends StatelessWidget {
  MyListview({super.key, this.dataList});

  final dataList;
  final int elementsPerRow = 3;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: (dataList.length / elementsPerRow).ceil(),
        itemBuilder: (context, rowIndex){
          int startIndex = rowIndex * elementsPerRow;
          int endIndex = (rowIndex + 1) * elementsPerRow;
          endIndex = endIndex > dataList.length ? dataList.length : endIndex;
          List<String> rowElements = dataList.sublist(startIndex, endIndex);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: rowElements.map((element) {
              return Container(
                padding: EdgeInsets.all(2.0),
                child: Text(
                  '#' + element,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
              );
            }).toList(),
          );
        }
    );
  }
}

