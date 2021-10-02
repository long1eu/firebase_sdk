library firebase_auth_example;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth_vm/firebase_auth_vm.dart';
import 'package:firebase_core_vm/firebase_core_vm.dart';
import 'package:firebase_core_vm/platform_dependencies.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:pedantic/pedantic.dart';
import 'package:uuid/uuid.dart';

import 'src/utils/email_validator.dart';
import 'src/utils/extensions.dart';
import 'src/utils/twitter_helper.dart';

part 'src/auth/action_code.dart';

part 'src/auth/action_code_info.dart';

part 'src/auth/create_custom_token.dart';

part 'src/auth/create_user.dart';

part 'src/auth/current_user.dart';

part 'src/auth/fetch_sign_in_methods.dart';

part 'src/auth/language_code.dart';

part 'src/auth/link_provider.dart';

part 'src/auth/reauthenticate_with_credential.dart';

part 'src/auth/send_email_verification.dart';

part 'src/auth/sign_in_anonymously.dart';

part 'src/auth/sign_in_with_credential.dart';

part 'src/auth/sign_in_with_custom_token.dart';

part 'src/auth/sign_in_with_email_and_link.dart';

part 'src/auth/sign_in_with_email_and_password.dart';

part 'src/auth/unlink_provider.dart';

part 'src/credentials/sing_in_with_credential.dart';

part 'src/initialize.dart';

part 'src/no_user.dart';

part 'src/options.dart';

part 'src/update/update_profile.dart';

part 'src/user.dart';

part 'src/utils/codes.dart';

part 'src/utils/console.dart';

part 'src/utils/device_code.dart';

part 'src/widgets/credential_getters.dart';

part 'src/widgets/get_email_and_password.dart';

part 'src/widgets/multiple_string_option.dart';

part 'src/widgets/option.dart';

part 'src/widgets/progress.dart';

part 'src/widgets/simple_selection_list_option.dart';

part 'src/widgets/single_string_option.dart';

final bool hasColor = stdout.supportsAnsiEscapes;

String getUserName(FirebaseUser user) {
  if (user.isAnonymous) {
    return 'Stranger';
  } else if (user.displayName == null) {
    if (user.email != null) {
      return user.email;
    } else if (user.phoneNumber != null) {
      return user.phoneNumber;
    }
  }

  return user.displayName;
}

void printTitle() {
  stdout //
    ..writeln('Firebase Dart SDK'.bold.cyan.reset)
    ..writeln('Firebase Authentication'.bold.yellow.reset)
    ..writeln();
}

void close() {
  console.clearScreen();
  exit(0);
}
