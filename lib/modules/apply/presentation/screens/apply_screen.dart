import 'package:flowery_driver/core/app_strings/apply_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ApplyStrings.title)),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            Text(
              ApplyStrings.welcomeMessage,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 5.h),
            Text(
              ApplyStrings.description,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
