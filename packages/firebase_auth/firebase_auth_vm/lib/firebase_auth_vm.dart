library firebase_auth_vm;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart';
import 'package:_firebase_internal_vm/_firebase_internal_vm.dart';
import 'package:firebase_auth_vm/src/util/recaptcha_token/recaptcha_token.dart';
import 'package:firebase_core_vm/firebase_core_vm.dart';
import 'package:firebase_core_vm/platform_dependencies.dart';
import 'package:googleapis/identitytoolkit/v3.dart' as gitkit;
import 'package:googleapis/identitytoolkit/v3.dart';
// ignore: implementation_imports
import 'package:googleapis/src/user_agent.dart' as gitkit;
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

export 'package:firebase_auth_vm/src/util/recaptcha_token/recaptcha_token.dart'
    show RecaptchaToken, UrlPresenter;

part 'src/auth_providers.dart';
part 'src/auth_result.dart';
part 'src/data/firebase_auth_api.dart';
part 'src/data/secure_token_api.dart';
part 'src/data/secure_token_service.dart';
part 'src/data/user_storage.dart';
part 'src/firebase_auth.dart';
part 'src/firebase_user.dart';
part 'src/models/action_code_info.dart';
part 'src/models/action_code_settings.dart';
part 'src/models/auth_credential.dart';
part 'src/models/auth_operation_type.dart';
part 'src/models/oob_code_type.dart';
part 'src/models/provider_type.dart';
part 'src/models/secure_token.dart';
part 'src/models/sign_in_with_game_center_request.dart';
part 'src/models/user.dart';
part 'src/models/user_update_info.dart';
part 'src/util/api_key_client.dart';
part 'src/util/errors.dart';
part 'src/util/extensions.dart';
part 'src/util/sequential_runner.dart';
part 'src/util/web_utils.dart';
