import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_managment/consts/app_assets.dart';
import 'package:task_managment/consts/app_colors.dart';
import 'package:task_managment/providers/project_provider.dart';
import 'package:task_managment/screens/admin_project_detail_screen.dart';
import 'package:task_managment/screens/project_detail_screen.dart';
import 'package:task_managment/widgets/add_new_member_widget.dart';
import 'package:task_managment/widgets/app_bottom_nav.dart';
import 'package:task_managment/widgets/project_card.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectListScreen extends StatelessWidget {
  final bool isAdmin;

  const ProjectListScreen({super.key, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    final projects = context.watch<ProjectProvider>().projects;
    final fg = isAdmin ? Colors.white : Colors.black;
    return Scaffold(
      extendBody: true,
      floatingActionButton: isAdmin
          ? Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: SizedBox(
                width: 60,
                height: 60,
                child: FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: const CircleBorder(),
                  child: SvgPicture.asset(AppIcons.plusWhite,
                      width: 27, height: 27),
                ),
              ),
            )
          : null,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(top: 18, bottom: 120),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 23),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Your\nProject (${projects.length})',
                      style: GoogleFonts.beVietnamPro(
                          fontSize: 60, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SvgPicture.asset(
                        isAdmin ? AppIcons.bellWhite : AppIcons.bell,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.white
                                : AppColors.dark,
                            BlendMode.srcIn),
                        width: 32,
                        height: 32),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 411,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  itemCount: projects.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 20),
                  itemBuilder: (context, index) => ProjectCard(
                    index: index,
                    project: projects[index],
                    height: 411,
                    onTap: () => _open(context, projects[index]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                'Team members',
                style: GoogleFonts.beVietnamPro(fontSize: 25),
              ),
            ),
            SizedBox(height: 20),
            ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 22),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final person = context.watch<ProjectProvider>().team[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(40)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(person.image),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,spacing: 20,
                        children: [
                          IconButton.outlined(
                              onPressed: () async {
                                await launchUrl(Uri(
                                    scheme: 'tel', path: person.phoneNumber));
                              },
                              icon: Icon(Icons.call)),
                          IconButton.outlined(
                              onPressed: () async {
                                await launchUrl(Uri(
                                    query: 'Salom jigar',
                                    scheme: 'sms', path: person.phoneNumber));
                              },
                              icon: Icon(Icons.sms)),
                        ],
                      ),
                      title: Text(person.name),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: 10),
                itemCount: context.watch<ProjectProvider>().team.length),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: FilledButton(
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => AddNewMemberWidget());
                  },
                  child: Text(
                    'Add memeber',
                    style: GoogleFonts.poppins(
                        color: AppColors.white, fontSize: 15),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _open(BuildContext context, ProjectModel project) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => isAdmin
          ? AdminProjectDetailScreen(project: project)
          : ProjectDetailScreen(project: project),
    ));
  }
}
