class LoginModel
{
 late bool status;
 String? message;
 UserData? data;
LoginModel.fromJson(Map<String , dynamic> json){
  status = json['status'];
  message = json['message'];
  data = json['data'] != null ? UserData.fromJson(json['data']) : null;
}
}
class UserData {
 late int id;
 late String name;
late  String phone;
late  String email;
 late String image;
 late int points;
 late int credit;
 late String token;
  UserData({
    id,
    name,
   phone,
    image,
   points,
    credit,
    token,
    email,
  });
//named constructor
  UserData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}