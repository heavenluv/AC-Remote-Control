import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<RoomData> fetchRoomData() async {
  final response =
      await http.get(Uri.parse('https://junwei.pagekite.me/api/get_json/'));
  if (response.statusCode == 200) {
    return RoomData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load data!");
  }
}

class RoomData {
  final double temperature;
  final double humidity;
  final int celcius_degree;

  RoomData({
    required this.temperature,
    required this.humidity,
    required this.celcius_degree,
  });
  factory RoomData.fromJson(Map<String, dynamic> json) {
    var roomData = RoomData(
        temperature: json['temp'],
        humidity: json['humidity'],
        celcius_degree: json['degree']);
    return roomData;
  }
}
