class ResponseModel<T> {
  bool success = true;
  String message = "";
  T? data;
  DateTime? operationData = DateTime.now();
  int statusCode = 0;
  //ResponseData data = ResponseData();

  ResponseModel({
    this.success = true,
    this.message = "",
    this.data,
    this.operationData,
    this.statusCode = 0,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      success: json["Success"],
      message: json["Message"],
      //data: json["Data"],
      operationData: json["OperationData"] != null
          ? DateTime.parse(json["OperationData"])
          : null,
      statusCode: json["StatusCode"] ?? 0,
    );
  }
}

/*class ResponseData<T> {
  bool success = true;
  String message = "";
  T? data;

  ResponseData({
    this.success = true,
    this.message = "",
    this.data,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      success: json["Success"],
      message: json["Message"],
    );
  }
}*/