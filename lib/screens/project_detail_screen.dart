import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_managment/consts/app_assets.dart';
import 'package:task_managment/consts/app_colors.dart';
import 'package:task_managment/providers/project_provider.dart';
import 'package:task_managment/utils/date_format.dart';
import 'package:task_managment/widgets/avatar_stack.dart';
import 'package:task_managment/widgets/detail_header.dart';

/// Employee project detail: blue header with a white bottom sheet.
class ProjectDetailScreen extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final label = GoogleFonts.beVietnamPro(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black.withValues(alpha: 0.5));

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 19),
            const DetailHeader(),
            const SizedBox(height: 28),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(25, 25, 25, 40),
                  children: [
                    Center(child: SvgPicture.asset(AppIcons.handle)),
                    const SizedBox(height: 23),
                    Text(
                      project.name,
                      style: GoogleFonts.beVietnamPro(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.dark),
                    ),
                    const SizedBox(height: 23),
                    Text(
                      project.description,
                      style: GoogleFonts.beVietnamPro(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: AppColors.dark),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Assigned to', style: label),
                              const SizedBox(height: 7),
                              AvatarStack(people: project.group),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Due date', style: label),
                              const SizedBox(height: 7),
                              Text(
                                longDate(project.deadLine),
                                style: GoogleFonts.beVietnamPro(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 39),
                    for (final task in project.tasks) ...[
                      _TaskCard(task: task),
                      const SizedBox(height: 15),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final TaskModel task;

  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Color(0x26000000), blurRadius: 4),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: SvgPicture.asset(AppIcons.flag, width: 25, height: 25),
              ),
              const SizedBox(width: 7),
              Padding(
                padding: const EdgeInsets.only(top: 9),
                child: Text(
                  '${task.hours} hr',
                  style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withValues(alpha: 0.5)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AvatarStack(people: task.members),
        ],
      ),
    );
  }
}
