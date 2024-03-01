import 'dart:convert';

DocumentList documentListFromJson(String str) =>
    DocumentList.fromJson(json.decode(str));

String documentListToJson(DocumentList data) => json.encode(data.toJson());

class DocumentList {
  bool success;
  Result result;

  DocumentList({
    required this.success,
    required this.result,
  });

  factory DocumentList.fromJson(Map<String, dynamic> json) => DocumentList(
    success: json["success"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result.toJson(),
  };
}

class Result {
  List<Document> documents;

  Result({
    required this.documents,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    documents: List<Document>.from(
        json["documents"].map((x) => Document.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
  };
}

class Document {
  String name;
  String type;
  bool cameraOnly;
  String baseUrl;
  String relativeUrl;
  String signedUrl;
  DateTime expiresAt;

  Document({
    required this.name,
    required this.type,
    required this.cameraOnly,
    required this.baseUrl,
    required this.relativeUrl,
    required this.signedUrl,
    required this.expiresAt,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    name: json["name"],
    type: json["type"],
    cameraOnly: json["camera_only"],
    baseUrl: json["base_url"],
    relativeUrl: json["relative_url"],
    signedUrl: json["signed_url"],
    expiresAt: DateTime.parse(json["expires_at"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "camera_only": cameraOnly,
    "base_url": baseUrl,
    "relative_url": relativeUrl,
    "signed_url": signedUrl,
    "expires_at": expiresAt.toIso8601String(),
  };
}