# Driva App Project Overview

## Introduction
Driva is a navigation app with real-time GPS and mapping capabilities, enhanced with a competitive twist similar to Google Maps and Strava. The app allows users to add friends, track common routes they regularly take or may share with friends, and compete to achieve the best times along these routes, contributing to a public leaderboard.

## App Features

### Homepage
- **Driving Stats**: Users can post driving statistics along with photos, showcasing their driving experiences.
- **Metrics Display**: Key metrics including distance, speed, and time for each trip are displayed, fostering community engagement and friendly competition.

### Route Tracking and Maps
- **Map Page**: Features a dedicated map page that displays nearby driving routes, enabling users to search for existing paths or create their own. This feature helps users discover new driving opportunities and share them with the community.
- **Google Maps API**: Utilizes the Google Maps API to track the trips/driving routes between specific points.
- **Common Segments**: Identifies common segments of trips with friends, and displays suggested routes between destinations.

### Leaderboards and Challenges
- **Personal and Friend Leaderboards**: Displays the fastest trip times to foster competition.
- **Challenges**: Users can compare driving times on shared routes and participate in challenges. This includes time trials on shared routes or segments, promoting a sense of community and friendly competition.

### Progress and Notifications
- **Real-time Updates**: Provides real-time updates on trip progress and notifies users of friends' scores.
- **Snack Bars**: Displays the current trip progress and updates in real-time, e.g., when a user completes a segment.
- **Push Notifications**: Alerts users about friends’ attempts and achievements, keeping the competitive spirit alive.

### Settings and User Preferences
- **Customization**: Allows users to customize trip selection and leaderboard visibility settings.
- **Dialogues and Pickers**: Implements dialogues and pickers to enable users to select trips, set up challenges, and adjust preferences, enhancing the overall user experience through seamless navigation across multiple screens.

### Data Storage and Management
- **SQLite**:
  - **Local Storage**: Used for quick access to user profiles, driving statistics, and custom routes, enabling a responsive experience without internet reliance.
- **Firebase**:
  - **Cloud Storage**: Provides real-time synchronization of driving data across devices, including leaderboards and shared challenges.
  - **User Authentication**: Ensures secure access and personalized experiences.

### HTTP Requests for Map Data
- **Functionality**: Fetches real-time route suggestions, estimated traffic data, and syncs user scores with cloud storage, providing users with accurate and timely information about their routes.

## Technology Stack
- **Frontend**: Flutter
- **Backend**: Firebase Firestore, Firebase Authentication
- **APIs**: Google Maps API
- **Data Management**: SQLite for local data storage, Firebase for cloud storage

## Setup and Configuration
Details on how to set up and configure the app locally, including necessary dependencies, environment setup, and initial run instructions.

## Contributing
Guidelines for contributing to the project, including coding standards, pull request process, and other requirements.

## License
Information about the project's license and usage rights.
