import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lc/Controllers/AppointmentController.dart';
import 'package:lc/Controllers/CameraController.dart';
import 'package:lc/Utils/AppColors.dart';
import 'package:lc/Models/AppointmentModel.dart';
import 'package:lc/Utils/MySlivers.dart';
import 'package:lc/Utils/TextStyles.dart';
import 'package:lc/Views/HomeScreen.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class DetailsView extends StatefulWidget {
  var tag;
  AppointmentModel appointmentModel;
  DetailsView({super.key,required this.tag,required this.appointmentModel});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var aptData = widget.appointmentModel;
    var userData = widget.appointmentModel.userlinkid!;
    return Consumer2<AppointmentController,CameraOpenController>(
      builder: (context,aptCtrl,camCtrl,child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text("Appointment Details", style: TxtStls.stl16),
            centerTitle: false,
            elevation: 0.0,
          ),
          body: Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(tag:widget.tag,child: Image.network(aptData.image.toString(),height: 220,width: size.width,filterQuality: FilterQuality.high)),
                  Gap(h: 10.0),
                  Text("${userData.firstName}  ${userData.lastName} (${userData.phone.toString()})", style: TxtStls.stl15),
                  Gap(h: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(aptData.natureofWork.toString(),style: TxtStls.stl15),
                      Container(
                        height: 6,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ShowColor(status: aptData.priortyofVisit.toString()),
                        ),
                      ),
                    ],
                  ),
                  Gap(h: 10.0),
                  MyRow(title: "Aadhaar Id",value:userData.aadharId??""),
                  Gap(h: 10.0),
                  MyRow(title: "Voter Id",value:userData.voterId??""),
                  Gap(h: 10.0),
                  MyRow(title: "Food Id",value:userData.rationId??""),
                  Gap(h: 10.0),
                  MyRow(title: "Visitors",value:aptData.vistCount??""),
                  Gap(h: 10.0),
                  MyRow(title: "Constituency",value:userData.constituencywithVoteId??""),
                  Gap(h: 10.0),
                  MyRow(title: "Purpose",value:aptData.visitPurpose??""),
                  Gap(h: 15.0),
                  Row(
                    children: [
                      const Icon(Icons.location_on,size: 20,color: savebtncolor,),
                      const SizedBox(width: 15),
                      Flexible(child: Text(userData.address.toString(),style: TxtStls.stl15))
                    ],
                  ),
                  Gap(h: 15.0),
                  Row(
                    children: [
                      const Icon(Icons.edit,size: 20,),
                      const SizedBox(width: 15),
                      Flexible(child: Text(aptData.remarks.toString(),style: TxtStls.stl15))
                    ],
                  ),
                  Gap(h: 15.0),
                  Text("Attachment :",style: TxtStls.stl15),
                  Gap(h: 15.0),
                  IconButton(onPressed: (){
                    camCtrl.openDocument(docUrl: aptData.docs.toString());
                  }, icon: const Icon(Icons.edit_document,size: 40,color: onprimaryhrcolor))
                ],
              ),
            ),
          ),
          bottomNavigationBar:
              Container(height: 100, color: hintcolor.withOpacity(0.25),
              child: aptCtrl.updateLoad?Center(child: CircularProgressIndicator()):Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    onPressed: (){
                      aptCtrl.UpdateAppoinment(context,id:widget.appointmentModel.sId,action: "Cancelled");
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: onprimaryhrcolor,
                    minWidth: 100,
                    child: Text("Cancelled",style: TxtStls.wstl14)
                  ),
                  MaterialButton(
                      onPressed: (){
                        aptCtrl.UpdateAppoinment(context,id:widget.appointmentModel.sId,action: "On Hold");
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: weekshrcolor,
                      minWidth: 100,
                      child: Text("On Hold",style: TxtStls.wstl14)
                  ),
                  MaterialButton(
                      onPressed: (){
                        aptCtrl.UpdateAppoinment(context,id:widget.appointmentModel.sId,action: "Approved");
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: savebtncolor,
                      minWidth: 100,
                      child: Text("Approve",style: TxtStls.wstl14)
                  ),
                ],
              ),),
        );
      }
    );
  }
  Widget MyRow({title,value}){
    return Row(
      children: [
        Flexible(fit:FlexFit.tight,flex:1,child: Text(title,style: TxtStls.stl15)),
        Text(" :  ",style: TxtStls.stl16),
        Flexible(fit:FlexFit.tight,flex:2,child: Text(value,style: TxtStls.stl15)),
      ],
    );
  }
}
