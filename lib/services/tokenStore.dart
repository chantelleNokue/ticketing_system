class TokenStore {
  String? _token;

  TokenStore._privateConstructor();

  static final TokenStore _instance = TokenStore._privateConstructor();

  factory TokenStore() {
    return _instance;
  }

  String? get token => _token;

  void setToken(String token) {
    _token = token;
  }
}
