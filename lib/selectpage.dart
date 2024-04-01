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
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.jpeg'),
              fit: BoxFit.fill
          ),
        ),
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
          Text('동반자 유형을 선택하세요', style: TextStyle(
              fontSize: 20
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(1),
            padding: EdgeInsets.all(8),
            width: 200,
            child: Text('${context.watch<state.Store>().co_type}'),
          ),
          Container(
              height: 1,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.purple, width: 1))
              )
          ),
          Container(height: 40),
          TextButton(onPressed: (){
            context.read<state.Store>().changeCo_type('친구');
          }, child: Text('친구')),
          TextButton(onPressed: (){
            context.read<state.Store>().changeCo_type('부모');
          }, child: Text('부모')),
          TextButton(onPressed: (){
            context.read<state.Store>().changeCo_type('아이');
          }, child: Text('아이')),
          TextButton(onPressed: (){
            context.read<state.Store>().changeCo_type('커플');
          }, child: Text('커플')),
          TextButton(onPressed: (){
            context.read<state.Store>().changeCo_type('혼자');
          }, child: Text('혼자')),
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
          Text('몇일', style: TextStyle(
              fontSize: 20
          ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(1),
            padding: EdgeInsets.all(8),
            width: 200,
            child: Text('${context.watch<state.Store>().travel_period}'),
          ),
          Container(
              height: 1,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.purple, width: 1))
              )
          ),
          Container(height: 150),
          NumberPicker(
              axis: Axis.horizontal,
              step: 1,
              minValue: 0,
              maxValue: 15,
              value: context.watch<state.Store>().travel_period,
              onChanged: (value) => context.read<state.Store>().changetravel_period(value)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                IconButton(onPressed: (){
                  final newValue = context.read<state.Store>().travel_period - 1;
                  context.read<state.Store>().changetravel_period(newValue);
                }, icon: Icon(Icons.remove)),
                Container(width: 40,),
                IconButton(onPressed: (){
                  final newValue = context.read<state.Store>().travel_period + 1;
                  context.read<state.Store>().changetravel_period(newValue);
                }, icon: Icon(Icons.add))
            ],
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
    return Center(
      child: Column(
        verticalDirection: VerticalDirection.down,
        children: [
          Text('키워드를 선택하세요', style: TextStyle(
              fontSize: 20
          ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(1),
            padding: EdgeInsets.all(8),
            width: 340,
            height: context.watch<state.Store>().keword_list.length <= 3 ? 35 : 60,
            child: context.watch<state.Store>().keword_list.isNotEmpty
                ? Container(alignment: Alignment.center, height: 50,child: MyListview(dataList: context.watch<state.Store>().keword_list))
                : Text(''),
          ),
          Container(
              height: 1,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.purple, width: 1))
              )
          ),
          Container(height: 40),
          Container(
            alignment: Alignment.center,
            width: 500,
            height: 400,
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index){
                  return Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildChip(context, index),
                        _buildChip(context, index + 10),
                      ],
                    ),
                  );
                }
              )
            ),
        ],
      ),
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




Widget _buildChip(BuildContext context, int index) {
  var label = context.read<state.Store>().selectable_kewords[index];
  var isSelected = context.read<state.Store>().containsAnyKeyword(label);

  return Center(
    child: RawChip(
      label: Text(label),
      avatar: Icon(Icons.circle),
      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
      checkmarkColor: Colors.amber,
      selected: isSelected,
      onPressed: () {
        if(isSelected){
          context.read<state.Store>().remove_keword(label);
        }
        else{
          context.read<state.Store>().add_keword(label);
        }
      },
    ),
  );
}


