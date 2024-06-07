import 'package:flutter/material.dart';
import 'package:lc/Controllers/AppointmentController.dart';
import 'package:lc/Controllers/AuthenticationController.dart';
import 'package:lc/Utils/TextStyles.dart';
import 'package:lc/Utils/Urls.dart';
import 'package:lc/Views/HomeScreen.dart';
import 'package:lc/Views/PersonsView.dart';
import 'package:provider/provider.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      ApiMethods.getKeys().then((value) {
        Provider.of<AuthenticationController>(context, listen: false).GetProfileData(UserId: ApiMethods.userId);
        final aptCtrl = Provider.of<AppointmentController>(context, listen: false);
        aptCtrl.GetAllAppointment();
        aptCtrl.GetAllPersonals();
      });
    });
  }
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedLabelStyle: TxtStls.stl15,
        unselectedLabelStyle: TxtStls.stl13,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded),label: "Appointments List"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined),label: "Book Appointment"),
        ],
        onTap: (value){
          index=value;
          setState(() {});
        },
      ),
    );
  }

  LoadBody(){
    if(index==0){
      return const HomeScreen();
    }
    else{
      return const PersonsView();
    }
  }
}
