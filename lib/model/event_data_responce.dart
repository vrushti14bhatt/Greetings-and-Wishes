// To parse this JSON data, do
//
//     final eventDataResponce = eventDataResponceFromJson(jsonString);

import 'dart:convert';

EventDataResponce eventDataResponceFromJson(String str) => EventDataResponce.fromJson(json.decode(str));

String eventDataResponceToJson(EventDataResponce data) => json.encode(data.toJson());

class EventDataResponce {
  EventDataResponce({
    required this.data,
    required this.isSuccess,
  });

  Data data;
  String isSuccess;

  factory EventDataResponce.fromJson(Map<String, dynamic> json) => EventDataResponce(
    data: Data.fromJson(json["data"]),
    isSuccess: json["isSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "isSuccess": isSuccess,
  };
}

class Data {
  Data({
    required this.category,
    required this.favorite,
  });

  List<Category> category;
  Favorite favorite;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    favorite: Favorite.fromJson(json["favorite"]),
  );

  Map<String, dynamic> toJson() => {
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
    "favorite": favorite.toJson(),
  };
}

class Category {
  Category({
    required this.title,
    required this.message,
    required this.images,
  });

  String title;
  List<Message> message;
  List<Image> images;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    title: json["title"],
    message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": List<dynamic>.from(message.map((x) => x.toJson())),
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };
}

class Image {
  Image({
    required this.imagesId,
    required this.image,
  });

  int imagesId;
  String image;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    imagesId: json["imagesId"],
    image: json["image"]!,
  );

  Map<String, dynamic> toJson() => {
    "imagesId": imagesId,
    "image": image,
  };
}


class Message {
  Message({
    required this.messageId,
    required this.message,
  });

  int messageId;
  String message;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    messageId: json["messageId"],
    message: json["message"]!,
  );

  Map<String, dynamic> toJson() => {
    "messageId": messageId,
    "message": message,
  };
}

class Favorite {
  Favorite({
    required this.images,
    required this.messages,
  });

  List<dynamic> images;
  List<dynamic> messages;

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    images: List<dynamic>.from(json["images"].map((x) => x)),
    messages: List<dynamic>.from(json["messages"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "images": List<dynamic>.from(images.map((x) => x)),
    "messages": List<dynamic>.from(messages.map((x) => x)),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map, this.reverseMap);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
