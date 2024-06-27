import 'package:flutter/material.dart';
import 'package:lc/Controllers/AuthenticationController.dart';
import 'package:lc/Utils/AppColors.dart';
import 'package:lc/Utils/InputFields.dart';
import 'package:lc/Utils/MySlivers.dart';
import 'package:lc/Utils/TextStyles.dart';
import 'package:lc/Utils/Urls.dart';
import 'package:provider/provider.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      ApiMethods.getKeys().whenComplete(() {
        Provider.of<AuthenticationController>(context, listen: false).GetProfileData(UserId: ApiMethods.userId);
      });
    });
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  bool isVisible1 = true;
  bool isVisible2 = true;
  bool isVisible3 = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthenticationController>(
        builder: (context, authCtrl, child) {
      return Container(
        height: size.height,
        width: size.width,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              MySliverAppBar(context,
                  title:
                      authCtrl.profileLoad ? "-" : authCtrl.fullname.toString(),
                  image: authCtrl.image ?? "",
                  controller: searchController,
                  onChanged: (value) {}),
              SliverGap(h: 15.0,w: 0.0),
              SliverBox(
                h: 10.0,
                child: PasswordField(
                    controller: currentPasswordController,
                    labelText: "Current Password",
                    hintText: "Please Enter Current Password",
                    onPressed: () {
                      setState(() {
                        isVisible1 = !isVisible1;
                      });
                    },
                    isVisible: isVisible1),
              ),
              SliverGap(h: 15.0,w: 0.0),
              SliverBox(
                h: 10.0,
                child: PasswordField(
                    controller: newPasswordController,
                    labelText: "New Password",
                    hintText: "Please Enter New Password",
                    onPressed: () {
                      setState(() {
                        isVisible2 = !isVisible2;
                      });
                    },
                    isVisible: isVisible2),
              ),
              SliverGap(h: 15.0,w: 0.0),
              SliverBox(
                h: 10.0,
                child: TextFormField(
                  style: TxtStls.stl14,
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.visiblePassword,
                  textCapitalization: TextCapitalization.sentences,
                  obscureText: isVisible3,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.all(15),
                      labelText: "Re Enter New password",
                      labelStyle: TxtStls.stl15,
                      hintText: "Please Re Enter New password",
                      hintStyle: TxtStls.stl13,
                      fillColor: secondarywhite,
                      filled: true,
                      counterText: "",
                      suffixIcon: IconButton(
                        icon: Icon(isVisible3
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isVisible3 = !isVisible3;
                          });
                        },
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Re Enter NewPassword cannot be empty ";
                    }
                    if (value != newPasswordController.text) {
                      return "Passwords are not match";
                    }
                    return null;
                  },
                ),
              ),
              SliverGap(h: 15.0,w: 0.0),
              SliverBox(
                h: 10.0,
                child: MyButton(context, load: authCtrl.updateLoad, title: "Update Password", onTap:(){
                  if(_formKey.currentState!.validate()){
                    authCtrl.UpdatePassword(context,oldPassword: currentPasswordController.text.toString(),newPassword: newPasswordController.text.toString());
                  }
                })
              ),
            ],
          ),
        ),
      );
    });
  }
}

//Column(children: [
//                     Gap(h: 100.0),

//                     Gap(h: 10.0),

//                     Gap(h: 10.0),

//                     Gap(h: 10.0),
//                     MyButton(context, load: false, title: "Update Password", onTap: (){
//                       if(_formKey.currentState!.validate()){
//                         authCtrl.UpdatePassword(context,oldPassword: currentPasswordController.text.toString(),newPassword:newPasswordController.text.toString());
//                       }
//                     })
//                   ])
