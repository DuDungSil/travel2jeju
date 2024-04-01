import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Store extends ChangeNotifier {

  var co_type = '';
  var travel_period = 0;
  List<String> keword_list = [];

  List<String> selectable_kewords = [];
  var result = [];

  changeCo_type(String type) {
    co_type = type;
    notifyListeners();
  }

  changetravel_period(int num) {
    travel_period = num;
    notifyListeners();
  }

  bool containsAnyKeyword(String word) {
    if (keword_list.contains(word))
      return true;
    return false;
  }

  add_keword(String word) {
    keword_list.add(word);
    notifyListeners();
  }

  remove_keword(String word) {
    keword_list.remove(word);
    notifyListeners();
  }

  getSelectable_kewords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // // http get요청
    // var url = Uri.parse('주소');
    // try{
    //   var response = await http.get(url);
    //   var date = jsonDecode(response.body);
    // } catch(e){
    //   print('통신 오류');
    // }

    // db 업데이트가 있다면
    if (true) {
      // http get요청
      var url2 = Uri.parse('http://121.134.59.78:3573/keyword');
      try {
        var response = await http.get(url2);
        var data = utf8.decode(response.bodyBytes);
        var _data = data.split(',');
        selectable_kewords = _data;
        notifyListeners();
      } catch (e, stackTrace) {
        print('Caught error: $e');
        print('Stack trace: $stackTrace');
      }
      // db에서 가져온후 shared preference에 저장 ( 업데이트 일자 함께 저장 )

    }
    // shared preference 에서 가져오기
  }


  getResult() async {
    if (true) {
      // http get요청
      var url1 = Uri.parse('http://121.134.59.78:3573/spot/친구,천천히 걷기,힐링');
      try {
        var response = await http.get(url1);
        var data = utf8.decode(response.bodyBytes);
        print(response.contentLength);
        log(data);
      } catch (e, stackTrace) {
        print('Caught error: $e');
        print('Stack trace: $stackTrace');
      }
    }
  }
}