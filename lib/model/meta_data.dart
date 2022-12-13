library link_preview;

class LinkMetaData {
  final String title;
  final String description;
  final String image;
  LinkMetaData({
    required this.title,
    required this.description,
    required this.image,
  });

  factory LinkMetaData.fromMap(Map<String, dynamic> map) {
    return LinkMetaData(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
    );
  }

  List<Object> get props => [title, description, image];

  LinkMetaData copyWith({
    String? title,
    String? description,
    String? image,
  }) {
    return LinkMetaData(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'image': image,
    };
  }

  String toString() =>
      'LinkMetaData(title: $title, description: $description, image: $image)';
}
