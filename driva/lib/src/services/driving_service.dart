import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/driving_session.dart';
import '../models/user_model.dart';
import 'location_service.dart';
import 'leaderboard_service.dart';

class DrivingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LocationService _locationService = LocationService();
  final LeaderboardService _leaderboardService = LeaderboardService();
  DrivingSession? _currentSession;
  List<LatLng> _currentCoordinates = [];

  DrivingSession? get currentSession => _currentSession;

  Future<void> startSession(String userId) async {
    if (_currentSession != null) {
      throw Exception('A session is already in progress');
    }

    final position = await _locationService.getCurrentLocation();
    if (position == null) {
      throw Exception('Could not get current location');
    }

    _currentSession = DrivingSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      startTime: DateTime.now(),
      coordinates: [LatLng(position.latitude, position.longitude)],
    );

    await _locationService.startTracking();
    _locationService.locationStream?.listen(_onLocationUpdate);
  }

  void _onLocationUpdate(position) {
    if (_currentSession == null) return;

    final newCoordinate = LatLng(position.latitude, position.longitude);
    _currentCoordinates.add(newCoordinate);
  }

  Future<void> endSession(UserModel user, String routeName, Type string) async {
    if (_currentSession == null) {
      throw Exception('No active session');
    }

    await _locationService.stopTracking();

    final distance = _locationService.calculateDistance(_currentCoordinates);
    final endTime = DateTime.now();
    final duration = endTime.difference(_currentSession!.startTime).inSeconds;
    final averageSpeed = duration > 0 ? (distance / duration) * 3600 : 0.0;

    final completedSession = DrivingSession(
      id: _currentSession!.id,
      userId: _currentSession!.userId,
      startTime: _currentSession!.startTime,
      endTime: endTime,
      coordinates: _currentCoordinates,
      distance: distance,
      averageSpeed: averageSpeed,
      maxSpeed: _locationService.maxSpeed * 3.6, // Convert m/s to km/h
    );

    await _saveSession(completedSession);
    await _leaderboardService.addLeaderboardEntry(
      completedSession,
      user,
      routeName,
    );

    _currentSession = null;
    _currentCoordinates = [];
  }

  Future<void> _saveSession(DrivingSession session) async {
    await _firestore
        .collection('driving_sessions')
        .doc(session.id)
        .set(session.toJson());
  }

  Future<List<DrivingSession>> getUserSessions(String userId) async {
    final snapshot = await _firestore
        .collection('driving_sessions')
        .where('userId', isEqualTo: userId)
        .orderBy('startTime', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => DrivingSession.fromJson(doc.data()))
        .toList();
  }
}