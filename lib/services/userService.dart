import 'dart:convert';
import 'package:book_summary/services/dbService.dart';
import 'package:book_summary/models/resultModel.dart';
import 'package:book_summary/models/userModel.dart';
import 'package:book_summary/staticClass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mssql_connection/mssql_connection.dart';

class UserService {
  MssqlConnection mssqlConnection = MssqlConnection.getInstance();

  /// Google ile giriş yap
  Future<ResultModel> signInWithGoogle() async {
    var model = ResultModel(isSuccess: false);
    try {
      await GoogleSignIn().signOut(); // Önceki oturumu sonlandır

      // Google hesabı seçimi
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Hesap doğrulama
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Firebase ile oturum açma
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        if (userCredential.user != null) {
          var user = userCredential.user;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("userId", user!.uid);
          model.isSuccess = true;

          return model;
        } else {
          model.message = "Kullanıcı bilgisi alınamadı!";
          return model;
        }
      } else {
        model.message = "Google ile oturum açma iptal edildi!";
        return model;
      }
    } on FirebaseAuthException catch (e) {
      model.message = "FirebaseAuthException: ${e.message}";
      // print("FirebaseAuthException: ${e.message}");
      return model;
    } catch (e) {
      model.message = "Bilinmeyen Hata: ${e.toString()}";
      // print("Bilinmeyen Hata: ${e.toString()}");
      return model;
    }
  }

  /// Kullanıcı bilgisini DB'den çekme
  Future<UserModel?> getUserByGoogleId(String googleId) async {
    bool connected = await DbService().initDatabase();
    if (connected) {
      try {
        String query = '''
        SELECT * FROM Users WHERE GoogleId = '$googleId'
      ''';
        dynamic result = await mssqlConnection.getData(query);
        dynamic decodedResult = json.decode(result);
        if (decodedResult is List<dynamic>) {
          List<Map<String, dynamic>> resultList =
              List<Map<String, dynamic>>.from(decodedResult);
          if (resultList.isNotEmpty) {
            return UserModel.fromJson(resultList.first);
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

  /// Kullanıcıyı Veritabanına kaydetme (kaydı yoksa)
  Future<void> saveUser(UserModel user) async {
    bool connected = await DbService().initDatabase();
    StaticClass.name = user.name;
    StaticClass.image = user.image;
    StaticClass.email = user.email;
    if (connected) {
      try {
        var dbUser = await getUserByGoogleId(user.googleId);
        if (dbUser == null) {
          String query = '''
        INSERT INTO Users (Name, Email, Image, GoogleId)
        VALUES ('${user.name}', '${user.email}', '${user.image ?? ''}', '${user.googleId}')
      ''';
          await mssqlConnection.writeData(query);
        }

        // print("Kullanıcı başarıyla kaydedildi.");
      } catch (e) {
        // print("Kullanıcı kaydetme hatası: $e");
      }
    }
  }

  Future<int> checkLanguage() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var localLanguage = localStorage.getString('localLanguage');
    if (localLanguage == 'en') {
      return 2;
    } else if (localLanguage == 'tr') {
      return 1;
    } else {
      return 1;
    }
  }
}
