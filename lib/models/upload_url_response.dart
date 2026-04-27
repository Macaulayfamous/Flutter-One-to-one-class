class UploadUrlResponse {
  final String message;
  final String uploadUrl;
  final String productId;
  final String? s3Key;

  UploadUrlResponse({
    required this.message,
    required this.uploadUrl,
    required this.productId,
    this.s3Key,
  });

  factory UploadUrlResponse.fromJson(Map<String, dynamic> json) {
    return UploadUrlResponse(
      message: json['message'] ?? '',
      uploadUrl: json['uploadUrl'] ?? '',
      productId: json['productId'] ?? '',
      s3Key: json['s3Key'],
    );
  }
}
