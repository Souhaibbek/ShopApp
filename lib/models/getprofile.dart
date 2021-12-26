class ProfileModel {
  late bool status;
  String? message;
  late UserDataMODEL data;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = UserDataMODEL.fromJson(json['data']);
  }
}

class UserDataMODEL {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  UserDataMODEL.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    id = json['id'];
    credit = json['credit'];
    token = json['token'];
  }
}
