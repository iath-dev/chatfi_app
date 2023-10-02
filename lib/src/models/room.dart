import 'dart:convert';

class ChatRoomResponse {
  Room room;

  ChatRoomResponse({
    required this.room,
  });

  factory ChatRoomResponse.fromRawJson(String str) =>
      ChatRoomResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatRoomResponse.fromJson(Map<String, dynamic> json) =>
      ChatRoomResponse(
        room: Room.fromJson(json["room"]),
      );

  Map<String, dynamic> toJson() => {
        "room": room.toJson(),
      };
}

class Room {
  List<String> members;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Room({
    required this.members,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Room.fromRawJson(String str) => Room.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        members: List<String>.from(json["members"].map((x) => x)),
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "members": List<dynamic>.from(members.map((x) => x)),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class InputMessage {
  String from;
  String to;
  String message;

  InputMessage({
    required this.from,
    required this.to,
    required this.message,
  });

  factory InputMessage.fromRawJson(String str) =>
      InputMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InputMessage.fromJson(Map<String, dynamic> json) => InputMessage(
        from: json["from"],
        to: json["to"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "message": message,
      };
}

class ChatHistoryResponse {
  List<InputMessage> data;

  ChatHistoryResponse({
    required this.data,
  });

  factory ChatHistoryResponse.fromRawJson(String str) =>
      ChatHistoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatHistoryResponse.fromJson(Map<String, dynamic> json) =>
      ChatHistoryResponse(
        data: List<InputMessage>.from(
            json["data"].map((x) => InputMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
