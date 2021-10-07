// File created by
// Lung Razvan <long1eu>
// on 25/11/2019

part of firebase_auth_vm;

class SecureTokenService {
  SecureTokenService(Client client)
      : _requester = ApiRequester(
          client,
          'https://securetoken.googleapis.com/',
          '',
          gitkit.requestHeaders,
        );

  final ApiRequester _requester;

  /// Refresh a Firebase ID token by issuing an HTTP POST request to the
  /// securetoken.googleapis.com endpoint.
  Future<SecureTokenResponse> refreshToken(SecureTokenRequest request) async {
    return _requester
        .request('/v1/token', 'POST', body: jsonEncode(request.json))
        .then((dynamic data) => SecureTokenResponse.fromJson(data));
  }
}
