class UserModel{

  String id;
  String name;
  String email;
  DateTime createdAt;

  UserModel({required this.id, required this.name, required this.email, required this.createdAt});

  UserModel.fromMap(Map<dynamic, dynamic> json) : // notice Map<dynamic, dynamic> here
        id = json['id'] ?? '',
        name = json['name'] ?? '',
        email = json['email'] ?? '',
        createdAt = json['createdAt'].toDate();

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'createdAt': createdAt
  };
}