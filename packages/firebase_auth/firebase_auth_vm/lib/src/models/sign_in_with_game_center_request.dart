// File created by
// Lung Razvan <long1eu>
// on 07/12/2019

part of firebase_auth_vm;

/// The request to sign in with Game Center account
class SignInWithGameCenterRequest {
  SignInWithGameCenterRequest({
    required this.playerId,
    required this.publicKeyUrl,
    required this.signature,
    required this.salt,
    required this.timestamp,
    this.accessToken,
    required this.displayName,
  });

  /// The playerID to verify.
  final String playerId;

  /// The URL for the public encryption key.
  final String publicKeyUrl;

  /// The verification signature data generated by Game Center.
  final Uint8List signature;

  /// A random strong used to compute the hash and keep it randomized.
  final Uint8List salt;

  /// The date and time that the signature was created.
  final DateTime timestamp;

  /// The STS Access Token for the authenticated user, only needed for linking the user.
  final String? accessToken;

  /// The display name of the local Game Center player.
  final String displayName;

  Map<String, dynamic> get json {
    return <String, dynamic>{
      'playerId': playerId,
      'publicKeyUrl': publicKeyUrl,
      'signature': base64UrlEncode(signature),
      'salt': base64UrlEncode(salt),
      'timestamp': timestamp.toUtc().millisecondsSinceEpoch,
      'idToken': accessToken,
      'displayName': displayName,
    };
  }

  @override
  String toString() {
    return (ToStringHelper(SecureTokenRequest)
          ..add('playerId', playerId)
          ..add('publicKeyUrl', publicKeyUrl)
          ..add('signature', base64UrlEncode(signature))
          ..add('salt', base64UrlEncode(salt))
          ..add('timestamp', timestamp)
          ..add('accessToken', accessToken)
          ..add('displayName', displayName))
        .toString();
  }
}

class SignInWithGameCenterResponse {
  factory SignInWithGameCenterResponse.fromJson(Map<dynamic, dynamic> json) {
    return SignInWithGameCenterResponse._(
      idToken: json['idToken'],
      refreshToken: json['refreshToken'],
      localId: json['localId'],
      playerId: json['playerId'],
      expiresIn: json['expiresIn'],
      isNewUser: json['isNewUser'],
      displayName: json['displayName'],
    );
  }

  SignInWithGameCenterResponse._({
    required this.idToken,
    required this.refreshToken,
    required this.localId,
    required this.playerId,
    required this.expiresIn,
    required this.isNewUser,
    required this.displayName,
  });

  /// Either an authorization code suitable for performing an STS token exchange, or the access token from Secure Token
  /// Service, depending on whether [returnSecureToken] is set on the request.
  final String idToken;

  /// The refresh token from Secure Token Service.
  final String refreshToken;

  /// The Firebase Auth user ID.
  final String localId;

  /// The verified player ID.
  final String playerId;

  /// The approximate expiration date of the access token.
  final String expiresIn;

  /// Flag indicating that the user signing in is a new user and not a returning user.
  final bool isNewUser;

  /// The user's Game Center display name.
  final String displayName;

  @override
  String toString() {
    return (ToStringHelper(SecureTokenRequest)
          ..add('idToken', idToken)
          ..add('refreshToken', refreshToken)
          ..add('localId', localId)
          ..add('playerId', playerId)
          ..add('expiresIn', expiresIn)
          ..add('isNewUser', isNewUser)
          ..add('displayName', displayName))
        .toString();
  }
}
