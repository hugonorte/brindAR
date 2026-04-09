class AuthService {
  bool _isAuthenticated = true; // Placeholder for prototype

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String token) async {
    // Placeholder for future token-based auth
    _isAuthenticated = true;
  }

  Future<void> logout() async {
    _isAuthenticated = false;
  }
}
