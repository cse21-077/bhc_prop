import 'dart:ui';

import 'package:bhc_prop/core/colors.dart';
import 'package:bhc_prop/widget/app_icon.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.white.withOpacity(0.03),
              ),
            ),
          ),
          Container(
            height: height,
            color: AppColors.bottomBarBg.withOpacity(0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                'assets/icons/ic_explore.svg',
                'assets/icons/ic_search.svg',
                'assets/icons/ic_heart.svg',
                'assets/icons/ic_cowboy_hat.svg',
              ]
                  .map((path) => AppIconButton(
                iconPath: path,
                onPressed: () {},
                fgColor: Colors.white,
                bgColor: AppColors.homeIconsBg.withOpacity(0.03),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
