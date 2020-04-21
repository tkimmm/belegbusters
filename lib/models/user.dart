class User {
  final int userId;
  final String name;
  final String surname;
  final String location;
  final String email;
  final String phone_1;
  final String phone_2;

  User({this.name, this.surname, this.location, this.email, this.phone_1, this.phone_2, this.userId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] as int,
      name: json['name'] as String,
      surname: json['surname'] as String,
      location: json['location'] as String,
      email: json['email'] as String,
      phone_1: json['phone_1'] as String,
      phone_2: json['phone_2'] as String,
    );
  }
}