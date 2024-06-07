import 'package:flutter/material.dart';
import 'package:lc/Controllers/AppointmentController.dart';
import 'package:lc/Controllers/AuthenticationController.dart';
import 'package:lc/Utils/AppColors.dart';
import 'package:lc/Utils/MySlivers.dart';
import 'package:lc/Utils/TextStyles.dart';
import 'package:lc/Views/AppointmentView.dart';
import 'package:provider/provider.dart';

class PersonsView extends StatefulWidget {
  const PersonsView({super.key});

  @override
  State<PersonsView> createState() => _PersonsViewState();
}

class _PersonsViewState extends State<PersonsView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<AuthenticationController,AppointmentController>(
      builder: (context,authCtrl,aptCtrl,child) {
        return Container(
          height: size.height,
          width: size.width,
          child: RefreshIndicator(
            onRefresh: () async {
              aptCtrl.GetAllPersonals();
            },
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                MySliverAppBar(context,
                    title: authCtrl.profileLoad ? "-" : authCtrl.fullname.toString(),
                    image: authCtrl.image ?? "",
                    controller: searchController,
                    onChanged: (value){
                      aptCtrl.searchPerson(value);
                    }
                ),
                SliverBox(
                    h: 10.0,
                    child: aptCtrl.getPersonLoad?const LinearProgressIndicator(color: savebtncolor):aptCtrl.personalList.isEmpty?Text("No Persons Found",style: TxtStls.stl16):const SizedBox.shrink()
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: aptCtrl.personalList.length,
                          (BuildContext context, int i) {
                        var data = aptCtrl.personalList[i];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              side:  const BorderSide(color: hintcolor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text(
                                "${data.firstName} ${data.lastName}",
                                style: TxtStls.stl14),
                            subtitle: Text(data.phone.toString(),
                                style: TxtStls.stl14),
                            trailing: const Icon(Icons.calendar_month_outlined,color: primary,),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>AppointmentView(personData: data)));
                            },
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
