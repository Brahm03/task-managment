import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_managment/consts/app_assets.dart';
import 'package:task_managment/consts/app_colors.dart';
import 'package:task_managment/main.dart';
import 'package:task_managment/providers/project_provider.dart';
import 'package:task_managment/utils/date_format.dart';
import 'package:task_managment/widgets/avatar_stack.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback onTap;
  final int index;
  final double? height;
  final double width;
  final bool isHorizontal;

  const ProjectCard(
      {super.key,
      this.isHorizontal = false,
      required this.index,
      required this.project,
      required this.onTap,
      this.width = 280,
      this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: () {
        showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
                  title: Text('You want to delete the ${project.name} ?'),
                  actions: [
                    CupertinoActionSheetAction(
                        onPressed: () {
                          context.read<ProjectProvider>().delete(index);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Deleted')));
                        },
                        child: Text('Yes')),
                    CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('No')),
                  ],
                ));
      },
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
        decoration: BoxDecoration(
            color: project.color, borderRadius: BorderRadius.circular(40)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Image.asset(project.image, fit: project.imageFit),
                ),
                const Spacer(),
                SvgPicture.asset(AppIcons.arrowUpRight, width: 40, height: 40),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              project.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.beVietnamPro(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SvgPicture.asset(AppIcons.calendar, width: 18, height: 18),
                const SizedBox(width: 5),
                Text(
                  shortDate(project.deadLine),
                  style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withValues(alpha: 0.5)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: isHorizontal == true ? false : true,
              child: Text(
                project.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.beVietnamPro(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: AppColors.dark),
              ),
            ),
            if (height != null) const Spacer() else const SizedBox(height: 25),
            Visibility(
              visible: !isHorizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AvatarStack(people: project.group),
                  const Spacer(),
                  _HoursProgress(
                      hours: project.hours, progress: project.progress),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HoursProgress extends StatelessWidget {
  final int hours;
  final double progress;

  const _HoursProgress({required this.hours, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 60,
          height: 5,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: AppColors.dark.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(5)),
          child: FractionallySizedBox(
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.dark,
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$hours hours',
          style: GoogleFonts.beVietnamPro(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.primary),
        ),
      ],
    );
  }
}
