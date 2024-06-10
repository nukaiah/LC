import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lc/Controllers/AuthenticationController.dart';
import 'package:lc/Models/AppointmentModel.dart';
import 'package:lc/Models/PersonalModel.dart';
import 'package:lc/Utils/AppColors.dart';
import 'package:lc/Utils/Urls.dart';
import 'package:http/http.dart' as http;


class AppointmentController extends ChangeNotifier{

  List<AppointmentModel> _originalList = [];

  List<AppointmentModel> _appointmentList = [];
  List<AppointmentModel> get appointmentList =>[..._appointmentList];

  bool getAptLoad = false;

  Future<void> GetAllAppointment()async{
    try {
      getAptLoad = true;
      notifyListeners();
      final response = await ApiMethods.getMethod(endpoint: "appointments/getAll");
      if(response!=null){
        var aptData = response["data"];
        _originalList = aptData == null ? [] : List<AppointmentModel>.from(aptData.map((e) => AppointmentModel.fromJson(e)));
        _appointmentList = _originalList.where((element) => element.aptStatus!="Completed"&&element.aptStatus!="Cancelled").toList();

      }
      getAptLoad = false;
      notifyListeners();
    } on Exception {
      getAptLoad = false;
      notifyListeners();
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      _appointmentList = _originalList;
    } else {
      _appointmentList = _originalList.where((element) {
        final firstName = element.userlinkid!.firstName.toString().toLowerCase();
        final lastName = element.userlinkid!.lastName.toString().toLowerCase();
        final phone = element.userlinkid!.phone.toString().toLowerCase();
        final input = query.toLowerCase();
        return firstName.contains(input) || lastName.contains(input) || phone.contains(input);
      }).toList();
    }
    notifyListeners();
  }

  bool updateLoad = false;
  Future<void> UpdateAppoinment(context,{id,action})async{
    updateLoad  = true;
    notifyListeners();
    final response = await ApiMethods.postMethod(endpoint: "appointments/changeStatue", postJson: {
      "_id":id,
      "action":action
    });
    if(response!=null){
      ShowMessage(context,backgroundColor: savebtncolor,message: response["message"]);
    }
    else{
      ShowMessage(context,backgroundColor: savebtncolor,message:"Failed to Update");
    }
    updateLoad  = false;
    GetAllAppointment();
    notifyListeners();
  }

  List<PersonalModel> _originalList1 = [];

  List<PersonalModel> _personalList = [];
  List<PersonalModel> get personalList =>[..._personalList];

  bool getPersonLoad = false;

  Future<void> GetAllPersonals()async{
    try {
      getPersonLoad = true;
      notifyListeners();
      final response = await ApiMethods.getMethod(endpoint: "personal/getAll");
      if(response!=null){
        var aptData = response["data"];
        _originalList1 = aptData == null ? [] : List<PersonalModel>.from(aptData.map((e) => PersonalModel.fromJson(e)));
        _personalList = _originalList1;
      }
      getPersonLoad = false;
      notifyListeners();
    } on Exception {
      getPersonLoad = false;
      notifyListeners();
    }
  }

  void searchPerson(String query) {
    if (query.isEmpty) {
      _personalList = _originalList1;
    } else {
      _personalList = _originalList1.where((element) {
        final firstName = element.firstName.toString().toLowerCase();
        final lastName = element.lastName.toString().toLowerCase();
        final phone = element.phone.toString().toLowerCase();
        final input = query.toLowerCase();
        return firstName.contains(input) || lastName.contains(input) || phone.contains(input);
      }).toList();
    }
    notifyListeners();
  }

  bool createLoad = false;


  Future<void> saveFormData(context,{File?  image,File? doc,visitCount,natureofWork,priortyofVisit,visitPurpose,remarks,followupComments,action,userlinkid}) async {
    createLoad = true;
    notifyListeners();
    final uri = Uri.parse("https://node-mongo-seven.vercel.app/api/appointments/createApt");
    var request = http.MultipartRequest('POST', uri);
    request.fields['visitCount'] =visitCount;
    request.fields['natureofWork'] = natureofWork;
    request.fields['priortyofVisit'] = priortyofVisit;
    request.fields['visitPurpose'] = visitPurpose;
    request.fields['remarks'] = remarks;
    request.fields['followupComments'] = followupComments;
    request.fields['action'] = action;
    request.fields['userlinkid'] = userlinkid;
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }
    if (doc != null) {
      request.files.add(await http.MultipartFile.fromPath('doc', doc.path));
    }
    var response = await request.send();
    print(response.reasonPhrase);
    if (response.statusCode == 200) {
      GetAllAppointment();
      ShowMessage(context,backgroundColor: savebtncolor,message: "Appointment saved successfully");
    } else {
      ShowMessage(context,backgroundColor: onprimaryhrcolor,message: response.reasonPhrase.toString());
    }
    createLoad = false;
    notifyListeners();
  }

  void FilterList({priority, AptStatus, date}) {
    if (priority == "All" && AptStatus == "All" && date == "") {
      _appointmentList = _originalList;
    } else if (priority == "All" && date == "") {
      _appointmentList = _originalList
          .where((item) => item.aptStatus.toString() == AptStatus.toString())
          .toList();
    } else if (AptStatus == "All" && date == "") {
      _appointmentList = _originalList
          .where((item) => item.priortyofVisit.toString() == priority.toString())
          .toList();
    } else if (date == "") {
      _appointmentList = _originalList
          .where((item) =>
      item.aptStatus.toString() == AptStatus.toString() &&
          item.priortyofVisit.toString() == priority.toString())
          .toList();
    } else if (priority == "All" && AptStatus == "All") {
      _appointmentList = _originalList
          .where((item) => item.createdDate.toString() == date.toString())
          .toList();
    } else if (priority == "All") {
      _appointmentList = _originalList
          .where((item) =>
      item.aptStatus.toString() == AptStatus.toString() &&
          item.createdDate.toString() == date.toString())
          .toList();
    } else if (AptStatus == "All") {
      _appointmentList = _originalList
          .where((item) =>
      item.priortyofVisit.toString() == priority.toString() &&
          item.createdDate.toString() == date.toString())
          .toList();
    } else {
      _appointmentList = _originalList
          .where((item) =>
      item.aptStatus.toString() == AptStatus.toString() &&
          item.priortyofVisit.toString() == priority.toString() &&
          item.createdDate.toString() == date.toString())
          .toList();
    }
    notifyListeners();
  }



  var priority = "All";
  List priorityList = ["All","Emergency","Priority","Multiple Visits","General"];
  updatePriority({value}){
    priority = value;
    notifyListeners();
  }

  String aptStatus = "All";
  TextEditingController filterDateController = TextEditingController();
  List aptStatusList = ["All","On Hold","In Progress","Follow Up Required"];
  updateAction({value}){
    aptStatus = value;
    notifyListeners();
  }

}
