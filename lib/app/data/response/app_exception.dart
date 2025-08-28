class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class DefaultException extends AppException {
  DefaultException([String? message]) : super(message, '');
}

class InternetException extends AppException {
  InternetException([String? message]) : super(message, 'Network Error: ');
}

class ForbidenException extends AppException {
  ForbidenException([String? message])
      : super(message, 'Authorization Failed: ');
}

class NotFoundException extends AppException {
  NotFoundException([String? message]) : super(message, 'Resource Not Found: ');
}

class RateLimitException extends AppException {
  RateLimitException([String? message])
      : super(message, 'Rate Limit Exceeded: ');
}

class RequestTimeOut extends AppException {
  RequestTimeOut([String? message]) : super(message, 'Request Timeout: ');
}

class InvalidUrl extends AppException {
  InvalidUrl([String? message]) : super(message, 'Invalid URL: ');
}

class FailedToFetch extends AppException {
  FailedToFetch([String? message]) : super(message, 'Request Failed: ');
}

class ServerUnavailableException extends AppException {
  ServerUnavailableException([String? message])
      : super(message, 'Server Unavailable: ');
}

class ValidationException extends AppException {
  ValidationException([String? message]) : super(message, 'Validation Error: ');
}
