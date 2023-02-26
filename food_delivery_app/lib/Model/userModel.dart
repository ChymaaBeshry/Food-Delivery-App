class UserModel{
  String uid;
  String userName;
  String userEmail;
  String userPassword;
  String userPhone;
  String userAddress;
  bool isEmailVerification;

  UserModel({
    required this.uid,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.userPhone,
    required this.userAddress,
    required this.isEmailVerification
  });

  factory UserModel.fromJson(Map<String,dynamic> data){
    return UserModel(
        uid: data["uid"],
        userName: data["userName"],
        userEmail: data["userEmail"],
        userPassword: "",
        userPhone:data["userPhone"],
        userAddress:data["userAddress"],
        isEmailVerification:data["isEmailVerification"],
    );

  }
 static Map<String,dynamic> toJson({
    required String uid,
    required String userEmail,
    required String userPhone,
    required String userAddress,
    required String userName,
    required bool isEmailVerification
    }){
    return {
      "uid": uid,
      "userEmail": userEmail,
      "userPhone": userPhone,
      "userAddress": userAddress,
      "userName": userName,
      "isEmailVerification":isEmailVerification
    };
    }



  @override
  String toString() {
    return "($uid ,$userName,$userEmail ,$userPassword ,$userPhone .$userAddress )";
  }
}