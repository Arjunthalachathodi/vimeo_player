import 'package:flutter/material.dart';
import '../../../../application/core/theme/colors.dart';
import '../../../../application/core/theme/text_styles.dart';
import '../../../../application/core/theme/diamentions.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: ColorResources.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          gap16,
          const Icon(Icons.search, color: ColorResources.slateGray, size: 20),
          gap10,
          Text(
            'Search subjects, lessons, tutors...',
            style: ThemeTextStyles.getSecondaryTextStyle(context)
                .s14
                .copyWith(color: ColorResources.slateGray),
          ),
        ],
      ),
    );
  }
}
