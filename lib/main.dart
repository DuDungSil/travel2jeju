import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './state.dart' as state;
import './style.dart' as style;
import './selectpage.dart' as selectpage;

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (c) => state.Store(),
        child: MaterialApp(
          theme: style.theme,
          home: MyApp(),
      ),
    )
  );
}



class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('제주도 코스 추천'),
        ),

        body: TextButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => selectpage.selectpage())
          );
        },
            child: Text('검색하기')),

    );
  }
}
