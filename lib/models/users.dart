class UserModel {
  final String name;
  final int age;
  final String picture;
  final String email;

  const UserModel({
    required this.name,
    required this.age,
    required this.picture,
    required this.email,
  });
}

const List<UserModel> users = [
  UserModel(name: "John", age: 20, picture: "🧓", email: "john123@gmail.com"),
  UserModel(
      name: "Jack", age: 16, picture: "👨‍🦰", email: "jack132@gmail.com"),
  UserModel(
      name: "Sara", age: 22, picture: "🙍‍♀️", email: "sara312@gmail.com"),
];
