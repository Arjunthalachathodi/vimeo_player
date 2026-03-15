import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../domain/core/models/subject.dart';
import '../../../application/core/theme/colors.dart';
import '../../../application/core/theme/diamentions.dart';
import 'widgets/top_bar.dart';
import 'widgets/search_bar.dart';
import 'widgets/greeting_section.dart';
import 'widgets/section_header.dart';
import 'widgets/video_card.dart';
import 'widgets/subjects_grid.dart';
import 'widgets/upcoming_exam_banner.dart';

void main() {
  runApp(const LearnApp());
}

class LearnApp extends StatelessWidget {
  const LearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorResources.oceanBlue),
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _subjects = [
    Subject(
      name: 'Mathematics',
      widgets: 12,
      items: 4,
      icon: Icons.calculate_outlined,
      color: ColorResources.oceanBlue,
      bgColor: ColorResources.skyBlue,
    ),
    Subject(
      name: 'Science',
      widgets: 8,
      items: 2,
      icon: Icons.science_outlined,
      color: ColorResources.mintGreen,
      bgColor: ColorResources.lightGray,
    ),
    Subject(
      name: 'English',
      widgets: 15,
      items: 5,
      icon: Icons.menu_book_outlined,
      color: ColorResources.shadowBlue,
      bgColor: ColorResources.pastelPink,
    ),
    Subject(
      name: 'History',
      widgets: 6,
      items: 1,
      icon: Icons.history_edu_outlined,
      color: ColorResources.paradisePink,
      bgColor: ColorResources.lightGray,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorResources.snowWhite,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar
                TopBar(),
                gap20,

                // Search bar
                CustomSearchBar(),
                gap21,

                // Greeting
                GreetingSection(),
                gap21,

                // Continue Watching
                SectionHeader(
                    title: 'Continue Watching', actionLabel: 'View History'),
                gap12,
                VideoCard(),
                gap24,

                // My Subjects
                SectionHeader(title: 'My Subjects', showAddButton: true),
                gap12,
                SubjectsGrid(subjects: _subjects),
                gap24,

                // Upcoming Exam Banner
                UpcomingExamBanner(),
                gap16,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
