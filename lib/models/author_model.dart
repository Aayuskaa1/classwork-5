import 'package:uuid/uuid.dart';

class Author {
  final String authorId;
  final String authorName;

  Author({
    String? authorId,
    required this.authorName,
  }) : authorId = authorId ?? const Uuid().v4();

  @override
  String toString() => authorName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Author &&
          runtimeType == other.runtimeType &&
          authorId == other.authorId;

  @override
  int get hashCode => authorId.hashCode;
}