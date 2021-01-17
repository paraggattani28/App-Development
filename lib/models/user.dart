class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String email;
  final String username;
  final String mobile;
  final String address;
  final String imageLink;
  final bool register;

  UserData(
      {this.uid,
      this.email,
      this.username,
      this.mobile,
      this.address,
      this.imageLink,
      this.register});
}

class Upload {
  final String uid;
  final String title;
  final String details;
  final String link;

  Upload({this.uid, this.title, this.details, this.link});
}

class KarateData {
  final String uid;
  final String title;
  final String details;
  final String link;

  KarateData({this.uid, this.title, this.details, this.link});
}
