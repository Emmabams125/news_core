abstract class NetworkConstants {
  const NetworkConstants();

  // Use 10.0.2.2 for Android emulator
  static const baseUrl = 'http://10.0.2.2:3000/api/v1';
  static const authority = '10.0.2.2:3000';
  static const apiUrl = '/api/v1';
  static const headers = {'Content-Type': 'application/json; charset=UTF-8'};
  static const pageSize = 10;
}
