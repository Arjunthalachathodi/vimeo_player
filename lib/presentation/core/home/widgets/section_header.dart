import 'package:flutter/material.dart';
import '../../../../application/core/theme/colors.dart';
import '../../../../application/core/theme/text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final bool showAddButton;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.showAddButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: ThemeTextStyles.getPrimaryTextStyle(context).s18.w700,
        ),
        if (actionLabel != null)
          Text(
            actionLabel!,
            style: ThemeTextStyles.getPrimaryTextStyle(context)
                .s14
                .w600
                .copyWith(color: ColorResources.oceanBlue),
          ),
        if (showAddButton)
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: ColorResources.oceanBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.add, color: ColorResources.white, size: 18),
          ),
      ],
    );
  }
}
