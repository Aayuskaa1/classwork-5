import 'package:uuid/uuid.dart';
import 'author_model.dart';

class Book {
  final String bookId;
  final String bookName;
  final String isbnNumber;
  final double bookPrice;
  final Author author;

  Book({
    String? bookId,
    required this.bookName,
    required this.isbnNumber,
    required this.bookPrice,
    required this.author,
  }) : bookId = bookId ?? const Uuid().v4();

  Book copyWith({
    String? bookName,
    String? isbnNumber,
    double? bookPrice,
    Author? author,
  }) {
    return Book(
      bookId: bookId,
      bookName: bookName ?? this.bookName,
      isbnNumber: isbnNumber ?? this.isbnNumber,
      bookPrice: bookPrice ?? this.bookPrice,
      author: author ?? this.author,
    );
  }
}