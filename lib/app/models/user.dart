import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  /// id unico
  String? id;

  /// uid
  String? uid;

  /// identificador
  String? personalId;

  /// nombre
  String? name;

  /// apellido
  String? lastName;

  /// correo
  String? email;

  /// telefono
  String? phone;

  /// rol
  String? role;

  /// foto
  String? imageUrl;

  /// Ultima conexion
  DateTime? lastConection;

  User({
    this.id,
    this.uid,
    this.name,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.imageUrl,
    this.personalId,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    name = json['name'];
    lastName = json['lastName'] ?? "";
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    imageUrl = json['imageUrl'];
    personalId = json['personalId'];

    if (json['lastConection'] != null) {
      if (json['lastConection'] is Timestamp) {
        lastConection = DateTime.fromMicrosecondsSinceEpoch(
          json['lastConection'].microsecondsSinceEpoch,
        );
      } else {
        lastConection = DateTime.fromMicrosecondsSinceEpoch(
          json['lastConection']['_seconds'] * 1000,
        );
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['email'] = email;
    data['phone'] = phone;
    data['role'] = role;
    data['name'] = name;
    data['lastName'] = lastName;
    data['imageUrl'] = imageUrl;
    data['personalId'] = personalId;
    data['lastConection'] = lastConection;

    return data;
  }

  // static List<User> listFromQuerySnapshot(QuerySnapshot querySnapshot) {
  //   List<User> list = [];
  //   for (var element in querySnapshot.docs) {
  //     list.add(User.fromJson(element.data()));
  //   }
  //   return list;
  // }

  String getRole() {
    switch (role) {
      case "CLIENT":
        return "Cliente";
      case "ADMIN":
        return "Administrador";
      default:
        return "Cliente";
    }
  }

  String getFirtsName() {
    return name!.split(" ").first;
  }

  String getInitialCharName() {
    if ( name == null) return "";
    if (name!.isEmpty) return "";

    return name![0];
  }

  String getInitialCharLastName() {
    if (lastName == null) return "";
    if (lastName!.isEmpty) return "";

    return lastName![0];
  }


}
