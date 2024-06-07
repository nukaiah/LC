import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lc/Controllers/AuthenticationController.dart';
import 'package:lc/Utils/AppColors.dart';
import 'package:lc/Utils/InputFields.dart';
import 'package:lc/Utils/TextStyles.dart';
import 'package:provider/provider.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}


Widget SliverGap({h,w}){
  return SliverToBoxAdapter(
    child: SizedBox(height: h,width: w),
  );
}

Widget SliverBox({child,h}){
  return SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: h),
      child: child,
    ),
  );
}

Widget Gap({h,w}){
  return SizedBox(
    height: h,width: w,
  );
}

Widget MySliverAppBar(context,{title,bool isSearch = true,image,onChanged,controller,onPressed}){
  return SliverAppBar(
    shadowColor: secondarywhite,
    surfaceTintColor: secondarywhite,
    backgroundColor: secondarywhite,
    foregroundColor: secondarywhite,
    elevation: 0.0,
    scrolledUnderElevation: 0.0,
    actions: [
      CircleAvatar(backgroundImage: NetworkImage(image==null||image==""?"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSpAnV7Eqy1ajdV__BGRrAU9KkCa3aJGDly4funAkQzosa99R5KIOe4oFG4e_H3cNfgFw&usqp=CAU":image)),
      Gap(w: 10.0),
      IconButton(onPressed: (){
        showMyDialog(context);
      }, icon: const Icon(Icons.logout_outlined,color: primary))
    ],
    titleSpacing: 15,
    title: Text(title, style: TxtStls.stl16),
    expandedHeight: isSearch?120.0:60.0,
    floating: true,
    pinned: true,
    snap: true,
    stretch: true,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(isSearch?70.0:0.0),
      child: isSearch?Container(
        color: secondarywhite,
        padding: const EdgeInsets.symmetric(horizontal:10,vertical: 11),
        child:Row(
          children: [
            Expanded(child: SearchField(context,controller:controller,onChanged:onChanged)),
            Gap(w: 10.0),
            CircleAvatar(
              backgroundColor: scaffoldbackgroundcolor,
                child: IconButton(icon: const Icon(Icons.filter_list),onPressed: onPressed))
          ],
        ),
      ): Container(color: secondarywhite,),
    ),
    flexibleSpace: const FlexibleSpaceBar(
      stretchModes: [
        StretchMode.zoomBackground,
        StretchMode.blurBackground,
        StretchMode.fadeTitle
      ],
    ),
  );
}


Future<void> showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Consumer<AuthenticationController>(
        builder: (context,authCtrl,child) {
          return AlertDialog(
            title: Text("Are you sure want to logout?",style: TxtStls.stl16),
            actions: <Widget>[
              MaterialButton(
                color: onprimaryhrcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text('Cancel',style: TxtStls.wstl15,),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                color: savebtncolor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text('Logout',style: TxtStls.wstl15,),
                onPressed: (){
                  authCtrl.Logout(context);
                },
              ),
            ],
          );
        }
      );
    },
  );
}
