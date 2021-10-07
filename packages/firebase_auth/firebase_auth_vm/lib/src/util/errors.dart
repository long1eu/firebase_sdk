part of firebase_auth_vm;

class FirebaseAuthError extends FirebaseError {
  factory FirebaseAuthError(String name, String message) {
    switch (name) {
      case 'INVALID_CUSTOM_TOKEN':
        return invalidCustomToken;
      case 'CUSTOM_TOKEN_MISMATCH':
        return customTokenMismatch;
      case 'INVALID_CREDENTIAL':
        return invalidCredential;
      case 'USER_DISABLED':
        return userDisabled;
      case 'OPERATION_NOT_ALLOWED':
        return operationNotAllowed;
      case 'EMAIL_ALREADY_IN_USE':
        return emailAlreadyInUse;
      case 'INVALID_EMAIL':
        return invalidEmail;
      case 'WRONG_PASSWORD':
        return wrongPassword;
      case 'TOO_MANY_ATTEMPTS_TRY_LATER':
      case 'TOO_MANY_REQUESTS':
        return tooManyRequests;
      case 'USER_NOT_FOUND':
        return userNotFound;
      case 'ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
        return accountExistsWithDifferentCredential;
      case 'CREDENTIAL_TOO_OLD_LOGIN_AGAIN':
      case 'REQUIRES_RECENT_LOGIN':
        return requiresRecentLogin;
      case 'PROVIDER_ALREADY_LINKED':
        return providerAlreadyLinked;
      case 'NO_SUCH_PROVIDER':
        return noSuchProvider;
      case 'INVALID_USER_TOKEN':
        return invalidUserToken;
      case 'NETWORK_REQUEST_FAILED':
        return networkError;
      case 'TOKEN_EXPIRED':
      case 'USER_TOKEN_EXPIRED':
        return userTokenExpired;
      case 'INVALID_API_KEY':
        return invalidAPIKey;
      case 'USER_MISMATCH':
        return userMismatch;
      case 'CREDENTIAL_ALREADY_IN_USE':
        return credentialAlreadyInUse;
      case 'WEAK_PASSWORD':
        return weakPassword;
      case 'APP_NOT_AUTHORIZED':
        return appNotAuthorized;
      case 'EXPIRED_ACTION_CODE':
        return expiredActionCode;
      case 'INVALID_ACTION_CODE':
        return invalidActionCode;
      case 'INVALID_MESSAGE_PAYLOAD':
        return invalidMessagePayload;
      case 'INVALID_SENDER':
        return invalidSender;
      case 'INVALID_RECIPIENT_EMAIL':
        return invalidRecipientEmail;
      case 'MISSING_EMAIL':
        return missingEmail;
      case 'MISSING_IOS_BUNDLE_ID':
        return missingIosBundleID;
      case 'MISSING_ANDROID_PKG_NAME':
        return missingAndroidPackageName;
      case 'UNAUTHORIZED_DOMAIN':
        return unauthorizedDomain;
      case 'INVALID_CONTINUE_URI':
        return invalidContinueURI;
      case 'MISSING_CONTINUE_URI':
        return missingContinueURI;
      case 'MISSING_PHONE_NUMBER':
        return missingPhoneNumber;
      case 'INVALID_PHONE_NUMBER':
        return invalidPhoneNumber;
      case 'MISSING_VERIFICATION_CODE':
        return missingVerificationCode;
      case 'INVALID_CODE':
      case 'INVALID_VERIFICATION_CODE':
        return invalidVerificationCode;
      case 'MISSING_VERIFICATION_ID':
        return missingVerificationID;
      case 'INVALID_VERIFICATION_ID':
        return invalidVerificationID;
      case 'MISSING_APP_CREDENTIAL':
        return missingAppCredential;
      case 'INVALID_APP_CREDENTIAL':
        return invalidAppCredential;
      case 'SESSION_EXPIRED':
        return sessionExpired;
      case 'QUOTA_EXCEEDED':
        return quotaExceeded;
      case 'MISSING_APP_TOKEN':
        return missingAppToken;
      case 'NOTIFICATION_NOT_FORWARDED':
        return notificationNotForwarded;
      case 'APP_NOT_VERIFIED':
        return appNotVerified;
      case 'CAPTCHA_CHECK_FAILED':
        return captchaCheckFailed;
      case 'WEB_CONTEXT_ALREADY_PRESENTED':
        return webContextAlreadyPresented;
      case 'WEB_CONTEXT_CANCELLED':
        return webContextCancelled;
      case 'APP_VERIFICATION_FAILED':
        return appVerificationUserInteractionFailure;
      case 'INVALID_CLIENT_ID':
        return invalidClientID;
      case 'WEB_NETWORK_REQUEST_FAILED':
        return webNetworkRequestFailed;
      case 'WEB_INTERNAL_ERROR':
        return webInternalError;
      case 'WEB_USER_INTERACTION_FAILURE':
        return webSignInUserInteractionFailure;
      case 'LOCAL_PLAYER_NOT_AUTHENTICATED':
        return localPlayerNotAuthenticated;
      case 'NULL_USER':
        return nullUser;
      case 'DYNAMIC_LINK_NOT_ACTIVATED':
        return dynamicLinkNotActivated;
      case 'INVALID_PROVIDER_ID':
        return invalidProviderID;
      case 'INVALID_DYNAMIC_LINK_DOMAIN':
        return invalidDynamicLinkDomain;
      case 'REJECTED_CREDENTIAL':
        return rejectedCredential;
      case 'GAME_KIT_NOT_LINKED':
        return gameKitNotLinked;
      case 'MISSING_OR_INVALID_NONCE':
        return missingOrInvalidNonce;
      case 'EMAIL_EXISTS':
        return emailExists;
      case 'MISSING_CLIENT_IDENTIFIER':
        return missingClientIdentifier;
      case 'KEYCHAIN_ERROR':
        return keychainError;
      case 'INTERNAL_ERROR':
        return internalError;
      case 'MALFORMED_JWT':
        return malformedJWT;
      default:
        return FirebaseAuthError._(
            -1, '$name${message.isEmpty ? '' : ' : $message'}', 'unknown');
    }
  }

  FirebaseAuthError._(this.code, String message, this.codeName)
      : super(message);

  final int code;
  final String codeName;

  /// Indicates a validation error with the custom token.
  static final FirebaseAuthError invalidCustomToken = FirebaseAuthError._(
    17000,
    'The custom token format is incorrect. Please check the documentation.',
    'invalid-custom-token',
  );

  /// Indicates the service account and the API key belong to different projects.
  static final FirebaseAuthError customTokenMismatch = FirebaseAuthError._(
    17002,
    'The custom token corresponds to a different audience.',
    'custom-token-mismatch',
  );

  /// Indicates the IDP token or requestUri is invalid.
  static final FirebaseAuthError invalidCredential = FirebaseAuthError._(
    17004,
    'The supplied auth credential is malformed or has expired.',
    'invalid-credential',
  );

  /// Indicates the user's account is disabled on the server.
  static final FirebaseAuthError userDisabled = FirebaseAuthError._(
    17005,
    'The user account has been disabled by an administrator.',
    'user-disabled',
  );

  /// Indicates the administrator disabled sign in with the specified identity provider.
  static final FirebaseAuthError operationNotAllowed = FirebaseAuthError._(
    17006,
    'The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.',
    'operation-not-allowed',
  );

  /// Indicates the email used to attempt a sign up is already in use.
  static final FirebaseAuthError emailAlreadyInUse = FirebaseAuthError._(
    17007,
    'The email address is already in use by another account.',
    'email-already-in-use',
  );

  /// Indicates the email is invalid.
  static final FirebaseAuthError invalidEmail = FirebaseAuthError._(
    17008,
    'The email address is badly formatted.',
    'invalid-email',
  );

  /// Indicates the user attempted sign in with a wrong password.
  static final FirebaseAuthError wrongPassword = FirebaseAuthError._(
    17009,
    'The password is invalid or the user does not have a password.',
    'wrong-password',
  );

  /// Indicates that too many requests were made to a server method.
  static final FirebaseAuthError tooManyRequests = FirebaseAuthError._(
    17010,
    'We have blocked all requests from this device due to unusual activity. Try again later.',
    'too-many-requests',
  );

  /// Indicates the user account was not found.
  static final FirebaseAuthError userNotFound = FirebaseAuthError._(
    17011,
    'There is no user record corresponding to this identifier. The user may have been deleted.',
    'user-not-found',
  );

  /// Indicates account linking is required.
  static final FirebaseAuthError accountExistsWithDifferentCredential =
      FirebaseAuthError._(
    17012,
    'An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.',
    'account-exists-with-different-credential',
  );

  /// Indicates the user has attempted to change email or password more than 5 minutes after signing in.
  static final FirebaseAuthError requiresRecentLogin = FirebaseAuthError._(
    17014,
    'This operation is sensitive and requires recent authentication. Log in again before retrying this request.',
    'requires-recent-login',
  );

  /// Indicates an attempt to link a provider to which the account is already linked.
  static final FirebaseAuthError providerAlreadyLinked = FirebaseAuthError._(
    17015,
    '[ERROR_PROVIDER_ALREADY_LINKED] - User can only be linked to one identity for the given provider.',
    'provider-already-linked',
  );

  /// Indicates an attempt to unlink a provider that is not linked.
  static final FirebaseAuthError noSuchProvider = FirebaseAuthError._(
    17016,
    'User was not linked to an account with the given provider.',
    'no-such-provider',
  );

  /// Indicates user's saved auth credential is invalid, the user needs to sign in again.
  static final FirebaseAuthError invalidUserToken = FirebaseAuthError._(
    17017,
    'This user\'s credential isn\'t valid for this project. This can happen if the user\'s token has been tampered with, or if the user doesn’t belong to the project associated with the API key used in your request.',
    'invalid-user-token',
  );

  /// Indicates a network error occurred (such as a timeout, interrupted connection, or unreachable host). These types of errors are often recoverable with a retry. The `NSUnderlyingError` field in the `NSError.userInfo` dictionary will contain the error encountered.
  static final FirebaseAuthError networkError = FirebaseAuthError._(
    17020,
    'Network error (such as timeout, interrupted connection or unreachable host) has occurred.',
    'network-request-failed',
  );

  /// Indicates the saved token has expired, for example, the user may have changed account password on another device. The user needs to sign in again on the device that made this request.
  static final FirebaseAuthError userTokenExpired = FirebaseAuthError._(
    17021,
    'The user\'s credential is no longer valid. The user must sign in again.',
    'user-token-expired',
  );

  /// Indicates an invalid API key was supplied in the request.
  static final FirebaseAuthError invalidAPIKey = FirebaseAuthError._(
    17023,
    'An invalid API Key was supplied in the request.',
    'invalid-api-key',
  );

  /// Indicates that an attempt was made to reauthenticate with a user which is not the current user.
  static final FirebaseAuthError userMismatch = FirebaseAuthError._(
    17024,
    'The supplied credentials do not correspond to the previously signed in user.',
    'user-mismatch',
  );

  /// Indicates an attempt to link with a credential that has already been linked with a different Firebase account
  static final FirebaseAuthError credentialAlreadyInUse = FirebaseAuthError._(
    17025,
    'This credential is already associated with a different user account.',
    'credential-already-in-use',
  );

  /// Indicates an attempt to set a password that is considered too weak.
  static final FirebaseAuthError weakPassword = FirebaseAuthError._(
    17026,
    'The password must be 6 characters long or more.',
    'weak-password',
  );

  /// Indicates the App is not authorized to use Firebase Authentication with the provided API Key.
  static final FirebaseAuthError appNotAuthorized = FirebaseAuthError._(
    17028,
    'This app is not authorized to use Firebase Authentication with the provided API key. Review your key configuration in the Google API console and ensure that it accepts requests from your app\'s bundle ID.',
    'app-not-authorized',
  );

  /// Indicates the OOB code is expired.
  static final FirebaseAuthError expiredActionCode = FirebaseAuthError._(
    17029,
    'The action code has expired.',
    'expired-action-code',
  );

  /// Indicates the OOB code is invalid.
  static final FirebaseAuthError invalidActionCode = FirebaseAuthError._(
    17030,
    'The action code is invalid. This can happen if the code is malformed, expired, or has already been used.',
    'invalid-action-code',
  );

  /// Indicates that there are invalid parameters in the payload during a "send password reset email" attempt.
  static final FirebaseAuthError invalidMessagePayload = FirebaseAuthError._(
    17031,
    'The action code is invalid. This can happen if the code is malformed, expired, or has already been used.',
    'invalid-message-payload',
  );

  /// Indicates that the sender email is invalid during a "send password reset email" attempt.
  static final FirebaseAuthError invalidSender = FirebaseAuthError._(
    17032,
    'The email template corresponding to this action contains invalid characters in its message. Please fix by going to the Auth email templates section in the Firebase Console.',
    'invalid-sender',
  );

  /// Indicates that the recipient email is invalid.
  static final FirebaseAuthError invalidRecipientEmail = FirebaseAuthError._(
    17033,
    'The action code is invalid. This can happen if the code is malformed, expired, or has already been used.',
    'invalid-recipient-email',
  );

  /// Indicates that an email address was expected but one was not provided.
  static final FirebaseAuthError missingEmail = FirebaseAuthError._(
    17034,
    'An email address must be provided.',
    'missing-email',
  );

  /// Indicates that the iOS bundle ID is missing when a iOS App Store ID is provided.
  static final FirebaseAuthError missingIosBundleID = FirebaseAuthError._(
    17036,
    'An iOS Bundle ID must be provided if an App Store ID is provided.',
    'missing-ios-bundle-id',
  );

  /// Indicates that the android package name is missing when the `androidInstallApp` flag is set to true.
  static final FirebaseAuthError missingAndroidPackageName =
      FirebaseAuthError._(
    17037,
    'An Android Package Name must be provided if the Android App is required to be installed.',
    'missing-android-pkg-name',
  );

  /// Indicates that the domain specified in the continue URL is not whitelisted in the Firebase console.
  static final FirebaseAuthError unauthorizedDomain = FirebaseAuthError._(
    17038,
    'The domain of the continue URL is not whitelisted. Please whitelist the domain in the Firebase console.',
    'unauthorized-domain',
  );

  /// Indicates that the domain specified in the continue URI is not valid.
  static final FirebaseAuthError invalidContinueURI = FirebaseAuthError._(
    17039,
    'The continue URL provided in the request is invalid.',
    'invalid-continue-uri',
  );

  /// Indicates that a continue URI was not provided in a request to the backend which requires one.
  static final FirebaseAuthError missingContinueURI = FirebaseAuthError._(
    17040,
    'A continue URL must be provided in the request.',
    'missing-continue-uri',
  );

  /// Indicates that a phone number was not provided in a call to `verifyPhoneNumber:completion:`.
  static final FirebaseAuthError missingPhoneNumber = FirebaseAuthError._(
    17041,
    'To send verification codes, provide a phone number for the recipient.',
    'missing-phone-number',
  );

  /// Indicates that an invalid phone number was provided in a call to `verifyPhoneNumber:completion:`.
  static final FirebaseAuthError invalidPhoneNumber = FirebaseAuthError._(
    17042,
    'The format of the phone number provided is incorrect. Please enter the phone number in a format that can be parsed into E.164 format. E.164 phone numbers are written in the format [+][country code][subscriber number including area code].',
    'invalid-phone-number',
  );

  /// Indicates that the phone auth credential was created with an empty verification code.
  static final FirebaseAuthError missingVerificationCode = FirebaseAuthError._(
    17043,
    'The phone auth credential was created with an empty SMS verification Code.',
    'missing-verification-code',
  );

  /// Indicates that an invalid verification code was used in the verifyPhoneNumber request.
  static final FirebaseAuthError invalidVerificationCode = FirebaseAuthError._(
    17044,
    'The SMS verification code used to create the phone auth credential is invalid. Please resend the verification code SMS and be sure to use the verification code provided by the user.',
    'invalid-verification-code',
  );

  /// Indicates that the phone auth credential was created with an empty verification ID.
  static final FirebaseAuthError missingVerificationID = FirebaseAuthError._(
    17045,
    'The phone auth credential was created with an empty verification ID.',
    'missing-verification-id',
  );

  /// Indicates that an invalid verification ID was used in the verifyPhoneNumber request.
  static final FirebaseAuthError invalidVerificationID = FirebaseAuthError._(
    17046,
    'The verification ID used to create the phone auth credential is invalid.',
    'invalid-verification-id',
  );

  /// Indicates that the APNS device token is missing in the verifyClient request.
  static final FirebaseAuthError missingAppCredential = FirebaseAuthError._(
    17047,
    'The phone verification request is missing an APNs Device token. Firebase Auth automatically detects APNs Device Tokens, however, if method swizzling is disabled, the APNs token must be set via the APNSToken property on FIRAuth or by calling setAPNSToken:type on FIRAuth.',
    'missing-app-credential',
  );

  /// Indicates that an invalid APNS device token was used in the verifyClient request.
  static final FirebaseAuthError invalidAppCredential = FirebaseAuthError._(
    17048,
    'The APNs device token provided is either incorrect or does not match the private certificate uploaded to the Firebase Console.',
    'invalid-app-credential',
  );

  /// Indicates that the SMS code has expired.
  static final FirebaseAuthError sessionExpired = FirebaseAuthError._(
    17051,
    'The SMS code has expired. Please re-send the verification code to try again.',
    'session-expired',
  );

  /// Indicates that the quota of SMS messages for a given project has been exceeded.
  static final FirebaseAuthError quotaExceeded = FirebaseAuthError._(
    17052,
    'The phone verification quota for this project has been exceeded.',
    'quota-exceeded',
  );

  /// Indicates that the APNs device token could not be obtained. The app may not have set up remote notification correctly, or may fail to forward the APNs device token to FIRAuth if app delegate swizzling is disabled.
  static final FirebaseAuthError missingAppToken = FirebaseAuthError._(
    17053,
    'There seems to be a problem with your project\'s Firebase phone number authentication set-up, please make sure to follow the instructions found at https://firebase.google.com/docs/auth/ios/phone-auth',
    'missing-app-token',
  );

  /// Indicates that the app fails to forward remote notification to FIRAuth.
  static final FirebaseAuthError notificationNotForwarded = FirebaseAuthError._(
    17054,
    'If app delegate swizzling is disabled, remote notifications received by UIApplicationDelegate need to be forwarded to FIRAuth\'s canHandleNotificaton: method.',
    'notification-not-forwarded',
  );

  /// Indicates that the app could not be verified by Firebase during phone number authentication.
  static final FirebaseAuthError appNotVerified = FirebaseAuthError._(
    17055,
    'Firebase could not retrieve the silent push notification and therefore could not verify your app. Ensure that you configured your app correctly to receive push notifications.',
    'app-not-verified',
  );

  /// Indicates that the reCAPTCHA token is not valid.
  static final FirebaseAuthError captchaCheckFailed = FirebaseAuthError._(
    17056,
    'The reCAPTCHA response token provided is either invalid, expired or already',
    'captcha-check-failed',
  );

  /// Indicates that an attempt was made to present a new web context while one was already being presented.
  static final FirebaseAuthError webContextAlreadyPresented =
      FirebaseAuthError._(
    17057,
    'User interaction is still ongoing, another view cannot be presented.',
    'web-context-already-presented',
  );

  /// Indicates that the URL presentation was cancelled prematurely by the user.
  static final FirebaseAuthError webContextCancelled = FirebaseAuthError._(
    17058,
    'The interaction was cancelled by the user.',
    'web-context-cancelled',
  );

  /// Indicates a general failure during the app verification flow.
  static final FirebaseAuthError appVerificationUserInteractionFailure =
      FirebaseAuthError._(
    17059,
    'The app verification process has failed, print and inspect the error details for more information',
    'app-verification-failed',
  );

  /// Indicates that the clientID used to invoke a web flow is invalid.
  static final FirebaseAuthError invalidClientID = FirebaseAuthError._(
    17060,
    'The OAuth client ID provided is either invalid or does not match the specified API key.',
    'invalid-client-id',
  );

  /// Indicates that a network request within a SFSafariViewController or WKWebView failed.
  static final FirebaseAuthError webNetworkRequestFailed = FirebaseAuthError._(
    17061,
    'null',
    'web-network-request-failed',
  );

  /// Indicates that an internal error occurred within a SFSafariViewController or WKWebView.
  static final FirebaseAuthError webInternalError = FirebaseAuthError._(
    17062,
    'An internal error has occurred within the SFSafariViewController or WKWebView.',
    'web-internal-error',
  );

  /// Indicates a general failure during a web sign-in flow.
  static final FirebaseAuthError webSignInUserInteractionFailure =
      FirebaseAuthError._(
    17063,
    'null',
    'web-user-interaction-failure',
  );

  /// Indicates that the local player was not authenticated prior to attempting Game Center signin.
  static final FirebaseAuthError localPlayerNotAuthenticated =
      FirebaseAuthError._(
    17066,
    'The local player is not authenticated. Please log the local player in to Game Center.',
    'local-player-not-authenticated',
  );

  /// Indicates that a non-null user was expected as an argmument to the operation but a null user was provided.
  static final FirebaseAuthError nullUser = FirebaseAuthError._(
    17067,
    'A null user object was provided as the argument for an operation which requires a non-null user object.',
    'null-user',
  );

  /// Indicates that a Firebase Dynamic Link is not activated.
  static final FirebaseAuthError dynamicLinkNotActivated = FirebaseAuthError._(
    17068,
    'Please activate Dynamic Links in the Firebase Console and agree to the terms and conditions.',
    'dynamic-link-not-activated',
  );

  /// Represents the error code for when the given provider id for a web operation is invalid.
  static final FirebaseAuthError invalidProviderID = FirebaseAuthError._(
    17071,
    'The provider ID provided for the attempted web operation is invalid.',
    'invalid-provider-id',
  );

  /// Indicates that the Firebase Dynamic Link domain used is either not configured or is unauthorized for the current project.
  static final FirebaseAuthError invalidDynamicLinkDomain = FirebaseAuthError._(
    17074,
    'The Firebase Dynamic Link domain used is either not configured or is unauthorized for the current project.',
    'invalid-dynamic-link-domain',
  );

  /// Indicates that the credential is rejected because it's misformed or mismatching.
  static final FirebaseAuthError rejectedCredential = FirebaseAuthError._(
    17075,
    'The request contains malformed or mismatching credentials.',
    'rejected-credential',
  );

  /// Indicates that the GameKit framework is not linked prior to attempting Game Center signin.
  static final FirebaseAuthError gameKitNotLinked = FirebaseAuthError._(
    17076,
    'The GameKit framework is not linked. Please turn on the Game Center capability.',
    'game-kit-not-linked',
  );

  /// Indicates that the nonce is missing or invalid.
  static final FirebaseAuthError missingOrInvalidNonce = FirebaseAuthError._(
    17094,
    'The request contains malformed or mismatched credentials.',
    'missing-or-invalid-nonce',
  );

  /// Indicates the email used to attempt a sign up is already in use.
  static final FirebaseAuthError emailExists = FirebaseAuthError._(
    17992,
    'The email address is already in use, try to login.',
    'email-exists',
  );

  /// Indicates an error for when the client identifier is missing.
  static final FirebaseAuthError missingClientIdentifier = FirebaseAuthError._(
    17993,
    'The request does not contain any client identifier.',
    'missing-client-identifier',
  );

  /// Indicates an error occurred while attempting to access the keychain.
  static final FirebaseAuthError keychainError = FirebaseAuthError._(
    17995,
    'An error occurred when accessing the keychain. The @c NSLocalizedFailureReasonErrorKey field in the @c NSError.userInfo dictionary will contain more information about the error encountered',
    'keychain-error',
  );

  /// Indicates an internal error occurred.
  static final FirebaseAuthError internalError = FirebaseAuthError._(
    17999,
    'An internal error has occurred, print and inspect the error details for more information.',
    'internal-error',
  );

  /// Raised when a JWT fails to parse correctly. May be accompanied by an underlying error describing which step of the JWT parsing process failed.
  static final FirebaseAuthError malformedJWT = FirebaseAuthError._(
    18000,
    'Failed to parse JWT. Check the userInfo dictionary for the full token.',
    'malformed-jwt',
  );

  @override
  String toString() => 'FirebaseAuthError($code, $message)';
}

class FirebaseAuthCredentialAlreadyInUseError extends FirebaseAuthError {
  FirebaseAuthCredentialAlreadyInUseError(this.credential, [this.email])
      : super._(
          17025,
          'This credential is already associated with a different user account.',
          'credential-already-in-use',
        );

  final AuthCredential credential;
  final String? email;
}
