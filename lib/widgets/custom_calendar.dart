
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task_managment/consts/app_colors.dart';

class CustomCalendar extends StatelessWidget implements PreferredSizeWidget {
  const CustomCalendar({
    super.key,
    required this.calendarController
  });

  final CalendarController calendarController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60, // Set height to fit only the view header
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SfCalendar(
          controller: calendarController,
          cellEndPadding: 0,
          view: CalendarView.week,
          timeSlotViewSettings: TimeSlotViewSettings(timeRulerSize: 0),
          weekNumberStyle: WeekNumberStyle(backgroundColor: AppColors.primary),
          headerHeight: 0,
          viewHeaderHeight: 60,
          todayHighlightColor: AppColors.primary,
          viewHeaderStyle: ViewHeaderStyle(
            backgroundColor: AppColors.white,
            dayTextStyle: TextStyle(color: Colors.black54),
            dateTextStyle: TextStyle(color: Colors.black, fontSize: 16),
          ),
          selectionDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.primary),
          initialSelectedDate: calendarController.selectedDate ?? DateTime.now(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 60);
}
