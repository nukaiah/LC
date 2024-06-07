class AppointmentModel {
  String? sId;
  String? createdDate;
  String? vistCount;
  String? natureofWork;
  String? priortyofVisit;
  String? visitPurpose;
  String? remarks;
  String? image;
  String? docs;
  String? aptId;
  String? aptStatus;
  String? ticketStatus;
  var followupDate;
  String? followupComments;
  String? action;
  Userlinkid? userlinkid;
  int? iV;

  AppointmentModel(
      {this.sId,
        this.createdDate,
        this.vistCount,
        this.natureofWork,
        this.priortyofVisit,
        this.visitPurpose,
        this.remarks,
        this.image,
        this.docs,
        this.aptId,
        this.aptStatus,
        this.ticketStatus,
        this.followupDate,
        this.followupComments,
        this.action,
        this.userlinkid,
        this.iV});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdDate = json['createdDate'];
    vistCount = json['vistCount'];
    natureofWork = json['natureofWork'];
    priortyofVisit = json['priortyofVisit'];
    visitPurpose = json['visitPurpose'];
    remarks = json['remarks'];
    image = json['image'];
    docs = json['docs'];
    aptId = json['aptId'];
    aptStatus = json['aptStatus'];
    ticketStatus = json['ticketStatus'];
    followupDate = json['followupDate'];
    followupComments = json['followupComments'];
    action = json['action'];
    userlinkid = json['userlinkid'] != null
        ? new Userlinkid.fromJson(json['userlinkid'])
        : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['createdDate'] = this.createdDate;
    data['vistCount'] = this.vistCount;
    data['natureofWork'] = this.natureofWork;
    data['priortyofVisit'] = this.priortyofVisit;
    data['visitPurpose'] = this.visitPurpose;
    data['remarks'] = this.remarks;
    data['image'] = this.image;
    data['docs'] = this.docs;
    data['aptId'] = this.aptId;
    data['aptStatus'] = this.aptStatus;
    data['ticketStatus'] = this.ticketStatus;
    data['followupDate'] = this.followupDate;
    data['followupComments'] = this.followupComments;
    data['action'] = this.action;
    if (this.userlinkid != null) {
      data['userlinkid'] = this.userlinkid!.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Userlinkid {
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

  Userlinkid(
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

  Userlinkid.fromJson(Map<String, dynamic> json) {
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
