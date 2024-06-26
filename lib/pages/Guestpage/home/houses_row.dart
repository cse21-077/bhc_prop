import 'package:bhc_prop/core/colors.dart';
import 'package:bhc_prop/pages/Guestpage/houseitem.dart';
import 'package:bhc_prop/pages/Guestpage/houseview/screens/houseview.dart';
import 'package:flutter/material.dart';

class HouseRow extends StatelessWidget {
  const HouseRow({
    super.key,
    required this.item,
    required this.onTap,
  });

  final HouseItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        final imageWidth = width * 0.4;
        final boxWidth = width - (imageWidth / 2);
        final boxHeight = height * 0.8;
        return Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: item.color,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(28),
                  ),
                ),
                width: boxWidth,
                height: boxHeight,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 24,
                      top: 24,
                      bottom: 24,
                      right: 24 + (imageWidth / 4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: AppColors.whiteTextColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.description,
                        style: const TextStyle(
                          color: AppColors.descriptionTextColor,
                          fontSize: 14,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(child: Container()),
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => HouseScreen()));
                        },
                        color: item.buttonBgColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8,
                          ),
                          child: Text(
                            'View',
                            style: TextStyle(
                              color: item.buttonTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Hero(
                tag: item.mainFullSizeImage,
                child: Image.asset(
                  item.mainFullSizeImage,
                  width: imageWidth,
                  height: height,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}