class ChatRequestModel {
  const ChatRequestModel({required this.message});

  final String message;

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
