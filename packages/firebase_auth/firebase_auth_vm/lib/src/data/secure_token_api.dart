// File created by
// Lung Razvan <long1eu>
// on 23/11/2019

part of firebase_auth_vm;

// todo: authorizationCode constructor is not used so I commented out related
//  code and assumed that we always have an access token, refresh token and
//  expiration timestamp
class SecureTokenApi {
  /// Creates a SecureTokenService with access and refresh tokens.
  SecureTokenApi({
    required Client client,
    required String accessToken,
    required DateTime accessTokenExpirationDate,
    required String refreshToken,
  })  : _secureTokenService = SecureTokenService(client),
        _accessToken = accessToken,
        _accessTokenExpirationDate = accessTokenExpirationDate,
        _refreshToken = refreshToken;

  /* not used
  /// Creates a SecureTokenService with an authorization code.
  ///
  /// [authorizationCode] needs to be exchanged for STS tokens.
  SecureTokenApi.authorizationCode({
    required Client client,
    required String authorizationCode,
  })  : _secureTokenService = SecureTokenService(client),
        _authorizationCode = authorizationCode;

  /// An authorization code which needs to be exchanged for Secure Token Service
  /// tokens.
  String? _authorizationCode;
  */

  final SecureTokenService _secureTokenService;

  /// The currently cached access token. Or null if no token is currently
  /// cached.
  String _accessToken;

  DateTime _accessTokenExpirationDate;

  String _refreshToken;

  /// Fetch a fresh ephemeral access token for the ID associated with this
  /// instance. The token received in should be considered short lived and not
  /// cached.
  Future<String> fetchAccessToken({bool forceRefresh = false}) async {
    if (!forceRefresh && hasValidAccessToken) {
      return _accessToken;
    } else {
      return _requestAccessToken();
    }
  }

  /// Makes a request to STS for an access token.
  Future<String> _requestAccessToken() async {
    final SecureTokenRequest request =
        SecureTokenRequest.withRefreshToken(_refreshToken);
    /* not used
    if (_refreshToken != null && _refreshToken!.isNotEmpty) {
      request = SecureTokenRequest.withRefreshToken(_refreshToken!);
    } else {
      assert(_authorizationCode != null);
      request = SecureTokenRequest.withCode(_authorizationCode!);
    }
    */

    final SecureTokenResponse response =
        await _secureTokenService.refreshToken(request);
    final String newAccessToken = response.accessToken;
    if (newAccessToken.isNotEmpty && newAccessToken != _accessToken) {
      _accessToken = newAccessToken;
      _accessTokenExpirationDate = response.approximateExpirationDate;
    }

    final String newRefreshToken = response.refreshToken;
    if (newRefreshToken.isNotEmpty && newRefreshToken != _refreshToken) {
      _refreshToken = newRefreshToken;
    }

    return newAccessToken;
  }

  bool get hasValidAccessToken {
    final Duration difference =
        _accessTokenExpirationDate.toUtc().difference(DateTime.now().toUtc());
    return _accessToken != null && difference > _kTokenRefreshHeadStart;
  }
}
