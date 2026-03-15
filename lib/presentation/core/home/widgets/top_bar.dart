import 'package:flutter/material.dart';
import '../../../../application/core/theme/colors.dart';
import '../../../../application/core/theme/text_styles.dart';
import '../../../../application/core/theme/diamentions.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Avatar
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorResources.lightYellow,
                border: Border.all(color: ColorResources.oceanBlue, width: 2),
              ),
              child: const Icon(Icons.person,
                  color: ColorResources.oceanBlue, size: 22),
            ),
            gap10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: ThemeTextStyles.getSecondaryTextStyle(context).s12,
                ),
                Text(
                  'Alex Johnson',
                  style: ThemeTextStyles.getPrimaryTextStyle(context)
                      .s14
                      .w700
                      .copyWith(color: ColorResources.oceanBlue),
                ),
              ],
            ),
          ],
        ),
        // Notification bell
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: ColorResources.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: ColorResources.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: const Icon(Icons.notifications_none_rounded,
              color: ColorResources.grayBlue, size: 20),
        ),
      ],
    );
  }
}
