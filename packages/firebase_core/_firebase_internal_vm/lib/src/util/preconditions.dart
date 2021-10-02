// File created by
// Lung Razvan <long1eu>
// on 16/09/2018

void checkState(bool condition, Object message) {
  if (!condition) {
    throw StateError('$message');
  }
}

T checkNotNull<T>(T object, [String? message]) {
  if (object == null) {
    throw ArgumentError('$message ${T.toString()}');
  } else {
    return object;
  }
}

String checkNotEmpty(String? value, String message) {
  if (value == null || value.isEmpty) {
    throw ArgumentError(message);
  } else {
    return value;
  }
}

/// Ensures the truth of an expression involving one or more parameters to the
/// calling method.
void checkArgument(bool condition, String errorMessage) {
  if (!condition) {
    throw ArgumentError(errorMessage);
  }
}
