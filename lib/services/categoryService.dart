import 'dart:convert';
import 'package:book_summary/models/categoryModel.dart'; 
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mssql_connection/mssql_connection.dart';

class CategoryService {
  final storage = FirebaseStorage.instance;
  MssqlConnection mssqlConnection = MssqlConnection.getInstance();

  Future<List<CategoryModel>> getCategories(int languageId) async {
    try {
      String query =
          "SELECT [Id],[Name] as [CategoryName]  FROM  [dbo].[Categories] where LanguageId=$languageId";
      dynamic result = await mssqlConnection.getData(query);

      List<Map<String, dynamic>> resultList =
          List<Map<String, dynamic>>.from(json.decode(result));

      List<CategoryModel> books = [];
      for (var row in resultList) {
        books.add(CategoryModel.fromJson(row));
      }
      return books;
    } catch (e) {
      print("Kitapları alma hatası: $e");
      return [];
    }
  }
}
