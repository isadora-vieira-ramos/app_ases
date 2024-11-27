class RequestResponse{
  late int status;
  late String message;

  RequestResponse({required this.status, required this.message});

  factory RequestResponse.fromJson(Map<String, dynamic> json) {
    return RequestResponse(
      status: json['status'],
      message: json['message']
    );
  }
}