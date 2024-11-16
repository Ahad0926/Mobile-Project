import 'package:google_maps_flutter/google_maps_flutter.dart';

class DrivingSession {
  final String id;
  final String userId;
  final DateTime startTime;
  final DateTime? endTime;
  final List<LatLng> coordinates;
  final double distance; // in kilometers
  final double averageSpeed; // in km/h
  final double maxSpeed; // in km/h

  DrivingSession({
    required this.id,
    required this.userId,
    required this.startTime,
    this.endTime,
    required this.coordinates,
    this.distance = 0.0,
    this.averageSpeed = 0.0,
    this.maxSpeed = 0.0,
  });

  factory DrivingSession.fromJson(Map<String, dynamic> json) {
    return DrivingSession(
      id: json['id'] as String,
      userId: json['userId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime'] as String) : null,
      coordinates: (json['coordinates'] as List).map((point) => LatLng(
        point['latitude'] as double,
        point['longitude'] as double,
      )).toList(),
      distance: json['distance'] as double,
      averageSpeed: json['averageSpeed'] as double,
      maxSpeed: json['maxSpeed'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'coordinates': coordinates.map((point) => {
        'latitude': point.latitude,
        'longitude': point.longitude,
      }).toList(),
      'distance': distance,
      'averageSpeed': averageSpeed,
      'maxSpeed': maxSpeed,
    };
  }
}