import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_managment/consts/app_assets.dart';
import 'package:url_launcher/url_launcher.dart';

/// Back button + centered "Project Detail" title (+ optional trailing action).
class DetailHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const DetailHeader({super.key, this.title = 'Project Detail', this.trailing});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.beVietnamPro(
                fontSize: 32, fontWeight: FontWeight.w300, color: Colors.white),
          ),
          Positioned(
            left: 25,
            child: GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: SvgPicture.asset(AppIcons.back, width: 40, height: 40),
            ),
          ),
          Positioned(
            right: 25,
            child: GestureDetector(
              onTap: () async {
                await launchUrl(Uri.parse("https://t.me/hasanboy_1605"),
                        mode: LaunchMode.inAppWebView)
                    .onError((error, stack) {
                  print('Error chiqdiku $error');
                  return false;
                });
              },
              child: SvgPicture.asset(AppIcons.navInbox, width: 40, height: 40),
            ),
          ),
          if (trailing != null) Positioned(right: 25, child: trailing!),
        ],
      ),
    );
  }
}
