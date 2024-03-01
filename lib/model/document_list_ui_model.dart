class DocumentsUiModel {
  String? name;
  String? type;
  bool? cameraOnly;
  String? baseUrl;
  String? relativeUrl;
  String? signedUrl;
  String? takenVideoPath;
  String? takenPicturePath;
  bool? isUploaded;
  bool? isUploadFailed;
  bool? isUploading;
  String? uploadPercentage;
  DocumentsUiModel(
      {this.name,
      this.type,
      this.cameraOnly,
      this.baseUrl,
      this.relativeUrl,
      this.signedUrl,
      this.takenPicturePath,
      this.takenVideoPath,
      this.isUploadFailed,
      this.isUploaded,
      this.isUploading,
      this.uploadPercentage});
}
