import 'dart:math';
import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Store extends ChangeNotifier {

  var co_type = '';
  var travel_period = 0;
  List<String> keword_list = [];

  List<String> selectable_kewords = [];
  List<Color> selectable_kewords_colors = [];

  var result = [];

  changeCo_type(String type) {
    co_type = type;
    notifyListeners();
  }

  changetravel_period(int num) {
    travel_period = num;
    notifyListeners();
  }

  bool containsAnyKeyword(int index) {
    if (keword_list.contains(selectable_kewords[index]))
      return true;
    return false;
  }

  add_keword(int index) {
    keword_list.add(selectable_kewords[index]);
    notifyListeners();
  }

  remove_keword(int index) {
    keword_list.remove(selectable_kewords[index]);
    notifyListeners();
  }

  getSelectable_kewords() async {
      var url = Uri.parse('http://15.165.203.216:3573/keyword');
      try {
        var response = await http.get(url);
        var data = utf8.decode(response.bodyBytes);
        var _data = data.split(',');
        selectable_kewords = _data;
      } catch (e, stackTrace) {
        print('Caught error: $e');
        print('Stack trace: $stackTrace');
      }
      generateColors(selectable_kewords.length);
  }

  generateColors(int length)
  {
    for(int i = 0; i < length; i++)
    {
      selectable_kewords_colors.add(Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.1));
    }
  }

  bool validateRequiredParameters()
  {
    if(co_type == '')
    {
      return false;
    }
    if(travel_period == 0)
    {
      return false;
    }
    if(keword_list.isEmpty)
    {
      return false;
    }
    return true;
  }

  getResult() async {
    String param = co_type + '?' + travel_period.toString() + '?' + keword_list.join(',');
    var url = Uri.parse('http://15.165.203.216:3573/spot/' + param);
    try {
      var response = await http.get(url);
      var data = utf8.decode(response.bodyBytes);
      dev.log(data);
<<<<<<< Updated upstream
=======
      result = jsonDecode(data);
>>>>>>> Stashed changes
    } catch (e, stackTrace) {
      print('Caught error: $e');
      print('Stack trace: $stackTrace');
    }
  }

}