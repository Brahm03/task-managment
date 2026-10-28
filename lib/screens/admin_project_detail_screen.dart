import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_managment/consts/app_assets.dart';
import 'package:task_managment/consts/app_colors.dart';
import 'package:task_managment/providers/project_provider.dart';
import 'package:task_managment/utils/date_format.dart';
import 'package:task_managment/widgets/avatar_stack.dart';
import 'package:task_managment/widgets/detail_header.dart';

/// Admin project detail: dark background with white info cards and a task checklist.
class AdminProjectDetailScreen extends StatelessWidget {
  final ProjectModel project;

  const AdminProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    context.watch<ProjectProvider>();
    final cardTitle = GoogleFonts.beVietnamPro(
        fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.dark);

    return Scaffold(
      backgroundColor: AppColors.dark,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 19),
            DetailHeader(
              trailing: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(AppIcons.edit, width: 32, height: 32),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(25, 24, 25, 25),
                children: [
                  _WhiteCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            project.name,
                            style: GoogleFonts.beVietnamPro(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: AppColors.dark),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          project.description,
                          style: GoogleFonts.beVietnamPro(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: AppColors.dark),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Due date:  ${longDate(project.deadLine)}',
                          style: GoogleFonts.beVietnamPro(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withValues(alpha: 0.8)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 23),
                  _WhiteCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Assigned to', style: cardTitle),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 18,
                          runSpacing: 12,
                          children: [
                            for (final person in project.group)
                              Avatar(person: person, size: 40),
                            GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SvgPicture.asset(AppIcons.addPersonCircle),
                                    SvgPicture.asset(AppIcons.plus),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 21),
                  _WhiteCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Task', style: cardTitle),
                        for (final task in project.tasks) ...[
                          const SizedBox(height: 20),
                          _TaskTile(task: task),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WhiteCard extends StatelessWidget {
  final Widget child;

  const _WhiteCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: child,
    );
  }
}

class _TaskTile extends StatelessWidget {
  final TaskModel task;

  const _TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => context.read<ProjectProvider>().toggleTask(task),
          child: SizedBox(
            width: 30,
            height: 30,
            child: task.isDone
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(AppIcons.checkCircle),
                      SvgPicture.asset(AppIcons.check, width: 20, height: 20),
                    ],
                  )
                : SvgPicture.asset(AppIcons.emptyCircle),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  SvgPicture.asset(AppIcons.flag, width: 25, height: 25),
                  const SizedBox(width: 5),
                  Text(
                    '${task.hours} hr',
                    style: GoogleFonts.beVietnamPro(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withValues(alpha: 0.5)),
                  ),
                ],
              ),
            ],
          ),
        ),
        AvatarStack(people: task.members),
      ],
    );
  }
}
