// ignore_for_file: constant_identifier_names

class FullName {
  static const String FIRST_NAME = 'firstName';
  static const String LAST_NAME = 'lastName';

  String firstName;
  String lastName;

  FullName({
    required this.firstName,
    required this.lastName,
  });

  static FullName empty() => FullName(
    firstName: '',
    lastName: '',
  );

  static FullName fromJson(Map<String, dynamic> json) {
    return FullName(
      firstName: json[FIRST_NAME] ?? '',
      lastName: json[LAST_NAME] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    FIRST_NAME: firstName,
    LAST_NAME: lastName,
  };
}