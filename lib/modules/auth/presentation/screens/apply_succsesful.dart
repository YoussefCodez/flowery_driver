import 'package:flowery_driver/core/app_assets/assets.dart';
import 'package:flowery_driver/core/app_strings/apply_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplySuccsesful extends StatelessWidget {
  const ApplySuccsesful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(Assets.pngBack, fit: BoxFit.fitWidth),
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(Assets.pngSuccess, fit: BoxFit.cover),
                SizedBox(height: 20.h),
                Text(
                  ApplyStrings.yourApplicationHasBeenSubmitted,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: .w600,
                    fontSize: 18.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Text(
                  ApplyStrings.thankyouForProvidingApplication,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: .w400,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 300.w,
                  child: ElevatedButton(
                    onPressed: () {
                      //TODO: Navigate to login screen
                    },
                    child: Text(
                      ApplyStrings.login,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
