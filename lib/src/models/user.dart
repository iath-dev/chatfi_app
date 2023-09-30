import 'dart:convert';

enum ConnectionStatus { Online, Offline }

class UserModel {
  final ConnectionStatus status;
  final String name, email, uid;

  UserModel(
      {this.status = ConnectionStatus.Online,
      required this.name,
      required this.email,
      required this.uid});

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      status: json["status"] == "0"
          ? ConnectionStatus.Online
          : ConnectionStatus.Offline);

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
      };
}

class UsersResponse {
  List<UserModel> users;

  UsersResponse({
    required this.users,
  });

  factory UsersResponse.fromRawJson(String str) =>
      UsersResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        users: List<UserModel>.from(
            json["users"].map((x) => UserModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class LoginAuthResponse {
  UserModel data;
  String accessToken;

  LoginAuthResponse({
    required this.data,
    required this.accessToken,
  });

  factory LoginAuthResponse.fromRawJson(String str) =>
      LoginAuthResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginAuthResponse.fromJson(Map<String, dynamic> json) =>
      LoginAuthResponse(
        data: UserModel.fromJson(json["data"]),
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "access_token": accessToken,
      };
}
