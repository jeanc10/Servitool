class Farmer {
  final String id;
  final String name;
  final String address;
  final String telephone;

  final String profilePictureUrl;

  Farmer(
      {this.id,
        this.name,
        this.address,
        this.telephone,
        this.profilePictureUrl});

  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        telephone: json['telephone'],
        profilePictureUrl: json['profilePictureURL']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'telephone': telephone,
      'profilePictureURL': profilePictureUrl
    };
  }

  factory Farmer.fromMap(Map<String, dynamic> json) => Farmer(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      telephone: json['telephone'],
      profilePictureUrl: json['profile_picture_url']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'telephone': telephone,
      'profile_picture_url': profilePictureUrl
    };
  }
}
