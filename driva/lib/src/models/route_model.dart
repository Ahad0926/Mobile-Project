import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteModel {
  final String id;
  final String name;
  final String creatorId;
  final LatLng startLocation;
  final LatLng endLocation;
  final List<LatLng> path;
  final double distance; // in kilometers
  final DateTime createdAt;

  RouteModel({
    required this.id,
    required this.name,
    required this.creatorId,
    required this.startLocation,
    required this.endLocation,
    required this.path,
    required this.distance,
    required this.createdAt,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      id: json['id'] as String,
      name: json['name'] as String,
      creatorId: json['creatorId'] as String,
      startLocation: LatLng(
        json['startLocation']['latitude'] as double,
        json['startLocation']['longitude'] as double,
      ),
      endLocation: LatLng(
        json['endLocation']['latitude'] as double,
        json['endLocation']['longitude'] as double,
      ),
      path: (json['path'] as List).map((point) => LatLng(
        point['latitude'] as double,
        point['longitude'] as double,
      )).toList(),
      distance: json['distance'] as double,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'creatorId': creatorId,
      'startLocation': {
        'latitude': startLocation.latitude,
        'longitude': startLocation.longitude,
      },
      'endLocation': {
        'latitude': endLocation.latitude,
        'longitude': endLocation.longitude,
      },
      'path': path.map((point) => {
        'latitude': point.latitude,
        'longitude': point.longitude,
      }).toList(),
      'distance': distance,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}