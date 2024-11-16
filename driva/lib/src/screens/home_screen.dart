import 'package:driva/src/widgets/leaderboard_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../services/leaderboard_service.dart';

class HomeScreen extends StatelessWidget {
  final LeaderboardService _leaderboardService = LeaderboardService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driva'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh will happen automatically due to StreamBuilder
        },
        child: ListView(
          children: [
            StreamBuilder(
              stream: _leaderboardService.getWeeklyLeaderboard(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error loading leaderboard'),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return LeaderboardCard(
                  entries: snapshot.data!,
                  title: 'Weekly Leaderboard',
                );
              },
            ),
            const SizedBox(height: 16),
            StreamBuilder(
              stream: _leaderboardService.getUserLeaderboard(
                context.read<AuthService>().user?.id ?? '',
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SizedBox.shrink();
                }

                return LeaderboardCard(
                  entries: snapshot.data!,
                  title: 'Your Best Times',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}