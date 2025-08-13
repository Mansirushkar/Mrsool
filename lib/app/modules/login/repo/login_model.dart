class LoginModel {
  int? code;
  String? message;
  int? iUserId;
  bool? bStatus;
  bool? bProfileComplete;
  String? vLanguage;
  bool? bNotification;
  bool? bNearbyOrder;
  bool? isCourier;
  String? userNo;
  String? userMode;

  LoginModel(
      {this.code,
      this.message,
      this.iUserId,
      this.bStatus,
      this.bProfileComplete,
      this.vLanguage,
      this.bNotification,
      this.bNearbyOrder,
      this.isCourier,
      this.userNo,
      this.userMode});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    iUserId = json['iUserId'];
    bStatus = json['bStatus'];
    bProfileComplete = json['bProfileComplete'];
    vLanguage = json['vLanguage'];
    bNotification = json['bNotification'];
    bNearbyOrder = json['bNearbyOrder'];
    isCourier = json['is_courier'];
    userNo = json['user_no'];
    userMode = json['user_mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['iUserId'] = this.iUserId;
    data['bStatus'] = this.bStatus;
    data['bProfileComplete'] = this.bProfileComplete;
    data['vLanguage'] = this.vLanguage;
    data['bNotification'] = this.bNotification;
    data['bNearbyOrder'] = this.bNearbyOrder;
    data['is_courier'] = this.isCourier;
    data['user_no'] = this.userNo;
    data['user_mode'] = this.userMode;
    return data;
  }
}
