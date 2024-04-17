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
        padding: EdgeInsets.only(top: 50),
        child: [typepage(),periodnumpage(),kewordpage()][index],
      ),

      bottomNavigationBar: BottomAppBar(
        height: 60,
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
                    if(context.read<state.Store>().validateRequiredParameters())
                      {
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => resultpage.resultpage()));
                        });
                      }
                    else
                    {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext ctx){
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              alignment: Alignment.center,
                              content: Container(
                                  alignment: Alignment.center,
                                  height: 24,
                                  child: Text('모든 항목을 선택하세요',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20))
                              ),
                              actions: [
                                Center(
                                  child: TextButton(
                                    child: Text('확인',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    }
                                  )
                                )
                              ],
                            );
                          }
                      );
                    }
                  }, child: Text('검색',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                )
              )
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
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/background.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        // 투명한 색상
        Positioned.fill(
          child: Container(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        Container(
          child: Column(
            verticalDirection: VerticalDirection.down,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Text('누구와 가나요?', style: TextStyle(
                  fontSize: 45,
                  fontFamily: 'EF_jejudoldam',
                ),
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
        ),
      ],
    );
  }
}

class periodnumpage extends StatelessWidget {
  periodnumpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children : [
        Positioned.fill(
          child: Image.asset(
            'assets/background.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        // 투명한 색상
        Positioned.fill(
          child: Container(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        Center(
          child: Column(
            verticalDirection: VerticalDirection.down,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Text('며칠간 있나요?', style: TextStyle(
                  fontSize: 45,
                  fontFamily: 'EF_jejudoldam',
                ),
                ),
              ),
              Container(
                child: Text('(미정인 경우 0을 선택하세요)',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.all(5),
                width: 200,
                child: context.watch<state.Store>().travel_period == 0
                    ? Text('미정', style: TextStyle(fontSize: 35, fontFamily: 'EF_jejudoldam',),)
                    : Text('${context.watch<state.Store>().travel_period}일', style: TextStyle(fontSize: 35, fontFamily: 'EF_jejudoldam',),),
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
        ),
      ]
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
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/background.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        // 투명한 색상
        Positioned.fill(
          child: Container(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: Text('테마를 고르세요', style: TextStyle(
                fontSize: 45,
                fontFamily: 'EF_jejudoldam',
              ),
              ),
            ),
            Container(
              child: Text('(최대 4개 선택 가능합니다)',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: context.read<state.Store>().selectable_kewords.length - 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3/1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      if(context.read<state.Store>().containsAnyKeyword(index))
                      {
                        setState(() {
                          context.read<state.Store>().remove_keword(index);
                        });
                      }
                      else
                      {
                        if(context.read<state.Store>().keword_list.length < 4)
                        {
                          setState(() {
                            context.read<state.Store>().add_keword(index);
                          });
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      color: (!context.read<state.Store>().containsAnyKeyword(index))
                          ? context.watch<state.Store>().selectable_kewords_colors[index]
                          : context.watch<state.Store>().selectable_kewords_colors[index].withOpacity(1.0),
                      alignment: Alignment.center,
                      child: Text(
                        context.read<state.Store>().selectable_kewords[index],
                        style: (!context.read<state.Store>().containsAnyKeyword(index))
                            ? TextStyle(fontSize: 20, fontFamily: 'EF_jejudoldam',)
                            : TextStyle(fontSize: 20,color: Colors.white ,fontFamily: 'EF_jejudoldam',),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
