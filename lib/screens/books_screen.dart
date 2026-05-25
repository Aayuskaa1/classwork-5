import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/author_model.dart';
import '../models/book_model.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bookNameController = TextEditingController();
  final _isbnController = TextEditingController();
  final _priceController = TextEditingController();

  Author? _selectedAuthor;

  final List<Author> _authors = [
    Author(authorName: 'Robert C. Martin'),
    Author(authorName: 'Martin Fowler'),
    Author(authorName: 'Andrew Hunt'),
    Author(authorName: 'Donald Knuth'),
    Author(authorName: 'Kent Beck'),
    Author(authorName: 'Eric Evans'),
  ];

  final List<Book> _books = [];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newBook = Book(
        bookName: _bookNameController.text.trim(),
        isbnNumber: _isbnController.text.trim(),
        bookPrice: double.parse(_priceController.text.trim()),
        author: _selectedAuthor!,
      );
      setState(() {
        _books.add(newBook);
      });
      _clearForm();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Book added successfully!'),
          backgroundColor: Colors.green[300],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  void _clearForm() {
    _bookNameController.clear();
    _isbnController.clear();
    _priceController.clear();
    setState(() {
      _selectedAuthor = null;
    });
  }

  void _deleteBook(int index) {
    setState(() {
      _books.removeAt(index);
    });
  }

  @override
  void dispose() {
    _bookNameController.dispose();
    _isbnController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD6A5),
        elevation: 0,
        title: const Text(
          'Book Registry',
          style: TextStyle(
            color: Color(0xFF5C4033),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Form Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFFD6A5)),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add New Book',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5C4033),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Book Name
                    const Text('Book Name', style: TextStyle(fontSize: 13, color: Color(0xFF5C4033))),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _bookNameController,
                      decoration: _inputDecoration('e.g. Clean Code'),
                      validator: (v) => v == null || v.trim().isEmpty ? 'Enter book name' : null,
                    ),

                    const SizedBox(height: 14),

                    // ISBN
                    const Text('ISBN Number', style: TextStyle(fontSize: 13, color: Color(0xFF5C4033))),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _isbnController,
                      decoration: _inputDecoration('e.g. 978-0-13-468599-1'),
                      validator: (v) => v == null || v.trim().isEmpty ? 'Enter ISBN number' : null,
                    ),

                    const SizedBox(height: 14),

                    // Price
                    const Text('Book Price', style: TextStyle(fontSize: 13, color: Color(0xFF5C4033))),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _priceController,
                      decoration: _inputDecoration('e.g. 1250.00'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Enter price';
                        if (double.tryParse(v.trim()) == null || double.parse(v.trim()) <= 0) {
                          return 'Enter a valid price';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 14),

                    // Author Dropdown
                    const Text('Author', style: TextStyle(fontSize: 13, color: Color(0xFF5C4033))),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<Author>(
                      value: _selectedAuthor,
                      isExpanded: true,
                      decoration: _inputDecoration('Select an author'),
                      items: _authors.map((author) {
                        return DropdownMenuItem<Author>(
                          value: author,
                          child: Text(author.authorName, style: const TextStyle(fontSize: 14)),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedAuthor = value),
                      validator: (v) => v == null ? 'Select an author' : null,
                    ),

                    const SizedBox(height: 20),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _clearForm,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF5C4033),
                              side: const BorderSide(color: Color(0xFFFFD6A5)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Clear'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFD6A5),
                              foregroundColor: const Color(0xFF5C4033),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text(
                              'Add Book',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            if (_books.isNotEmpty) ...[
              Text(
                'Books (${_books.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5C4033),
                ),
              ),
              const SizedBox(height: 12),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _books.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) => _buildBookCard(_books[index], index),
              ),
            ] else ...[
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Icon(Icons.menu_book_outlined, size: 48, color: Colors.brown[200]),
                    const SizedBox(height: 12),
                    Text(
                      'No books added yet',
                      style: TextStyle(fontSize: 14, color: Colors.brown[300]),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
      filled: true,
      fillColor: const Color(0xFFFFF8F0),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFFFD6A5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFFFD6A5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFFFB347), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFFFAAAA)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFFFAAAA), width: 1.5),
      ),
    );
  }

  Widget _buildBookCard(Book book, int index) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFFD6A5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.bookName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5C4033),
                  ),
                ),
                const SizedBox(height: 4),
                Text('ISBN: ${book.isbnNumber}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                Text('Author: ${book.author.authorName}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                Text('Price: Rs. ${book.bookPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _deleteBook(index),
            icon: const Icon(Icons.delete_outline, color: Color(0xFFFFAAAA), size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}