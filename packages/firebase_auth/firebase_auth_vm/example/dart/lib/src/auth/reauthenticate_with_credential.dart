// File created by
// Lung Razvan <long1eu>
// on 12/12/2019

part of firebase_auth_example;

Future<AuthResult> _reauthenticateWithCredential(
    FirebaseAuthOption option) async {
  final FirebaseUser user = FirebaseAuth.instance.currentUser;
  await user.reload();

  final List<String> providers = user.providerData
      .map((UserInfo userInfo) => userInfo.providerId)
      .toList();
  final List<FirebaseAuthOption> options = <FirebaseAuthOption>[];
  for (String provider in providers) {
    switch (provider) {
      case ProviderType.password:
        options.add(FirebaseAuthOption.emailAndPasswordCredentials);
        break;
      case ProviderType.phone:
        options.add(FirebaseAuthOption.phoneCredentials);
        break;
      case ProviderType.google:
        options.add(FirebaseAuthOption.googleCredentials);
        break;
      case ProviderType.facebook:
        options.add(FirebaseAuthOption.facebookCredentials);
        break;
      case ProviderType.twitter:
        options.add(FirebaseAuthOption.twitterCredentials);
        break;
      case ProviderType.github:
        options.add(FirebaseAuthOption.githubCredentials);
        break;
    }
  }

  final MultipleOptions multipleOptions = MultipleOptions(
    question: 'Pick the provider you want to use ',
    optionsCount: options.length,
    builder: (int i) => options[i].name,
    validator: (String response) {
      final String value = response;
      final int option = int.tryParse(value);
      final int exitOption = options.length + 1;
      if (option == null || option.isNegative || option > exitOption) {
        return 'This time with a number between 1-$exitOption';
      }

      return null;
    },
  );

  final int optionIndex = await multipleOptions.show();
  if (optionIndex == -1) {
    close();
    return null;
  } else {
    console.clearScreen();

    AuthCredential credential;
    final FirebaseAuthOption option = options[optionIndex];
    switch (option) {
      case FirebaseAuthOption.emailAndPasswordCredentials:
        credential = await _getEmailPasswordAuthCredential();
        break;
      case FirebaseAuthOption.phoneCredentials:
        credential = await _getPhoneAuthCredential();
        break;
      case FirebaseAuthOption.googleCredentials:
        credential = await _getGoogleAuthCredential();
        break;
      case FirebaseAuthOption.facebookCredentials:
        credential = await _getFacebookAuthCredential();
        break;
      case FirebaseAuthOption.twitterCredentials:
        credential = await _getTwitterAuthCredential();
        break;
      case FirebaseAuthOption.githubCredentials:
        credential = await _getGithubAuthCredential();
        break;
    }

    final AuthResult result =
        await user.reauthenticateWithCredential(credential);

    console //
      ..clearScreen()
      ..println('You\'ve been reauthenticated succesfuly.')
      ..print('Press Enter to return.');

    await console.nextLine;
    console.clearScreen();
    return result;
  }
}
