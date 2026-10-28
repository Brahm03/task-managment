import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task_managment/consts/app_colors.dart';
import 'package:task_managment/providers/calendar_provider.dart';
import 'package:task_managment/providers/project_provider.dart';
import 'package:task_managment/widgets/custom_calendar.dart';
import 'package:task_managment/widgets/project_card.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarController calendarController = CalendarController();

  @override
  void dispose() {
    calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalendarProvider()
        ..filterlash(DateTime.now(),
            Provider.of<ProjectProvider>(context, listen: false).projects),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton.filled(
                  onPressed: () async {
                    final time = await showDatePicker(
                        context: context,
                        firstDate: DateTime(DateTime.now().year - 30),
                        lastDate: DateTime(DateTime.now().year + 30));
                    setState(() {});
                    context.read<CalendarProvider>().filterlash(
                        time ?? DateTime.now(),
                        Provider.of<ProjectProvider>(context, listen: false)
                            .projects);
                  },
                  icon: Icon(
                    Icons.calendar_month,
                    color: AppColors.white,
                  ))
            ],
            scrolledUnderElevation: 0,
            centerTitle: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.read<CalendarProvider>().salomlashish(),
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat(DateFormat.MONTH_WEEKDAY_DAY)
                      .format(DateTime.now()),
                  style: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            bottom: CustomCalendar(
              calendarController: calendarController,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                SizedBox(
                  height: 640,
                  child: context.watch<CalendarProvider>().filtered.isNotEmpty
                      ? GridView.builder(
                          itemCount:
                              context.watch<CalendarProvider>().filtered.length,
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, mainAxisExtent: 300),
                          itemBuilder: (context, index) {
                            final data = context
                                .watch<CalendarProvider>()
                                .filtered
                                .toList()[index];
                            return ProjectCard(
                                isHorizontal: true,
                                index: index,
                                project: data,
                                onTap: () {});
                          })
                      : Center(child: Text('No any project yet')),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
