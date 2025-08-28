import 'package:flutter/material.dart';
import 'package:khata_app/app/custom_widgets/customBottomSheet.dart';
import 'package:khata_app/app/custom_widgets/custom_app_bar.dart';
import 'package:khata_app/app/custom_widgets/month_widget.dart';
import 'package:khata_app/app/res/app_Strings.dart';
import 'package:khata_app/app/res/app_colors.dart';
import 'package:khata_app/app/res/app_text_styles.dart';
import 'package:khata_app/app/utils/app_routes/routes_name.dart';
import 'package:khata_app/app/utils/calender_utils.dart';
import 'package:khata_app/app/utils/notification_utils.dart';
import 'package:khata_app/app/view/chk_view_screen.dart';
import 'package:khata_app/app/view/record_screen.dart';
import 'package:khata_app/app/view_model/homepage_view_model.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    final _homeScreenProvider = Provider.of<HomepageViewModel>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white.withOpacity(0.2),
        child: Icon(
          Icons.info,
          size: 50,
          color: Colors.blueAccent,
        ),
        onPressed: () {
          CustomBottomSheet.show(
              height: 350, context: context, child: IntroScreenWidget());
        },
      ),
      appBar: AppBar(
          actions: [
            Row(
              children: [
                Consumer<HomepageViewModel>(
                  builder: (context, value, child) {
                    return Text(
                      value.selectYear.toString(),
                      style: AppTextStyles.customText(
                          color: AppColors.textColor, fontSize: 16),
                    );
                  },
                ),
                PopupMenuButton(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 35,
                    color: Colors.white,
                  ),
                  itemBuilder: (context) => List.generate(
                    _homeScreenProvider.yearList.length,
                    (index) {
                      return PopupMenuItem(
                          onTap: () {
                            _homeScreenProvider.setTheYear(
                                _homeScreenProvider.yearList[index]);
                            setState(() {});
                          },
                          child: Text(
                              _homeScreenProvider.yearList[index].toString()));
                    },
                  ),
                ),
              ],
            )
          ],
          backgroundColor: AppColors.appBarColor,
          title: Row(
            children: [
              Image.asset(
                width: 70,
                height: 70,
                'assets/appicon.png',
                color: Colors.white,
              ),
              Text(
                AppStrings.appName,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ],
          )),
      body: Card(
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Select the Month',
                      style: AppTextStyles.black18Bold,
                    ),
                  ],
                ),
              ),
            ),
            Consumer<HomepageViewModel>(
              builder: (context, value, child) {
                return Card(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Wrap(
                      children: List.generate(
                        value.monthName.length,
                        (index) {
                          return MonthWidget(
                            monthName: value.monthName[index],
                            btnColor: value.monthName[index] ==
                                        CalenderUtils.getCurrentMonthName()
                                            .toString() &&
                                    _homeScreenProvider.selectYear ==
                                        CalenderUtils.getCurrentYear()
                                ? Colors.blueAccent
                                : Color.fromARGB(255, 105, 182, 246),
                            ontap: () {
                              // Navigator.pushNamed(
                              //     context, RoutesName.ChkViewScreen);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChkViewScreen(
                                        selectedMonth: value.monthName[index],
                                        selectedYear:
                                            _homeScreenProvider.selectYear),
                                  ));
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class IntroScreenWidget extends StatefulWidget {
  const IntroScreenWidget({super.key});

  @override
  State<IntroScreenWidget> createState() => _IntroScreenWidgetState();
}

class _IntroScreenWidgetState extends State<IntroScreenWidget> {
  whatsapp() async {
    var contact = "+923431119009";
    var androidUrl =
        "whatsapp://send?phone=$contact&text=Hi Usama, I want app for my business";
    // var iosUrl =
    //     "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      // await launchUrl(Uri.parse(iosUrl));

      await launchUrl(Uri.parse(androidUrl));
    } on Exception {
      NotificationUtils.customNotification(
          context, "Error Occured", "WhatsApp is not installed.", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              opacity: 0.4, image: AssetImage('assets/appicon.png'))),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "الخیر میلک ایپ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black.withOpacity(0.9)),
          ),
          Divider(),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Text(
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.w700),
                  "الخیر میلک ایپ سلامت جٹ کے لیے اپنے کاروبار کے ریکارڈ کو برقرار رکھنے کے لیے بنائی گئی ہے، جہاں وہ اپنے تمام صارفین کا روزانہ اور ماہانہ ریکارڈ برقرار رکھ سکتے ہیں۔")),
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/dev.jpeg'),
            ),
            title: Row(
              children: [
                Text(
                  'Developed By:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Dev Usama')
              ],
            ),
            subtitle: Row(
              children: [
                Text(
                  'Contact Info:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () => whatsapp(),
                  child: Text(
                    'Whatsapp',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
