// ignore_for_file: constant_identifier_names

class CheckpointStatusStrings {
  static const String ONGOING = 'ongoing';
  static const String FAILED = 'failed';
  static const String COMPLETED = 'completed';
  static const String OTHER = 'other';
}

enum CheckpointStatus { ongoing, failed, completed, other }

extension CheckpointStatusExtension on CheckpointStatus {
  String get string {
    switch (this) {
      case CheckpointStatus.ongoing:
        return CheckpointStatusStrings.ONGOING;
      case CheckpointStatus.failed:
        return CheckpointStatusStrings.FAILED;
      case CheckpointStatus.completed:
        return CheckpointStatusStrings.COMPLETED;
      default:
        return CheckpointStatusStrings.OTHER;
    }
  }
}

extension GetCheckpointStatus on String {
  CheckpointStatus get checkpointStatus {
    switch (this) {
      case CheckpointStatusStrings.ONGOING:
        return CheckpointStatus.ongoing;
      case CheckpointStatusStrings.FAILED:
        return CheckpointStatus.failed;
      case CheckpointStatusStrings.COMPLETED:
        return CheckpointStatus.completed;
      default:
        return CheckpointStatus.other;
    }
  }
}

class Checkpoint {
  static const String TARGET = 'target';
  static const String PROGRESS = 'progress';
  static const String CHECKPOINT_NAME = 'checkpointName';
  static const String CHECKPOINT_STATUS = 'checkpointStatus';

  int target;
  int progress;
  String checkpointName;
  CheckpointStatus status;

  Checkpoint({
    required this.checkpointName,
    required this.status,
    required this.target,
    required this.progress,
  });

  static Checkpoint empty() {
    return Checkpoint(
      target: 0,
      progress: 0,
      checkpointName: '',
      status: CheckpointStatus.other,
    );
  }

  Map<String, dynamic> toJson() => {
    TARGET: target,
    PROGRESS: progress,
    CHECKPOINT_NAME: checkpointName,
    CHECKPOINT_STATUS: status.string,
  };

  static Checkpoint fromJson(Map<String, dynamic> json) {
    String status = json[CHECKPOINT_STATUS] ?? CheckpointStatusStrings.OTHER;
    return Checkpoint(
      target: json[TARGET] ?? 0,
      progress: json[PROGRESS] ?? 0,
      checkpointName: json[CHECKPOINT_NAME] ?? '',
      status: status.checkpointStatus,
    );
  }
}