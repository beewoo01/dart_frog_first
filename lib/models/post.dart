import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  const Post({
    required this.userId, 
    required this.id, 
    required this.title, 
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  final int userId;
  final int id;
  final String title;
  final String body;

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  List<Object> get props => [userId, id, title, body];

  @override
  String toString() {
    return 'Post(userId: $userId, id: $id, title: $title, body: $body)';
  }

  Post copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) {
    return Post(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}
