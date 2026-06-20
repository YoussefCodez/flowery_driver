import 'package:flowery_driver/core/app_strings/apply_strings.dart';
import 'package:flowery_driver/core/theme/app_colors.dart';
import 'package:flowery_driver/core/utils/app_regex.dart';
import 'package:flowery_driver/core/utils/error_handler.dart';
import 'package:flowery_driver/core/widgets/custom_dropdown_field.dart';
import 'package:flowery_driver/core/widgets/custom_text_form_field.dart';
import 'package:flowery_driver/config/base_state/base_state.dart';
import 'package:flowery_driver/modules/auth/domain/entities/apply_body_entity.dart';
import 'package:flowery_driver/modules/auth/domain/entities/country_entity.dart';
import 'package:flowery_driver/modules/auth/presentation/screens/apply_succsesful.dart';
import 'package:flowery_driver/modules/auth/presentation/view_model/apply_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CountryEntity? _selectedCountry;
  late TextEditingController _firstLegalController;
  late TextEditingController _lastLegalController;
  late TextEditingController _emailController;
  late TextEditingController _vehicleNumberController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _idNumberController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _licenseController;
  late TextEditingController _idImageController;
  final picker = ImagePicker();
  XFile? licenseImage;
  XFile? idImage;
  final List<String> _vehicleTypes = const [
    ApplyStrings.sedan,
    ApplyStrings.suv,
    ApplyStrings.truck,
    ApplyStrings.hatchback,
    ApplyStrings.pickup,
  ];
  String? _selectedVehicleType;
  String? _selectedGender = 'male';

  @override
  void initState() {
    super.initState();
    _firstLegalController = TextEditingController();
    _lastLegalController = TextEditingController();
    _emailController = TextEditingController();
    _vehicleNumberController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _idNumberController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _licenseController = TextEditingController();
    _idImageController = TextEditingController();
    context.read<ApplyCubit>().getCountries();
  }

  @override
  void dispose() {
    _firstLegalController.dispose();
    _lastLegalController.dispose();
    _emailController.dispose();
    _vehicleNumberController.dispose();
    _phoneNumberController.dispose();
    _idNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _licenseController.dispose();
    _idImageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(ApplyStrings.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: 20.h),
                BlocBuilder<ApplyCubit, BaseState>(
                  buildWhen: (previous, current) =>
                      current.data is List<CountryEntity> ||
                      current.state == StateType.error,
                  builder: (context, state) {
                    if (state.state == StateType.error) {
                      return Text(
                        ApplyStrings.errorLoadingCountries,
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      );
                    } else if (state.state == StateType.success) {
                      final countries = state.data as List<CountryEntity>;
                      return CustomDropdownField<CountryEntity>(
                        labelText: ApplyStrings.country,
                        hintText: ApplyStrings.chooseCountry,
                        value: _selectedCountry,
                        items: countries,
                        itemAsString: (country) =>
                            "${country.flag}   ${country.name} (${country.phoneCode})",
                        onChanged: (country) {
                          setState(() {
                            _selectedCountry = country;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return ApplyStrings.validationCountryRequired;
                          }
                          return null;
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  controller: _firstLegalController,
                  labelText: ApplyStrings.firstLegalName,
                  hintText: ApplyStrings.enterFirstLegalName,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return ApplyStrings.validationFirstNameRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  controller: _lastLegalController,
                  labelText: ApplyStrings.secondLegalName,
                  hintText: ApplyStrings.enterSecondLegalName,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return ApplyStrings.validationLastNameRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                CustomDropdownField<String>(
                  labelText: ApplyStrings.vehicleType,
                  hintText: ApplyStrings.chooseVehicleType,
                  value: _selectedVehicleType,
                  items: _vehicleTypes,
                  itemAsString: (value) => value,
                  onChanged: (value) {
                    setState(() {
                      _selectedVehicleType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ApplyStrings.validationVehicleTypeRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  controller: _vehicleNumberController,
                  labelText: ApplyStrings.vehicleNumber,
                  hintText: ApplyStrings.enterVehicleNumber,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return ApplyStrings.validationVehicleNumberRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () async {
                    final pickedFile = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        licenseImage = pickedFile;
                        _licenseController.text = pickedFile.name;
                      });
                    }
                  },
                  child: CustomTextFormField(
                    controller: _licenseController,
                    labelText: ApplyStrings.vehicleLicense,
                    hintText: ApplyStrings.uploadLicensePhoto,
                    enabled: false,
                    unenabledColor: AppColors.blackColor,
                    suffixIcon: Icon(
                      Icons.upload,
                      color: AppColors.blackColor,
                      size: 24.sp,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ApplyStrings.validationLicenseRequired;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  controller: _emailController,
                  labelText: ApplyStrings.email,
                  hintText: ApplyStrings.enterEmail,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return ApplyStrings.validationEmailRequired;
                    }
                    if (!AppRegex.emailRegex.hasMatch(value)) {
                      return ApplyStrings.validationEmailInvalid;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  controller: _phoneNumberController,
                  labelText: ApplyStrings.phoneNumber,
                  hintText: ApplyStrings.enterPhoneNumber,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return ApplyStrings.validationPhoneRequired;
                    }
                    if (value.trim().length < 6) {
                      return ApplyStrings.validationPhoneInvalid;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  controller: _idNumberController,
                  labelText: ApplyStrings.idNumber,
                  hintText: ApplyStrings.enterIdNumber,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return ApplyStrings.validationIdNumberRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () async {
                    final pickedFile = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        idImage = pickedFile;
                        _idImageController.text = pickedFile.name;
                      });
                    }
                  },
                  child: CustomTextFormField(
                    controller: _idImageController,
                    labelText: ApplyStrings.idImage,
                    hintText: ApplyStrings.uploadIdImage,
                    enabled: false,
                    unenabledColor: AppColors.blackColor,
                    suffixIcon: Icon(
                      Icons.upload,
                      color: AppColors.blackColor,
                      size: 24.sp,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ApplyStrings.validationIdImageRequired;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: _passwordController,
                        labelText: ApplyStrings.password,
                        hintText: ApplyStrings.enterPassword,
                        obscureText: true,
                        enabled: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ApplyStrings.validationPasswordRequired;
                          }
                          if (!AppRegex.passwordRegex.hasMatch(value)) {
                            return ApplyStrings.validationPasswordInvalid;
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: CustomTextFormField(
                        controller: _confirmPasswordController,
                        labelText: ApplyStrings.confirmPassword,
                        hintText: ApplyStrings.enterConfirmPassword,
                        obscureText: true,
                        enabled: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ApplyStrings
                                .validationConfirmPasswordRequired;
                          }
                          if (value != _passwordController.text) {
                            return ApplyStrings.validationConfirmPasswordMatch;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                RadioGroup<String>(
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        ApplyStrings.gender,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.blackColor,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'male',
                            activeColor: AppColors.primaryColor,
                          ),
                          Text(
                            ApplyStrings.male,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20.w),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'female',
                            activeColor: AppColors.primaryColor,
                          ),
                          Text(
                            ApplyStrings.female,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                BlocListener<ApplyCubit, BaseState>(
                  listener: (context, state) {
                    state.when(
                      initial: () {},
                      loading: () {},
                      success: (data) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ApplySuccsesful(),
                          ),
                        );
                      },
                      error: (exception) {
                        final message = exception is ServerException
                            ? exception.message
                            : exception.toString();
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(message)));
                      },
                    );
                  },
                  child: BlocBuilder<ApplyCubit, BaseState>(
                    builder: (context, state) {
                      final isLoading = state.state == StateType.loading;
                      return ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<ApplyCubit>().apply(
                                    ApplyBodyEntity(
                                      country: _selectedCountry!.name,
                                      firstName: _firstLegalController.text,
                                      lastName: _lastLegalController.text,
                                      vehicleType: "676b31a45d05310ca82657ac",
                                      vehicleNumber:
                                          _vehicleNumberController.text,
                                      vehicleLicense: licenseImage!,
                                      nid: _idNumberController.text,
                                      nidImg: idImage!,
                                      email: _emailController.text,
                                      phone:
                                          '+${_selectedCountry!.phoneCode}${_phoneNumberController.text}',
                                      password: _passwordController.text,
                                      repassword:
                                          _confirmPasswordController.text,
                                      gender: _selectedGender!,
                                    ),
                                  );
                                }
                              },
                        child: isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(ApplyStrings.continueButtonText),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
