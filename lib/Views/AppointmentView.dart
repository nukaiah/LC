import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lc/Controllers/AppointmentController.dart';
import 'package:lc/Controllers/CameraController.dart';
import 'package:lc/Models/PersonalModel.dart';
import 'package:lc/Utils/AppColors.dart';
import 'package:lc/Utils/InputFields.dart';
import 'package:lc/Utils/TextStyles.dart';
import 'package:provider/provider.dart';

class AppointmentView extends StatefulWidget {
  PersonalModel personData;
  AppointmentView({super.key,required this.personData});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      Provider.of<CameraOpenController>(context,listen: false).ClearFile();
    });
  }

  TextEditingController numberController = TextEditingController();
  String? natureWork;
  String? visitPriority;
  TextEditingController purposeController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<AppointmentController,CameraOpenController>(
      builder: (context,aptCtrl,camCtrl,child) {
        return Scaffold(
          appBar: AppBar(
            shadowColor: secondarywhite,
            surfaceTintColor: secondarywhite,
            backgroundColor: secondarywhite,
            foregroundColor: secondarywhite,
            elevation: 0.0,
            scrolledUnderElevation: 0.0,
            centerTitle: true,
            title: Text("Create New Appointment",style: TxtStls.stl16),
            leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new,color:primary),onPressed: (){Navigator.pop(context);},),
          ),
          body: SafeArea(
            child: Container(
              height: size.height,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    RowValue(title: "Full Name",value: "${widget.personData.firstName.toString()} ${widget.personData.lastName.toString()}"),
                    const SizedBox(height: 5),
                    RowValue(title: "Phone",value: widget.personData.phone.toString()),
                    const SizedBox(height: 5),
                    RowValue(title: "Aadhar",value: widget.personData.aadharId.toString()),
                    const SizedBox(height: 5),
                    RowValue(title: "Ration",value: widget.personData.rationId.toString()),
                    const SizedBox(height: 5),
                    RowValue(title: "Voter",value: widget.personData.voterId.toString()),
                    const SizedBox(height: 5),
                    RowValue(title: "Village",value: widget.personData.village.toString()),
                    const SizedBox(height: 5),
                    RowValue(title: "Constituency",value: widget.personData.constituencywithVoteId.toString()),
                    const SizedBox(height: 5),
                    RowValue(title: "Address",value: widget.personData.address.toString()),
                    const SizedBox(height: 10),
                    NumberField(labelText: "No. of Visitors Accompanied",hintText: "No. of Visitors Accompanied",controller:numberController),
                    const SizedBox(height: 15),
                    StatDropdown(value:natureWork,itemsList: ["Raithu Bhandu","Widow Pension","PH Penison","Old Age Pension","Raithu Bhima","Subcidy Loans","Society Loans","Double Bedroom House","Tractor Loan","Others"],labelText: "Nature Of Work / Type Of Work",hintText: "Nature Of Work / Type Of Work",onChanged: (value){
                      setState(() {
                        natureWork = value;
                      });
                    }),
                    const SizedBox(height: 15),
                    StatDropdown(value:visitPriority,itemsList: ["Emergency","Priority","Multiple Visits","General"],labelText: "Priority Of Visit",hintText: "Priority Of Visit",onChanged: (value){
                      setState(() {
                        visitPriority = value;
                      });
                    }),
                    const SizedBox(height: 10),
                    NameField(labelText: "Purpose Of Visit",hintText: "Purpose Of Visit",controller:purposeController),
                    const SizedBox(height: 10),
                    NameField(labelText: "Remarks",hintText: "Remarks",controller:remarkController),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundColor: dayshrcolor.withOpacity(0.25),
                          maxRadius: 30,
                          child: IconButton(iconSize:25,onPressed: (){
                            showCamera(context,from: "1");
                          }, icon: const Icon(Icons.photo)),
                        ),
                        CircleAvatar(
                          backgroundColor: dayshrcolor.withOpacity(0.25),
                          maxRadius: 30,
                          child: IconButton(iconSize:25,onPressed: (){
                            showCamera(context,from: "2");
                          }, icon: const Icon(Icons.file_present)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (camCtrl.imageFile == null) Text('No Image selected.',style: TxtStls.stl13,) else Image.file(camCtrl.imageFile,height: 150,width: size.width*0.4,),
                        Flexible(child: Text(camCtrl.file == null?'No File selected.':camCtrl.file.toString(),style: TxtStls.stl13,))
                      ],
                    )

                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(10),
            child: MyButton(
              context,
              load: aptCtrl.createLoad,
              title: "Book Appointment",
              onTap: () {
                aptCtrl.saveFormData(
                    context,
                    image:camCtrl.imageFile,
                    doc:camCtrl.file,
                    visitCount:numberController.text,
                    natureofWork:natureWork,
                    priortyofVisit:visitPriority,
                    visitPurpose:purposeController.text,
                    remarks:remarkController.text,
                    followupComments:"",
                    action:"",
                    userlinkid:widget.personData.sId
                );
              },
            ),
          ),
        );
      }
    );
  }
  Widget RowValue({title,value}){
    return Row(
      children: [
        Expanded(flex:1,child: Text(title,style: TxtStls.stl15)),
        Text(" : ",style: TxtStls.stl16),
        Expanded(flex:1,child: Text(value,style: TxtStls.stl14))
      ],
    );
  }
}


void showCamera(BuildContext context,{required from}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Consumer<CameraOpenController>(
        builder: (context,camCtrl,child) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: dayshrcolor.withOpacity(0.25),
                      maxRadius: 30,
                      child: IconButton(iconSize:25,onPressed: (){
                        camCtrl.selectImage(context,source: ImageSource.camera,from: from);
                      }, icon: const Icon(Icons.camera_alt)),
                    ),
                    Text("Camera",style: TxtStls.stl14)
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: dayshrcolor.withOpacity(0.25),
                      maxRadius: 30,
                      child: IconButton(iconSize:25,onPressed: (){
                        camCtrl.pickFile(context,allowedExtensions: from=="1"?['jpg', 'jpeg', 'png']:['pdf', 'doc', 'docx'],from: from);
                      }, icon: const Icon(Icons.folder)),
                    ),
                    Text("Gallery",style: TxtStls.stl14)
                  ],
                )

              ],
            ),
          );
        }
      );
    },
  );
}

