import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ResponseApi {
  List<String> responses;

  Future<String> fetchAnswer() async {
    // TODO: Make this API URL into a constant
    final response = await http.get('https://8ball.delegator.com/magic/JSON/_');

    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body);
      String answer = jsonResponse["magic"]["answer"];
      // We're going to leave this in because it helps demonstrate that this is
      // actually working to an audience
      print(answer);
      return answer;
    } else {
      throw Exception('Failed to load answer');
    }
  }
}
