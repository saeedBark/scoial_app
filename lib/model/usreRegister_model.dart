

class UserModel{
  String name ;
  String email;
  String phone;
  String uid;
  bool isEmailVerified;
  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uid,
    this.isEmailVerified
});
  UserModel.formjson(Map<String , dynamic> json){
    name = json['name'];
    email =json['email'];
    phone = json['phone'];
    uid = json['uid'];
    isEmailVerified =json['isEmailVerified'];
  }

  Map<String , dynamic> toMap(){
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uid' : uid,
      'isEmailVerified' : isEmailVerified,
    };
  }
}