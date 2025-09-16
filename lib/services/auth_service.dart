import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing user authentication state and persistent login
class AuthService {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _phoneNumberKey = 'phone_number';
  static const String _loginTimestampKey = 'login_timestamp';
  static const String _userNameKey = 'user_name';

  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  SharedPreferences? _prefs;

  /// Initialize the service with SharedPreferences instance
  Future<void> init() async {
    try {
      if (_prefs == null) {
        _prefs = await SharedPreferences.getInstance();
      }
    } catch (e) {
      print('AuthService init error: $e'); // Debug log
      throw Exception('Failed to initialize SharedPreferences: $e');
    }
  }

  /// Check if user is currently logged in
  Future<bool> isLoggedIn() async {
    try {
      if (_prefs == null) {
        _prefs = await SharedPreferences.getInstance();
      }
      return _prefs!.getBool(_isLoggedInKey) ?? false;
    } catch (e) {
      print('AuthService isLoggedIn error: $e'); // Debug log
      return false;
    }
  }

  /// Get stored phone number
  Future<String?> getPhoneNumber() async {
    try {
      if (_prefs == null) {
        _prefs = await SharedPreferences.getInstance();
      }
      return _prefs!.getString(_phoneNumberKey);
    } catch (e) {
      print('AuthService getPhoneNumber error: $e'); // Debug log
      return null;
    }
  }

  /// Get stored user name
  Future<String?> getUserName() async {
    try {
      if (_prefs == null) {
        _prefs = await SharedPreferences.getInstance();
      }
      return _prefs!.getString(_userNameKey) ?? 'User';
    } catch (e) {
      print('AuthService getUserName error: $e'); // Debug log
      return 'User';
    }
  }

  /// Get login timestamp
  Future<DateTime?> getLoginTimestamp() async {
    try {
      if (_prefs == null) {
        _prefs = await SharedPreferences.getInstance();
      }
      final timestamp = _prefs!.getInt(_loginTimestampKey);
      return timestamp != null
          ? DateTime.fromMillisecondsSinceEpoch(timestamp)
          : null;
    } catch (e) {
      print('AuthService getLoginTimestamp error: $e'); // Debug log
      return null;
    }
  }

  /// Login user and save authentication data
  Future<void> login(String phoneNumber, {String userName = 'User'}) async {
    try {
      // Ensure SharedPreferences is initialized
      if (_prefs == null) {
        _prefs = await SharedPreferences.getInstance();
      }

      // Save authentication data
      final results = await Future.wait([
        _prefs!.setBool(_isLoggedInKey, true),
        _prefs!.setString(_phoneNumberKey, phoneNumber),
        _prefs!.setString(_userNameKey, userName),
        _prefs!.setInt(
          _loginTimestampKey,
          DateTime.now().millisecondsSinceEpoch,
        ),
      ]);

      // Check if all operations succeeded
      if (!results.every((result) => result)) {
        throw Exception('Failed to save some authentication data');
      }
    } catch (e) {
      print('AuthService login error: $e'); // Debug log
      throw Exception('Failed to save authentication data: $e');
    }
  }

  /// Logout user and clear authentication data
  Future<void> logout() async {
    try {
      // Ensure SharedPreferences is initialized
      if (_prefs == null) {
        _prefs = await SharedPreferences.getInstance();
      }

      // Clear authentication data
      final results = await Future.wait([
        _prefs!.setBool(_isLoggedInKey, false),
        _prefs!.remove(_phoneNumberKey),
        _prefs!.remove(_userNameKey),
        _prefs!.remove(_loginTimestampKey),
      ]);

      // Check if all operations succeeded
      if (!results.every((result) => result)) {
        throw Exception('Failed to clear some authentication data');
      }
    } catch (e) {
      print('AuthService logout error: $e'); // Debug log
      throw Exception('Failed to clear authentication data: $e');
    }
  }

  /// Check if login session has expired (optional - for security)
  Future<bool> isSessionExpired({
    Duration maxSessionDuration = const Duration(days: 30),
  }) async {
    final loginTimestamp = await getLoginTimestamp();
    if (loginTimestamp == null) return true;

    final now = DateTime.now();
    final difference = now.difference(loginTimestamp);
    return difference > maxSessionDuration;
  }

  /// Get user authentication data
  Future<Map<String, dynamic>?> getUserData() async {
    final isLoggedIn = await this.isLoggedIn();
    if (!isLoggedIn) return null;

    final phoneNumber = await getPhoneNumber();
    final userName = await getUserName();
    final loginTimestamp = await getLoginTimestamp();

    return {
      'phoneNumber': phoneNumber,
      'userName': userName,
      'loginTimestamp': loginTimestamp,
      'isLoggedIn': isLoggedIn,
    };
  }

  /// Clear all stored data (useful for app reset)
  Future<void> clearAllData() async {
    if (_prefs == null) await init();
    await _prefs?.clear();
  }
}
