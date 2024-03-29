import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:sample_fitness/data/challenges.dart';
import 'package:sample_fitness/data/checkpoints.dart';
import 'package:sample_fitness/data/user.dart';

Future<bool> onStartChallenge(String userId, String challengeId) async {
  try {
    // retrieve challenge template from db
    DocumentSnapshot<Map<String, dynamic>> challengeSnapshot =
    await FirebaseFirestore.instance
        .collection('challengeTemplates')
        .doc(challengeId)
        .get();
    if (challengeSnapshot.exists && challengeSnapshot.data() != null) {
      Challenge challenge = Challenge.fromJson(challengeSnapshot.data()!);
      return addNewChallenge(userId, challenge);
    }
    return false;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}

Future<bool> addNewChallenge(String userId, Challenge challenge) async {
  try {
    await FirebaseFirestore.instance.collection('userChallenges').add({
      Challenge.USER_ID: userId,
      // associates user with this challenge, used to search all challenges for a given user
      Challenge.CHALLENGE_NAME: challenge.challengeName,
      Challenge.CHALLENGE_STATUS: ChallengeStatus.ongoing.string,
      Challenge.CHECKPOINTS: challenge.checkpoints,
      Challenge.STARTED_ON: DateTime.now(),
    });
    return true;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}

Checkpoint updateCheckpoint(Checkpoint checkpoint,
    int progress,) {
  checkpoint.progress = progress;
  if (progress == checkpoint.target) {
    checkpoint.status == CheckpointStatus.completed;
  }
  return checkpoint;
}

bool checkAllCheckpointsComplete(List<Checkpoint> checkpoints) {
  return !checkpoints
      .any((checkpoint) => checkpoint.status != CheckpointStatus.completed);
}

Challenge updateChallenge(Challenge challenge,
    String checkpointName,
    int progress,) {
  int index = challenge.checkpoints
      .indexWhere((checkpoint) => checkpoint.checkpointName == checkpointName);
  if (index >= 0) {
    challenge.checkpoints[index] =
        updateCheckpoint(challenge.checkpoints[index], progress);
    if (checkAllCheckpointsComplete(challenge.checkpoints)) {
      challenge.status = ChallengeStatus.completed;
      challenge.completedOn = DateTime.now();
    }
  }
  return challenge;
}

Future<bool> onChallengeProgress(String userId,
    String challengeId,
    String checkpointName,
    int progress,) async {
  try {
    Challenge? challenge = await updateChallengeProgress(
      challengeId,
      checkpointName,
      progress,
    );
    if (challenge != null) {
      if (challenge.status == ChallengeStatus.completed) {
        return onCompleteChallenge(userId, challenge.points);
      }
      return true;
    }
    return false;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}

Future<Challenge?> updateChallengeProgress(String challengeId,
    String checkpointName,
    int progress,) async {
  try {
    // retrieve from db
    DocumentSnapshot<Map<String, dynamic>> challengeSnapshot =
    await FirebaseFirestore.instance
        .collection('userChallenges')
        .doc(challengeId)
        .get();
    if (challengeSnapshot.exists && challengeSnapshot.data() != null) {
      Challenge challenge = Challenge.fromJson(challengeSnapshot.data()!);
      challenge = updateChallenge(
        challenge,
        checkpointName,
        progress,
      );
      // update db
      challengeSnapshot.reference.update({
        Challenge.CHECKPOINTS: challenge.checkpoints,
        Challenge.CHALLENGE_STATUS: challenge.status,
        Challenge.COMPLETED_ON: challenge.completedOn,
      });
      return challenge;
    }
    return null;
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

Future<bool> onCompleteChallenge(String userId, int points) async {
  try {
    // retrieve user data from db
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userSnapshot.exists && userSnapshot.data() != null) {
      User user = User.fromJson(userSnapshot.data()!);
      userSnapshot.reference.update({User.POINTS: user.points + points});
      return true;
    }
    return false;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}
