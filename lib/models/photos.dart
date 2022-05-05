// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Photo> postFromJson(String str) => List<Photo>.from(json.decode(str).map((x) => Photo.fromJson(x)));

String postToJson(List<Photo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Photo {
  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    albumId: json["albumId"],
    id: json["id"],
    title: json["title"],
    url: json["url"],
    thumbnailUrl: json["thumbnailUrl"],
  );

  Map<String, dynamic> toJson() => {
    "albumId": albumId,
    "id": id,
    "title": title,
    "url": url,
    "thumbnailUrl": thumbnailUrl,
  };
}