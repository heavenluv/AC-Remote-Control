import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<RemoteData> TurnOnAC() async {
  final response =
      await http.get(Uri.parse('https://junwei.pagekite.me/api/aircond_on/'));
  if (response.statusCode == 200) {
    return RemoteData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to open the aircond!");
  }
}

Future<RemoteData> TurnOffAC() async {
  final response =
      await http.get(Uri.parse('https://junwei.pagekite.me/api/aircond_off/'));
  if (response.statusCode == 200) {
    return RemoteData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to open the aircond!");
  }
}

Future<RemoteData> IncreaseTempAC() async {
  final response =
      await http.get(Uri.parse('https://junwei.pagekite.me/api/aircond/up/'));
  if (response.statusCode == 200) {
    return RemoteData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to open the aircond!");
  }
}

Future<RemoteData> LowerTempAC() async {
  final response =
      await http.get(Uri.parse('https://junwei.pagekite.me/api/aircond/down/'));
  if (response.statusCode == 200) {
    return RemoteData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to open the aircond!");
  }
}

class RemoteData {
  final String message;
  final int code;
  dynamic celcius_degree;

  RemoteData({
    required this.message,
    required this.code,
    required this.celcius_degree,
  });
  factory RemoteData.fromJson(Map<String, dynamic> json) {
    return RemoteData(
        message: json['message'],
        code: json['code'],
        celcius_degree: json['degree']);
  }
}
