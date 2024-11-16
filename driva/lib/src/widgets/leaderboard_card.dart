import 'package:flutter/material.dart';
import '../models/leaderboard_entry.dart';

class LeaderboardCard extends StatelessWidget {
  final List<LeaderboardEntry> entries;
  final String title;

  const LeaderboardCard({
    super.key,
    required this.entries,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return _buildLeaderboardItem(entry, index + 1);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardItem(LeaderboardEntry entry, int position) {
    final minutes = entry.time.inMinutes;
    final seconds = entry.time.inSeconds % 60;
    final timeString = '$minutes:${seconds.toString().padLeft(2, '0')}';

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getPositionColor(position),
        child: Text(
          position.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(entry.userName),
      subtitle: Text(entry.routeName),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            timeString,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            '${entry.averageSpeed.toStringAsFixed(1)} km/h',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Color _getPositionColor(int position) {
    switch (position) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey[400]!;
      case 3:
        return Colors.brown;
      default:
        return Colors.blue;
    }
  }
}