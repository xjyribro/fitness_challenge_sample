// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:sample_fitness/data/checkpoints.dart';

class ChallengeStatusStrings {
  static const String ONGOING = 'ongoing';
  static const String PAUSED = 'paused';
  static const String TIMED_OUT = 'timedOut';
  static const String CANCELED = 'canceled';
  static const String COMPLETED = 'completed';
  static const String OTHER = 'other';
}

enum ChallengeStatus { ongoing, paused, timedOut, canceled, completed, other }

extension ChallengeStatusExtension on ChallengeStatus {
  String get string {
    switch (this) {
      case ChallengeStatus.ongoing:
        return ChallengeStatusStrings.ONGOING;
      case ChallengeStatus.paused:
        return ChallengeStatusStrings.PAUSED;
      case ChallengeStatus.timedOut:
        return ChallengeStatusStrings.TIMED_OUT;
      case ChallengeStatus.canceled:
        return ChallengeStatusStrings.CANCELED;
      case ChallengeStatus.completed:
        return ChallengeStatusStrings.COMPLETED;
      default:
        return ChallengeStatusStrings.OTHER;
    }
  }
}

extension GetChallengeStatus on String {
  ChallengeStatus get challengeStatus {
    switch (this) {
      case ChallengeStatusStrings.ONGOING:
        return ChallengeStatus.ongoing;
      case ChallengeStatusStrings.PAUSED:
        return ChallengeStatus.paused;
      case ChallengeStatusStrings.TIMED_OUT:
        return ChallengeStatus.timedOut;
      case ChallengeStatusStrings.CANCELED:
        return ChallengeStatus.canceled;
      case ChallengeStatusStrings.COMPLETED:
        return ChallengeStatus.completed;
      default:
        return ChallengeStatus.other;
    }
  }
}

class Challenge {
  static const String USER_ID = 'userId';
  static const String CHALLENGE_NAME = 'challengeName';
  static const String CHALLENGE_STATUS = 'challengeStatus';
  static const String CHECKPOINTS = 'checkpoints';
  static const String POINTS = 'points';
  static const String STARTED_ON = 'startedOn';
  static const String COMPLETED_ON = 'completedOn';

  String userId;
  String challengeName;
  ChallengeStatus status;
  List<Checkpoint> checkpoints;
  int points;
  DateTime? startedOn;
  DateTime? completedOn;

  Challenge({
    required this.userId,
    required this.challengeName,
    required this.status,
    required this.checkpoints,
    required this.points,
    this.startedOn,
    this.completedOn,
  });

  static Challenge empty() {
    return Challenge(
      userId: '',
      challengeName: '',
      status: ChallengeStatus.other,
      checkpoints: [],
      points: 0,
      startedOn: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        USER_ID: userId,
        CHALLENGE_NAME: challengeName,
        CHALLENGE_STATUS: status.string,
        CHECKPOINTS: jsonEncode(checkpoints.map((cp) => cp.toJson()).toList()),
        POINTS: points,
        STARTED_ON: startedOn,
        COMPLETED_ON: completedOn,
      };

  static Challenge fromJson(Map<String, dynamic> json) {
    String status = json[CHALLENGE_STATUS] ?? ChallengeStatusStrings.OTHER;
    List<dynamic> checkpointsList =
        json[CHECKPOINTS] != null ? List.from(json[CHECKPOINTS]) : [];
    List<Checkpoint> checkpoints =
        checkpointsList.map((data) => Checkpoint.fromJson(data)).toList();
    return Challenge(
        userId: json[USER_ID] ?? '',
        challengeName: json[CHALLENGE_NAME] ?? '',
        status: status.challengeStatus,
        checkpoints: checkpoints,
        points: json[POINTS] ?? 0,
        startedOn: json[STARTED_ON]?.toDate(),
        completedOn: json[COMPLETED_ON]?.toDate());
  }
}
