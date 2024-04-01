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
        body: GestureDetector(
          child: Container(
              alignment: Alignment.topCenter,
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.jpeg'),
                    fit: BoxFit.fill
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 65),
                      child: Text("제주 여행", style : TextStyle(fontSize: 65, fontFamily: 'EF_jejudoldam')),
                    ),
                    Text("화면을 터치하세요", style: TextStyle(fontSize: 15, color: Colors.white),)
                  ]
              )
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => selectpage.selectpage())
            );
          },
        )
    );
  }
}
