import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_managment/consts/app_assets.dart';
import 'package:task_managment/consts/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const AppBottomNav({super.key, this.currentIndex = 1, this.onTap});

  static const _items = [
    (AppIcons.navHome, 'Home'),
    (AppIcons.navProject, 'Project'),
    (AppIcons.navCalendar, 'Calendar'),
    (AppIcons.navInbox, 'Inbox'),
    (AppIcons.navProfile, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration:  BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? AppColors.dark : AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [BoxShadow(color: Color(0x40000000), blurRadius: 2)],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                for (int i = 0; i < _items.length; i++) ...[
                  if (i > 0) const SizedBox(width: 19),
                  Expanded(child: _item(i, context)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(int i, BuildContext context) {
    final selected = i == currentIndex;
    final color = selected ? (Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.dark) : AppColors.grey;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap?.call(i),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Center(
              child: SvgPicture.asset(_items[i].$1,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            _items[i].$2,
            maxLines: 1,
            style: GoogleFonts.beVietnamPro(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
                color: color),
          ),
        ],
      ),
    );
  }
}
