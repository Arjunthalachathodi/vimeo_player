import 'package:flutter/material.dart';
import '../../../../domain/core/models/subject.dart';
import '../../../../application/core/theme/colors.dart';
import '../../../../application/core/theme/text_styles.dart';

class SubjectsGrid extends StatelessWidget {
  final List<Subject> subjects;

  const SubjectsGrid({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: subjects.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 1.35,
      ),
      itemBuilder: (_, i) => _SubjectCard(subject: subjects[i]),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final Subject subject;

  const _SubjectCard({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ColorResources.pureBlack.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: subject.bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(subject.icon, color: subject.color, size: 20),
          ),
          const Spacer(),
          Text(
            subject.name,
            style: ThemeTextStyles.getPrimaryTextStyle(context).s14.w700,
          ),
          const SizedBox(height: 3),
          Text(
            '${subject.widgets} Widgets • ${subject.items} Items',
            style: ThemeTextStyles.getSecondaryTextStyle(context).s11,
          ),
        ],
      ),
    );
  }
}
