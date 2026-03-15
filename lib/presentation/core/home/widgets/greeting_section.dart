import 'package:flutter/material.dart';
import '../../../../application/core/theme/text_styles.dart';
import '../../../../application/core/theme/diamentions.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ready to learn today?',
          style: ThemeTextStyles.getPrimaryTextStyle(context).s22.w800,
        ),
        gap4,
        Text(
          'You have 3 lessons scheduled for this afternoon.',
          style: ThemeTextStyles.getSecondaryTextStyle(context).s14,
        ),
      ],
    );
  }
}
