class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final List<String> friendIds;
  final List<String> groupIds;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.friendIds = const [],
    this.groupIds = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      friendIds: List<String>.from(json['friendIds'] ?? []),
      groupIds: List<String>.from(json['groupIds'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'friendIds': friendIds,
      'groupIds': groupIds,
    };
  }
}