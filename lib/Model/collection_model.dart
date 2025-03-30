class CollectionModel {
  final int id;
  final String collectionName;
  final int collectionType;
  final String createdAt;
  final bool stopped;

  // Constructor
  CollectionModel({
    required this.id,
    required this.collectionName,
    required this.collectionType,
    required this.createdAt,
    required this.stopped,
  });

  // Convert JSON to Model (Factory Method)
  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'] as int,
      collectionName: json['collection_name'] as String,
      collectionType: json['collection_type'] as int,
      createdAt: json['created_at'] as String,
      stopped: json['stopped'] as bool,
    );
  }

  // Convert Model to JSON (to store in a database or API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collection_name': collectionName,
      'collection_type': collectionType,
      'created_at': createdAt,
      'stopped': stopped,
    };
  }
}
