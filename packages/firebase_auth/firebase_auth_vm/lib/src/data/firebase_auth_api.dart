// File created by
// Lung Razvan <long1eu>
// on 23/11/2019

part of firebase_auth_vm;

typedef RawRequestBuilder = ApiRequester Function(
    {Map<String, String> headers});

typedef SignupNewUserRequest = IdentitytoolkitRelyingpartySignupNewUserRequest;
typedef ResetPasswordRequest = IdentitytoolkitRelyingpartyResetPasswordRequest;
typedef SetAccountInfoRequest
    = IdentitytoolkitRelyingpartySetAccountInfoRequest;
typedef SendVerificationCodeRequest
    = IdentitytoolkitRelyingpartySendVerificationCodeRequest;
typedef SendVerificationCodeResponse
    = IdentitytoolkitRelyingpartySendVerificationCodeResponse;
typedef VerifyAssertionRequest
    = IdentitytoolkitRelyingpartyVerifyAssertionRequest;
typedef EmailLinkSigninRequest
    = IdentitytoolkitRelyingpartyEmailLinkSigninRequest;
typedef VerifyPasswordRequest
    = IdentitytoolkitRelyingpartyVerifyPasswordRequest;
typedef VerifyPhoneNumberRequest
    = IdentitytoolkitRelyingpartyVerifyPhoneNumberRequest;
typedef VerifyPhoneNumberResponse
    = IdentitytoolkitRelyingpartyVerifyPhoneNumberResponse;

class FirebaseAuthApi {
  FirebaseAuthApi({
    required Client client,
    RawRequestBuilder? rawBuilder,
  })  : _requester = IdentityToolkitApi(client).relyingparty,
        _rawBuilder = rawBuilder ??
            (({Map<String, String> headers = const <String, String>{}}) {
              return ApiRequester(
                client,
                'https://www.googleapis.com/',
                'identitytoolkit/v3/relyingparty/',
                <String, String>{...headers, ...gitkit.requestHeaders},
              );
            });

  final RelyingpartyResource _requester;
  final RawRequestBuilder _rawBuilder;

  /// Calls the signUpNewUser endpoint, which is responsible anonymously signing
  /// up a user or signing in a user anonymously.
  Future<SignupNewUserResponse> signupNewUser(SignupNewUserRequest request) {
    return _requester.signupNewUser(request);
  }

  /// Calls the getAccountInfo endpoint, which returns account info for a given
  /// account.
  Future<GetAccountInfoResponse> getAccountInfo(
      IdentitytoolkitRelyingpartyGetAccountInfoRequest request) {
    return _requester.getAccountInfo(request);
  }

  /// Calls the getAccountInfo endpoint, which returns account info for a given
  /// account.
  Future<SetAccountInfoResponse> setAccountInfo(SetAccountInfoRequest request) {
    return _requester.setAccountInfo(request);
  }

  /// Calls the createAuthURI endpoint, which is responsible for creating the
  /// URI used by the IdP to authenticate the user.
  Future<CreateAuthUriResponse> createAuthUri(
      IdentitytoolkitRelyingpartyCreateAuthUriRequest request) {
    return _requester.createAuthUri(request);
  }

  Future<GetOobConfirmationCodeResponse> getOobConfirmationCode(
    Relyingparty request, [
    ActionCodeSettings? settings,
  ]) {
    if (settings == null) {
      return _requester.getOobConfirmationCode(request);
    }

    final Map<String, Object> body = <String, Object>{
      ...request.toJson(),
      if (settings.androidInstallIfNotAvailable != null)
        'androidInstallApp': settings.androidInstallIfNotAvailable!,
      if (settings.androidMinimumVersion != null)
        'androidMinimumVersion': settings.androidMinimumVersion!,
      if (settings.androidPackageName != null)
        'androidPackageName': settings.androidPackageName!,
      if (settings.handleCodeInApp)
        'canHandleCodeInApp': settings.handleCodeInApp,
      if (settings.continueUrl != null) 'continueUrl': settings.continueUrl!,
      if (settings.iOSAppStoreId != null)
        'iOSAppStoreId': settings.iOSAppStoreId!,
      if (settings.iOSBundleId != null) 'iOSBundleId': settings.iOSBundleId!,
      if (settings.dynamicLinkDomain != null)
        'dynamicLinkDomain': settings.dynamicLinkDomain!,
    };

    return _rawBuilder()
        .request('getOobConfirmationCode', 'POST', body: jsonEncode(body))
        .then((dynamic data) => GetOobConfirmationCodeResponse.fromJson(data));
  }

  Future<EmailLinkSigninResponse> emailLinkSignin(
      EmailLinkSigninRequest request) {
    return _requester.emailLinkSignin(request);
  }

  Future<VerifyPasswordResponse> verifyPassword(VerifyPasswordRequest request) {
    return _requester.verifyPassword(request);
  }

  Future<SignInWithGameCenterResponse> signInWithGameCenter(
      SignInWithGameCenterRequest request) {
    return _rawBuilder()
        .request('signInWithGameCenter', 'POST', body: jsonEncode(request.json))
        .then((dynamic data) => SignInWithGameCenterResponse.fromJson(data));
  }

  Future<SendVerificationCodeResponse> sendVerificationCode(
      SendVerificationCodeRequest request) {
    return _requester.sendVerificationCode(request);
  }

  Future<IdentitytoolkitRelyingpartyGetProjectConfigResponse>
      getProjectConfig() {
    return _requester.getProjectConfig();
  }

  Future<GetRecaptchaParamResponse> getRecaptchaParam() {
    return _requester.getRecaptchaParam();
  }

  Future<VerifyAssertionResponse> verifyAssertion(
      VerifyAssertionRequest request) {
    return _requester.verifyAssertion(request);
  }

  Future<VerifyCustomTokenResponse> verifyCustomToken(
      IdentitytoolkitRelyingpartyVerifyCustomTokenRequest request) {
    return _requester.verifyCustomToken(request);
  }

  Future<VerifyPhoneNumberResponse> verifyPhoneNumber(
      VerifyPhoneNumberRequest request) {
    return _requester.verifyPhoneNumber(request);
  }

  Future<DeleteAccountResponse> deleteAccount(
      IdentitytoolkitRelyingpartyDeleteAccountRequest request) {
    return _requester.deleteAccount(request);
  }

  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request) {
    return _requester.resetPassword(request);
  }
}
