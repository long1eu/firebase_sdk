part of firebase_auth_vm;

extension on Map<String, String> {
  String get query => keys.map((String key) => '$key=${this[key]}').join('&');
}
