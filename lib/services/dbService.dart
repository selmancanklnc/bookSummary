import 'package:mssql_connection/mssql_connection.dart';

class DbService {
  MssqlConnection mssqlConnection = MssqlConnection.getInstance();

  /// Remote SQL Veritabanı bağlantısı kur
  Future<bool> initDatabase() async {
    bool isConnected = await mssqlConnection.connect(
      ip: '???',
      port: '???',
      databaseName: '???',
      username: '???',
      password: '???',
      timeoutInSeconds: 15,
    );
    return isConnected;
  }
}
