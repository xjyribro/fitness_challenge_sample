// ignore_for_file: constant_identifier_names

import 'package:sample_fitness/data/fullname.dart';

class UserTypeStrings {
  static const String PUBLIC = 'public';
  static const String ADMIN = 'admin';
  static const String SUPER_ADMIN = 'superAdmin';
  static const String OTHER = 'other';
}

enum UserType { public, superAdmin, admin, other }

extension UserTypeExtension on UserType {
  String get string {
    switch (this) {
      case UserType.public:
        return UserTypeStrings.PUBLIC;
      case UserType.superAdmin:
        return UserTypeStrings.SUPER_ADMIN;
      case UserType.admin:
        return UserTypeStrings.ADMIN;
      default:
        return UserTypeStrings.OTHER;
    }
  }
}

extension GetUserType on String {
  UserType get userType {
    switch (this) {
      case UserTypeStrings.PUBLIC:
        return UserType.public;
      case UserTypeStrings.SUPER_ADMIN:
        return UserType.superAdmin;
      case UserTypeStrings.ADMIN:
        return UserType.admin;
      default:
        return UserType.other;
    }
  }
}

class User {
  static const String USERNAME = 'username';
  static const String USER_TYPE = 'userType';
  static const String FULL_NAME = 'fullName';
  static const String POINTS = 'points';
  static const String CREATED_ON = 'createdOn';
  static const String DELETED_ON = 'deletedOn';

  String username;
  UserType type;
  FullName fullName;
  int points;
  DateTime createdOn;
  DateTime deletedOn;

  User({
    required this.username,
    required this.type,
    required this.fullName,
    required this.points,
    required this.createdOn,
    required this.deletedOn,
  });

  static User empty() {
    return User(
      username: '',
      type: UserType.other,
      fullName: FullName.empty(),
      points: 0,
      createdOn: DateTime.now(),
      deletedOn: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        USER_TYPE: type.string,
        FULL_NAME: fullName,
        USERNAME: username,
        POINTS: points,
        CREATED_ON: createdOn,
        DELETED_ON: deletedOn,
      };

  static User fromJson(Map<String, dynamic> json) {
    String type = json[USER_TYPE] ?? UserTypeStrings.OTHER;
    FullName fullName = json[FULL_NAME] != null
        ? FullName.fromJson(json[FULL_NAME])
        : FullName.empty();

    return User(
      username: json[USERNAME] ?? '',
      type: type.userType,
      points: json[POINTS] ?? 0,
      fullName: fullName,
      createdOn: json[CREATED_ON].toDate(),
      deletedOn: json[CREATED_ON].toDate(),
    );
  }
}
