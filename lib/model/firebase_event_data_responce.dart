

import 'dart:convert';

FirebaseEventDataResponce firebaseEventDataResponceFromJson(String str) => FirebaseEventDataResponce.fromJson(json.decode(str));

String firebaseEventDataResponceToJson(FirebaseEventDataResponce data) => json.encode(data.toJson());

class FirebaseEventDataResponce {
  FirebaseEventDataResponce({
    required this.data,
  });

  Data data;

  factory FirebaseEventDataResponce.fromJson(Map<String, dynamic> json) => FirebaseEventDataResponce(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.category,
    required this.isSuccess,
  });

  List<Category> category;
  String isSuccess;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    isSuccess: json["isSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
    "isSuccess": isSuccess,
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
  List<ImageElement> images;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    title: json["title"],
    message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
    images: List<ImageElement>.from(json["images"].map((x) => ImageElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": List<dynamic>.from(message.map((x) => x.toJson())),
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };
}

class ImageElement {
  ImageElement({
    required this.imagesId,
    required this.image,
  });

  int imagesId;
  String image;

  factory ImageElement.fromJson(Map<String, dynamic> json) => ImageElement(
    imagesId: json["imagesId"],
    image: json["image"],
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
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "messageId": messageId,
    "message": message,
  };
}

