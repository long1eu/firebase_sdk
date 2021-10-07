// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_auth_vm/firebase_auth_vm.dart';
import 'package:firebase_core_vm/firebase_core_vm.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  static const String title = 'SignInPage';

  @override
  State<StatefulWidget> createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  // Example code for sign out.
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SignInPage.title),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return TextButton(
              onPressed: () async {
                await GoogleSignIn().signOut();
                final FirebaseUser? user = FirebaseAuth.instance.currentUser;
                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No one has signed in.')));
                  return;
                }
                await _signOut();
                final String uid = user.uid;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('$uid has successfully signed out.'),
                ));
              },
              child: const Text('Sign out'),
            );
          })
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return ListView(
          padding: const EdgeInsets.all(16.0),
          scrollDirection: Axis.vertical,
          children: const <Widget>[
            _EmailPasswordForm(),
            // todo: implement on web and desktop
            if (kIsMobile) _EmailLinkSignInSection(),
            _AnonymouslySignInSection(),
            _GoogleSignInSection(),
            _PhoneSignInSection(),
            _OtherProvidersSignInSection(),
          ],
        );
      }),
    );
  }
}

class _EmailPasswordForm extends StatefulWidget {
  const _EmailPasswordForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool? _success;
  String? _userEmail;

  // Example code of how to sign in with email and password.
  Future<void> _signInWithEmailAndPassword() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final AuthResult authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = authResult.user;

    setState(() {
      _success = true;
      _userEmail = user.email;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: const Text('Test sign in with email and password'),
          ),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _signInWithEmailAndPassword();
                }
              },
              child: const Text('Submit'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _success == null
                  ? ''
                  : _success!
                      ? 'Successfully signed in $_userEmail'
                      : 'Sign in failed',
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _EmailLinkSignInSection extends StatefulWidget {
  const _EmailLinkSignInSection({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmailLinkSignInSectionState();
}

class _EmailLinkSignInSectionState extends State<_EmailLinkSignInSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  bool? _success;
  late String _userEmail;
  String? _userId;

  @override
  void initState() {
    super.initState();
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: _retrieveDynamicLink,
      onError: _retrieveDynamicLinkError,
    );
    FirebaseDynamicLinks.instance.getInitialLink().then(_retrieveDynamicLink);
  }

  Future<void> _retrieveDynamicLink(PendingDynamicLinkData? data) async {
    final Uri? link = data?.link;
    if (link != null) {
      final AuthResult authResult =
          await FirebaseAuth.instance.signInWithEmailAndLink(
        email: _userEmail,
        link: link.toString(),
      );
      final FirebaseUser user = authResult.user;
      setState(() {
        _userId = user.uid;
        _success = true;
      });
    }
  }

  Future<void> _signInWithEmailAndLink() async {
    _userEmail = _emailController.text;

    return FirebaseAuth.instance.sendSignInWithEmailLink(
      _userEmail,
      ActionCodeSettings(
        continueUrl: 'https://flutter-sdk.firebaseapp.com',
        handleCodeInApp: true,
        iOSBundleId: 'io.flutter.plugins.firebaseAuthExample',
        androidPackageName: 'io.flutter.plugins.firebaseauthexample',
        androidInstallIfNotAvailable: true,
        androidMinimumVersion: '1',
      ),
    );
  }

  Future<void> _retrieveDynamicLinkError(OnLinkErrorException error) async {
    print(error);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: const Text('Test sign in with email and link'),
          ),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email.';
              }
              return null;
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _signInWithEmailAndLink();
                }
              },
              child: const Text('Submit'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _success == null
                  ? ''
                  : _success!
                      ? 'Successfully signed in, uid: $_userId'
                      : 'Sign in failed',
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _AnonymouslySignInSection extends StatefulWidget {
  const _AnonymouslySignInSection({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnonymouslySignInSectionState();
}

class _AnonymouslySignInSectionState extends State<_AnonymouslySignInSection> {
  bool? _success;
  String? _userID;

  // Example code of how to sign in anonymously.
  Future<void> _signInAnonymously() async {
    final AuthResult authResult =
        await FirebaseAuth.instance.signInAnonymously();
    final FirebaseUser user = authResult.user;

    assert(user.isAnonymous);
    assert(!user.isEmailVerified);
    assert(user.providerData.isEmpty);

    final FirebaseUser? currentUser = FirebaseAuth.instance.currentUser;
    assert(user.uid == currentUser!.uid);
    setState(() {
      _success = true;
      _userID = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: const Text('Test sign in anonymously'),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: _signInAnonymously,
            child: const Text('Sign in anonymously'),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _success == null
                ? ''
                : _success!
                    ? 'Successfully signed in, uid: $_userID'
                    : 'Sign in failed',
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}

class _GoogleSignInSection extends StatefulWidget {
  const _GoogleSignInSection({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GoogleSignInSectionState();
}

class _GoogleSignInSectionState extends State<_GoogleSignInSection> {
  bool? _success;
  String? _userID;

  // Example code of how to sign in with google.
  Future<void> _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth == null) {
      return;
    }

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken!, idToken: googleAuth.idToken!);
    final AuthResult authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(user.email != null);
    assert(!user.isAnonymous);

    final FirebaseUser? currentUser = FirebaseAuth.instance.currentUser;
    assert(user.uid == currentUser?.uid);
    setState(() {
      _success = true;
      _userID = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: const Text('Test sign in with Google'),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: _signInWithGoogle,
            child: const Text('Sign in with Google'),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _success == null
                ? ''
                : _success!
                    ? 'Successfully signed in, uid: $_userID'
                    : 'Sign in failed',
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}

class _PhoneSignInSection extends StatefulWidget {
  const _PhoneSignInSection({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PhoneSignInSectionState();
}

class _PhoneSignInSectionState extends State<_PhoneSignInSection> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  String _message = '';
  late String _verificationId;

  // Example code of how to verify phone number
  Future<void> _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });

    try {
      final String verificationId = await FirebaseAuth.instance
          .verifyPhoneNumber(_phoneNumberController.text);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please check your phone for the verification code.'),
      ));
      setState(() {
        _verificationId = verificationId;
      });
    } on FirebaseAuthError catch (e) {
      setState(() {
        _message =
            'Phone number verification failed. Code: ${e.code}. Message: ${e.message}';
      });
    }
  }

  // Example code of how to sign in with phone.
  Future<void> _signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        verificationCode: _smsController.text.trim(),
      );
      final AuthResult authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;
      final FirebaseUser? currentUser = FirebaseAuth.instance.currentUser;
      assert(user.uid == currentUser?.uid);
      setState(() {
        _message = 'Successfully signed in, uid: ${user.uid}';
      });
    } on FirebaseAuthError catch (e) {
      setState(() => _message = e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: const Text('Test sign in with phone number'),
        ),
        TextFormField(
          controller: _phoneNumberController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
              labelText: 'Phone number (+x xxx-xxx-xxxx)'),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Phone number (+x xxx-xxx-xxxx)';
            }
            return null;
          },
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: _verifyPhoneNumber,
            child: const Text('Verify phone number'),
          ),
        ),
        TextField(
          controller: _smsController,
          decoration: const InputDecoration(labelText: 'Verification code'),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: _signInWithPhoneNumber,
            child: const Text('Sign in with phone number'),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _message,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}

class _OtherProvidersSignInSection extends StatefulWidget {
  const _OtherProvidersSignInSection({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OtherProvidersSignInSectionState();
}

class _OtherProvidersSignInSectionState
    extends State<_OtherProvidersSignInSection> {
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _tokenSecretController = TextEditingController();

  String _message = '';
  int _selection = 0;
  bool _showAuthSecretTextField = false;

  void _handleRadioButtonSelected(int? value) {
    setState(() {
      _selection = value!;
      if (_selection == 2) {
        _showAuthSecretTextField = true;
      } else {
        _showAuthSecretTextField = false;
      }
    });
  }

  void _signInWithOtherProvider() {
    switch (_selection) {
      case 0:
        _signInWithGithub();
        break;
      case 1:
        _signInWithFacebook();
        break;
      case 2:
        _signInWithTwitter();
        break;
      default:
    }
  }

  // Example code of how to sign in with Github.
  Future<void> _signInWithGithub() async {
    final AuthCredential credential =
        GithubAuthProvider.credential(_tokenController.text);
    final AuthResult authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final FirebaseUser _user = authResult.user;
    assert(_user.email != null);
    assert(_user.displayName != null);
    assert(!_user.isAnonymous);

    final FirebaseUser? currentUser = FirebaseAuth.instance.currentUser;
    assert(_user.uid == currentUser?.uid);
    setState(() {
      _message = 'Successfully signed in with Github. ${_user.uid}';
    });
  }

  // Example code of how to sign in with Facebook.
  Future<void> _signInWithFacebook() async {
    final AuthCredential credential =
        FacebookAuthProvider.credential(_tokenController.text);
    final AuthResult authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);

    final FirebaseUser? currentUser = FirebaseAuth.instance.currentUser;
    assert(user.uid == currentUser?.uid);
    setState(() {
      _message = 'Successfully signed in with Facebook. ${user.uid}';
    });
  }

  // Example code of how to sign in with Twitter.
  Future<void> _signInWithTwitter() async {
    final AuthCredential credential = TwitterAuthProvider.credential(
        authToken: _tokenController.text,
        authTokenSecret: _tokenSecretController.text);
    final AuthResult authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);

    final FirebaseUser? currentUser = FirebaseAuth.instance.currentUser;
    assert(user.uid == currentUser?.uid);
    setState(() {
      _message = 'Successfully signed in with Twitter. ${user.uid}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: const Text(
              'Test other providers authentication. (We do not provide an API to obtain the token for below providers. Please use a third party service to obtain token for below providers.)'),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio<int>(
                value: 0,
                groupValue: _selection,
                onChanged: _handleRadioButtonSelected,
              ),
              const Text(
                'Github',
                style: TextStyle(fontSize: 16.0),
              ),
              Radio<int>(
                value: 1,
                groupValue: _selection,
                onChanged: _handleRadioButtonSelected,
              ),
              const Text(
                'Facebook',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Radio<int>(
                value: 2,
                groupValue: _selection,
                onChanged: _handleRadioButtonSelected,
              ),
              const Text(
                'Twitter',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
        TextField(
          controller: _tokenController,
          decoration:
              const InputDecoration(labelText: 'Enter provider\'s token'),
        ),
        Container(
          child: _showAuthSecretTextField
              ? TextField(
                  controller: _tokenSecretController,
                  decoration: const InputDecoration(
                      labelText: 'Enter provider\'s authTokenSecret'),
                )
              : null,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () async {
              _signInWithOtherProvider();
            },
            child: const Text('Sign in'),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _message,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}
