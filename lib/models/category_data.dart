// To parse this JSON data, do
//
//     final inShortsData = inShortsDataFromJson(jsonString);

import 'dart:convert';

InShortsData inShortsDataFromJson(String str) => InShortsData.fromJson(json.decode(str));

String inShortsDataToJson(InShortsData data) => json.encode(data.toJson());

class InShortsData {
  InShortsData({
    required this.category,
    required this.data,
    required this.success,
  });

  final String category;
  final List<Datum> data;
  final bool success;

  factory InShortsData.fromJson(Map<String, dynamic> json) => InShortsData(
    category: json["category"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
  };
}

class Datum {
  Datum({
    required this.author,
    required this.content,
    required this.date,
    required this.id,
    required this.imageUrl,
    required this.readMoreUrl,
    required this.time,
    required this.title,
    required this.url,
  });

  final String author;
  final String content;
  final String date;
  final String id;
  final String imageUrl;
  final String? readMoreUrl;
  final String time;
  final String title;
  final String url;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    author: json["author"],
    content: json["content"],
    date: json["date"],
    id: json["id"],
    imageUrl: json["imageUrl"],
    readMoreUrl: json["readMoreUrl"],
    time: json["time"],
    title: json["title"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "content": content,
    "date": date,
    "id": id,
    "imageUrl": imageUrl,
    "readMoreUrl": readMoreUrl,
    "time": time,
    "title": title,
    "url": url,
  };
}
