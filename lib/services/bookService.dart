import 'dart:convert';
import 'dart:io';
import 'package:book_summary/models/bookCommentsModel.dart';
import 'package:book_summary/models/bookModel.dart';
import 'package:book_summary/services/dbService.dart';
import 'package:book_summary/services/userService.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mssql_connection/mssql_connection.dart';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';

class BookService {
  final storage = FirebaseStorage.instance;
  MssqlConnection mssqlConnection = MssqlConnection.getInstance();

  ///Kitap Resmini Storage'a ekle
  Future<bool> saveBook(String bookName, String bookSummary, String bookGenre,
      String? headerImage) async {
    if (headerImage != null) {
      String fileName = path.basename(headerImage);
      String storagePath = 'images/books/$fileName';
      try {
        final fileType = lookupMimeType(headerImage) ?? 'image/jpeg';

        await storage.ref().child(storagePath).putFile(
            File(headerImage), SettableMetadata(contentType: fileType));

        String imageUrl =
            await storage.ref().child(storagePath).getDownloadURL();

        var book = BooksModel(
          bookName: bookName,
          bookSummary: bookSummary,
          bookGenre: bookGenre,
          bookImageUrl: imageUrl,
        );

        var resultDb = await saveBookToDatabase(book);
        if (resultDb) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        // print("Kitap ve resim kaydetme hatası: $e");
        return false;
      }
    } else {
      return false;
    }
  }

  ///Kitabı Veritabanına Kaydet
  Future<bool> saveBookToDatabase(BooksModel book) async {
    bool connected = await DbService().initDatabase();
    if (connected) {
      try {
        String query = '''
          INSERT INTO Books (BookName, BookSummary, BookGenre, BookImageUrl)
          VALUES ('${book.bookName}', '${book.bookSummary}', '${book.bookGenre}', '${book.bookImageUrl}')
        ''';
        await mssqlConnection.writeData(query);
      } catch (e) {
        // print("Kitap kaydetme hatası: $e");
        return false;
      } finally {
        return true;
      }
    } else {
      return false;
    }
  }

  ///Kitap Listesi
  Future<List<BooksModel>> getBooks(int languageId) async {
    try {
      String query = '''
   SELECT b.*,c.Name as [CategoryName]
  FROM  [dbo].[Books] b
  INNER JOIN [dbo].[Categories] c ON b.BookGenre=c.Id AND c.LanguageId=$languageId
      ''';
      dynamic result = await mssqlConnection.getData(query);

      List<Map<String, dynamic>> resultList =
          List<Map<String, dynamic>>.from(json.decode(result));

      List<BooksModel> books = [];
      for (var row in resultList) {
        books.add(BooksModel.fromJson(row));
      }
      return books;
    } catch (e) {
      print("Kitapları alma hatası: $e");
      return [];
    }
  }

  ///Kitap Detayı
  Future<BooksModel?> getBookDetail(int bookId, int languageId) async {
    bool connected = await DbService().initDatabase();
    if (connected) {
      try {
        String query = '''
   SELECT b.*,c.Name as [CategoryName]
  FROM  [dbo].[Books] b
  INNER JOIN [dbo].[Categories] c ON b.BookGenre=c.Id AND c.LanguageId=$languageId
  WHERE b.Id=$bookId
      ''';
        dynamic result = await mssqlConnection.getData(query);
        dynamic decodedResult = json.decode(result);
        if (decodedResult is List<dynamic>) {
          List<Map<String, dynamic>> resultList =
              List<Map<String, dynamic>>.from(decodedResult);
          if (resultList.isNotEmpty) {
            return BooksModel.fromJson(resultList.first);
          } else {
            return null;
          }
        } else {
          // print("Geçersiz veri türü: $decodedResult");
          return null;
        }
      } catch (e) {
        // print("Kullanıcı getirme hatası: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  ///Kitaba Not Ekle
  Future<bool> saveBookComment(
      int bookId, String userGoogleId, int page, String? comment) async {
    try {
      var dbUser = await UserService().getUserByGoogleId(userGoogleId);

      if (dbUser == null) {
        return false;
      }
      var userId = dbUser.id;
      String query =
          "INSERT INTO BookComments (BookId, UserId, PageNumber, Comment)   VALUES ($bookId, $userId, $page, '$comment') ";
      await mssqlConnection.writeData(query);
      return true;
    } catch (e) {
      // print("Kitap ve resim kaydetme hatası: $e");
      return false;
    }
  }

  ///Notlarımı Çek
  Future<List<BookCommentsModel>> getBookComments(
      int bookId, String userGoogleId) async {
    try {
      var dbUser = await UserService().getUserByGoogleId(userGoogleId);

      if (dbUser == null) {
        return List.empty();
      }
      var userId = dbUser.id;
      String query = '''
  SELECT Id, [PageNumber]
      ,[Comment]
  FROM  [dbo].[BookComments] WHERE UserId=$userId AND BookId =$bookId
      ''';
      dynamic result = await mssqlConnection.getData(query);

      List<Map<String, dynamic>> resultList =
          List<Map<String, dynamic>>.from(json.decode(result));

      List<BookCommentsModel> books = [];
      for (var row in resultList) {
        books.add(BookCommentsModel.fromJson(row));
      }
      return books;
    } catch (e) {
      // print("Kitapları alma hatası: $e");
      return [];
    }
  }
}
