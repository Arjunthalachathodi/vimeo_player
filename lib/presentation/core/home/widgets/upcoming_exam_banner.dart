import 'package:flutter/material.dart';
import '../../../../application/core/theme/colors.dart';
import '../../../../application/core/theme/text_styles.dart';
import '../../../../application/core/theme/diamentions.dart';

class UpcomingExamBanner extends StatelessWidget {
  const UpcomingExamBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: ColorResources.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          // Calendar icon
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: ColorResources.skyBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.calendar_today_outlined,
                color: ColorResources.oceanBlue, size: 20),
          ),
          gap12,

          // Exam info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: ColorResources.skyBlue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'UPCOMING EXAM',
                    style: ThemeTextStyles.getPrimaryTextStyle(context)
                        .s09
                        .w800
                        .copyWith(
                            color: ColorResources.oceanBlue,
                            letterSpacing: 0.6),
                  ),
                ),
                gap4,
                Text(
                  'Physics Midterms',
                  style: ThemeTextStyles.getPrimaryTextStyle(context).s14.w700,
                ),
                Text(
                  'Tomorrow at 10:00 AM',
                  style: ThemeTextStyles.getSecondaryTextStyle(context).s11,
                ),
              ],
            ),
          ),

          // Review button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorResources.oceanBlue,
              foregroundColor: ColorResources.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              textStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            child: const Text('Review'),
          ),
        ],
      ),
    );
  }
}
