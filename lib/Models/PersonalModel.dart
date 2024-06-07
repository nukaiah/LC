class PersonalModel {
  String? sId;
  String? voterId;
  String? aadharId;
  String? rationId;
  String? phone;
  String? firstName;
  String? lastName;
  String? village;
  String? address;
  String? constituencywithVoteId;
  String? createdBy;
  String? type;
  int? iV;

  PersonalModel(
      {this.sId,
        this.voterId,
        this.aadharId,
        this.rationId,
        this.phone,
        this.firstName,
        this.lastName,
        this.village,
        this.address,
        this.constituencywithVoteId,
        this.createdBy,
        this.type,
        this.iV});

  PersonalModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    voterId = json['voterId'];
    aadharId = json['aadharId'];
    rationId = json['rationId'];
    phone = json['phone'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    village = json['village'];
    address = json['address'];
    constituencywithVoteId = json['ConstituencywithVoteId'];
    createdBy = json['createdBy'];
    type = json['type'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['voterId'] = this.voterId;
    data['aadharId'] = this.aadharId;
    data['rationId'] = this.rationId;
    data['phone'] = this.phone;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['village'] = this.village;
    data['address'] = this.address;
    data['ConstituencywithVoteId'] = this.constituencywithVoteId;
    data['createdBy'] = this.createdBy;
    data['type'] = this.type;
    data['__v'] = this.iV;
    return data;
  }
}
