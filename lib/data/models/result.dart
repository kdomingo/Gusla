class Result {
  final dynamic data;
  final bool success;
  final String? message;

  Result._({this.data, this.message, this.success = false});
  Result.withData(dynamic data) : this._(data: data, success: true);
  Result.error(String message) : this._(message: message);
}
