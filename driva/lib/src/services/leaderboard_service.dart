import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/leaderboard_entry.dart';
import '../models/driving_session.dart';
import '../models/user_model.dart';

class LeaderboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addLeaderboardEntry(
    DrivingSession session,
    UserModel user,
    String routeName,
  ) async {
    final entry = LeaderboardEntry(
      id: session.id,
      userId: user.id,
      userName: user.name,
      userPhotoUrl: user.photoUrl,
      routeId: session.id,
      routeName: routeName,
      distance: session.distance,
      time: session.endTime!.difference(session.startTime),
      averageSpeed: session.averageSpeed,
      completedAt: session.endTime!,
    );

    await _firestore
        .collection('leaderboard')
        .doc(entry.id)
        .set(entry.toJson());
  }

  Stream<List<LeaderboardEntry>> getWeeklyLeaderboard() {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    
    return _firestore
        .collection('leaderboard')
        .where('completedAt', isGreaterThan: weekAgo)
        .orderBy('completedAt', descending: true)
        .orderBy('timeInSeconds')
        .limit(10)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LeaderboardEntry.fromJson(doc.data()))
            .toList());
  }

  Stream<List<LeaderboardEntry>> getRouteLeaderboard(String routeId) {
    return _firestore
        .collection('leaderboard')
        .where('routeId', isEqualTo: routeId)
        .orderBy('timeInSeconds')
        .limit(10)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LeaderboardEntry.fromJson(doc.data()))
            .toList());
  }

  Stream<List<LeaderboardEntry>> getUserLeaderboard(String userId) {
    return _firestore
        .collection('leaderboard')
        .where('userId', isEqualTo: userId)
        .orderBy('completedAt', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LeaderboardEntry.fromJson(doc.data()))
            .toList());
  }
}