import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  StreamController<Position>? _locationController;
  StreamSubscription<Position>? _locationSubscription;
  Timer? _speedUpdateTimer;
  double _currentSpeed = 0.0;
  double _maxSpeed = 0.0;

  Stream<Position>? get locationStream => _locationController?.stream;
  double get currentSpeed => _currentSpeed;
  double get maxSpeed => _maxSpeed;

  Future<bool> requestPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    return permission != LocationPermission.deniedForever;
  }

  Future<void> startTracking() async {
    if (!await requestPermission()) {
      throw Exception('Location permission not granted');
    }

    _locationController = StreamController<Position>.broadcast();
    _locationSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // minimum distance (in meters) before updates
      ),
    ).listen((Position position) {
      _locationController?.add(position);
      _updateSpeed(position);
    });

    // Update speed every second
    _speedUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCurrentSpeed();
    });
  }

  void _updateSpeed(Position position) {
    if (position.speed > _maxSpeed) {
      _maxSpeed = position.speed;
    }
    _currentSpeed = position.speed;
  }

  void _updateCurrentSpeed() {
    // Convert m/s to km/h
    _currentSpeed = _currentSpeed * 3.6;
  }

  Future<void> stopTracking() async {
    await _locationSubscription?.cancel();
    await _locationController?.close();
    _speedUpdateTimer?.cancel();
    _locationController = null;
    _locationSubscription = null;
    _speedUpdateTimer = null;
    _currentSpeed = 0.0;
    _maxSpeed = 0.0;
  }

  Future<Position?> getCurrentLocation() async {
    if (!await requestPermission()) {
      return null;
    }
    return await Geolocator.getCurrentPosition();
  }

  double calculateDistance(List<LatLng> points) {
    double totalDistance = 0.0;
    for (int i = 0; i < points.length - 1; i++) {
      totalDistance += Geolocator.distanceBetween(
        points[i].latitude,
        points[i].longitude,
        points[i + 1].latitude,
        points[i + 1].longitude,
      );
    }
    return totalDistance / 1000; // Convert to kilometers
  }
}