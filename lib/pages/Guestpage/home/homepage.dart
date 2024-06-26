import 'package:bhc_prop/core/colors.dart';
import 'package:bhc_prop/pages/Guestpage/faq.dart';
import 'package:bhc_prop/pages/Guestpage/home/houses_row.dart';
import 'package:bhc_prop/pages/Guestpage/home/topbar.dart';
import 'package:bhc_prop/pages/Guestpage/houseitem.dart';
import 'package:bhc_prop/pages/Login&Register/login.dart';
import 'package:bhc_prop/widget/app_icon.dart';
import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const spacing = 28.0;
    const bottomBarHeight = 72.0;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              TopBar(
                margin: const EdgeInsets.only(
                  left: spacing,
                  right: spacing,
                  top: 42,
                  bottom: 24,
                ),
                leftIcon: AppIconButton(
                  iconPath: 'assets/icons/ic_arrow_back.svg',
                  onPressed: () {
                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => LoginPage()));
                  },
                ),
                rightIcon: AppIconButton(
                  iconPath: 'assets/icons/ic_explore.svg',
                  onPressed: () {
                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => FAQPage()));
                  },
                ),
                title: 'Home',
                titleColor: AppColors.defaultTextColor,
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(
                    left: spacing,
                    right: spacing,
                    top: spacing,
                    bottom: spacing + bottomBarHeight,
                  ),
                  itemCount: houseItems.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: double.infinity,
                      height: 280,
                      child: HouseRow(
                        item: houseItems[index],
                        onTap: () {
                          
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, state) => const SizedBox(
                    height: spacing,
                  ),
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
