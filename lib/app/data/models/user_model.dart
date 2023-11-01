class UserModel {
  String? id;
  String? username;
  String? email;
  String? password;
  String? image;
  DateTime? birthDate;
  DateTime? time;

  UserModel(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.image,
      this.birthDate,
      this.time});
}