import 'package:flutter/material.dart';
import 'package:lc/Controllers/AppointmentController.dart';
import 'package:lc/Controllers/AuthenticationController.dart';
import 'package:lc/Utils/AppColors.dart';
import 'package:lc/Utils/InputFields.dart';
import 'package:lc/Utils/MySlivers.dart';
import 'package:lc/Views/DetaislView.dart';
import 'package:lc/Utils/TextStyles.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchConroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<AppointmentController, AuthenticationController>(
        builder: (context, aptCtrl, authCtrl, child) {
      return Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: RefreshIndicator(
              onRefresh: () async {
                aptCtrl.GetAllAppointment();
              },
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  MySliverAppBar(context,
                      title: authCtrl.profileLoad
                          ? "-"
                          : authCtrl.fullname.toString(),
                      image: authCtrl.image ?? "",
                      controller: searchConroller, onChanged: (value) {
                    aptCtrl.search(value);
                  }, onPressed: () {
                    showSheet(context);
                  }),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverAppBarDelegate(
                      maxHeight: 50,
                      minHeight: 50,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: secondarywhite,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          separatorBuilder: (_, i) => const SizedBox(width: 12),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: aptCtrl.priorityList.length,
                          itemBuilder: (_, i) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ShowColor(status: aptCtrl.priorityList[i]),
                              ),
                              child: InkWell(
                                child: Row(
                                  children: [
                                    aptCtrl.priority == aptCtrl.priorityList[i]
                                        ? const Icon(
                                            Icons.check,
                                            color: scaffoldbackgroundcolor,
                                            size: 20,
                                          )
                                        : const SizedBox(),
                                    Gap(w: aptCtrl.priority == aptCtrl.priorityList[i] ? 5.0 : 0.0),
                                    Text(aptCtrl.priorityList[i], style: TxtStls.wstl14),
                                  ],
                                ),
                                onTap: () {
                                  aptCtrl.updatePriority(value: aptCtrl.priorityList[i]);
                                  aptCtrl.FilterList(priority: aptCtrl.priorityList[i],AptStatus: aptCtrl.aptStatus,date: aptCtrl.filterDateController.text);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverAppBarDelegate(
                      maxHeight: 50,
                      minHeight: 50,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal:10,vertical: 10),
                        color: secondarywhite,
                        child: Text("Total Appointments : ${aptCtrl.appointmentList.length}",style: TxtStls.stl14,)
                      ),
                    ),
                  ),
                  SliverBox(
                      h: 10.0,
                      child: aptCtrl.getAptLoad
                          ? const LinearProgressIndicator(color: savebtncolor)
                          : aptCtrl.appointmentList.isEmpty
                              ? Text("No Appointments Found",
                                  style: TxtStls.stl16)
                              : const SizedBox.shrink()),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: aptCtrl.appointmentList.length,
                        (BuildContext context, int i) {
                      var data = aptCtrl.appointmentList[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Material(
                          color: Colors.transparent,
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: hintcolor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            leading: Hero(
                              tag: i,
                              child: Image.network(
                                data.image.toString(),
                                width: 50,
                                height: 100,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${data.userlinkid!.firstName} ${data.userlinkid!.lastName}",
                                    style: TxtStls.stl14),
                                Container(
                                  height: 6,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ShowColor(status: data.priortyofVisit),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Gap(h: 4.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data.userlinkid!.phone.toString(),
                                        style: TxtStls.stl14),
                                    Row(
                                      children: [
                                        Text("Action : ", style: TxtStls.stl14),
                                        Text(data.action==null||data.action==""?"Pending":data.action.toString(), style: TxtStls.stl14),
                                      ],
                                    )
                                  ],
                                ),
                                Gap(h: 4.0),
                                Text(data.natureofWork.toString(),
                                    style: TxtStls.stl14),
                                Gap(h: 4.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex:4,
                                      child: Text(data.createdDate.toString(), style: TxtStls.stl14),),
                                    Gap(w: 5.0),
                                    Flexible(
                                      flex:6,
                                      child: Row(
                                        children: [
                                          Text("Status : ", style: TxtStls.stl14),
                                          Flexible(child: Text(data.aptStatus.toString(), style: TxtStls.stl14)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DetailsView(
                                          tag: i,
                                          appointmentModel: data,
                                        )),
                              );
                            },
                          ),
                        ),
                      );
                    }),
                  )
                ],
              )),
        ),
      );
    });
  }
}

ShowColor({status}) {
  if (status == "All") {
    return hintcolor;
  } else if (status == "Emergency") {
    return onprimaryhrcolor;
  } else if (status == "Priority") {
    return savebtncolor;
  } else if (status == "General") {
    return primarycolor;
  } else {
    return dayshrcolor;
  }
}

showSheet(context) {
  showModalBottomSheet(
    isDismissible: true,
    shape: ShapeBorder.lerp(
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      0.5,
    ),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return FilterSheet(context);
    },
  );
}

Widget FilterSheet(context) {
  return Consumer<AppointmentController>(builder: (context, aptCtrl, child) {
    return DraggableScrollableSheet(
      maxChildSize: 0.8,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(h: 10.0),
                DobField(context,controller: aptCtrl.filterDateController,labelText: "Select Date",hintText: "DD/MM/YYYY",onPressed: (){
                  aptCtrl.filterDateController.clear();
                }),
                Gap(h: 10.0),
                Wrap(
                  spacing: 5,
                  children: aptCtrl.aptStatusList
                      .map((e) => FilterChip(
                          selectedColor: savebtncolor,
                          showCheckmark: false,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          selected: aptCtrl.aptStatus.toString() == e.toString()
                              ? true
                              : false,
                          label: Text(e.toString(),
                              style:
                                  aptCtrl.aptStatus.toString() == e.toString()
                                      ? TxtStls.wstl14
                                      : TxtStls.stl13),
                          onSelected: (value) {
                            aptCtrl.updateAction(value: e);
                          }))
                      .toList(),
                ),
                Gap(h: 15.0),
                MyButton(context, load: false, title: "Apply Filter", onTap: (){
                  aptCtrl.FilterList(AptStatus: aptCtrl.aptStatus,priority: aptCtrl.priority,date: aptCtrl.filterDateController.text);
                  Navigator.pop(context);
                })
              ],
            ),
          ),
        );
      },
    );
  });
}
