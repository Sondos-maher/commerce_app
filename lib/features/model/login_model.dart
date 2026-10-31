
class LoginModel {
  int? statusCode;
  Data? data;
  String? message;

  LoginModel({
    this.statusCode,
    this.data,
    this.message,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = Data.fromJson(json['data']);
    message = json['message'];
  }
}

class Data {
  String? token;
  User? user;

  Data({
    this.token,
    this.user,
  });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];

    user = json['user'] != null
        ? User.fromJson(json['user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['token'] = token;

    if (user != null) {
      data['user'] = user!.toJson();
    }

    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;

    return data;
  }
}
