class UserName {
  final String title;
  final String first;
  final String last;

  factory UserName.fromMap(Map<String, dynamic> json) {
    return UserName(
        title: json['title'],
        first: json['first'],
        last: json['last']);
  }

  UserName({
    required this.title,
    required this.first,
    required this.last,
  });
}
