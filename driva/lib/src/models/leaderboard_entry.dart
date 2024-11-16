import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardEntry {
  final String id;
  final String userId;
  final String userName;
  final String? userPhotoUrl;
  final String routeId;
  final String routeName;
  final double distance;
  final Duration time;
  final double averageSpeed;
  final DateTime completedAt;

  LeaderboardEntry({
    required this.id,
    required this.userId,
    required this.userName,
    this.userPhotoUrl,
    required this.routeId,
    required this.routeName,
    required this.distance,
    required this.time,
    required this.averageSpeed,
    required this.completedAt,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userPhotoUrl: json['userPhotoUrl'] as String?,
      routeId: json['routeId'] as String,
      routeName: json['routeName'] as String,
      distance: json['distance'] as double,
      time: Duration(seconds: json['timeInSeconds'] as int),
      averageSpeed: json['averageSpeed'] as double,
      completedAt: (json['completedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
      'routeId': routeId,
      'routeName': routeName,
      'distance': distance,
      'timeInSeconds': time.inSeconds,
      'averageSpeed': averageSpeed,
      'completedAt': Timestamp.fromDate(completedAt),
    };
  }
}