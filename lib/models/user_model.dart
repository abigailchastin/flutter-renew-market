import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String name;
  final String email;
  final String profileImage;
  final Timestamp joinedDate;
  final List<String> favorites;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.joinedDate,
    required this.favorites,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'] ?? '',
      joinedDate: json['joinedDate'] ?? Timestamp.now(), // Default Timestamp
      favorites:
          List<String>.from(json['favorites'] ?? []), // Pastikan List<String>
    );
  }

  // 🔥 Tambahkan ini untuk konversi dari UserModel ke Firestore (jika perlu menyimpan data)
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'joinedDate': joinedDate,
      'favorites': favorites,
    };
  }
}