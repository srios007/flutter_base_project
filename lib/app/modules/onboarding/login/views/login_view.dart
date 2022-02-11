import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/tools/tools.dart';
import 'package:flutter_base_project/app/widgets/buttons/buttons.dart';
import 'package:flutter_base_project/app/widgets/inputs/inputs.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            // margin: dimens.bottom(context, .1),
            child: Text(
              'Plantilla de prueba',
              style: TextStyle(
                color: Colors.black,
                // fontSize: dimens.fullWidth(context) * .1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            // margin: dimens.all(context, .03),
            // padding: dimens.all(context, .05),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: colors.textColor.withOpacity(.2),
                  blurRadius: 20,
                  spreadRadius: 3,
                )
              ],
              color: Colors.white,
              // borderRadius: dimens.borderRadiusContainer(15.0),
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  EmailInput(onSaved: () {}, onChanged: () {}),
                  // Container(height: dimens.fullWidth(context) * .05),
                  PasswordInput(onSaved: () {}, onChanged: () {}),
                  // Container(height: dimens.fullWidth(context) * .05),
                  SimpleButton(
                    color: colors.primaryColor,
                    label: 'Login',
                    onPressed: () => controller.validateForm(),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      controller.goToSignIn();
                    },
                    child: const Text('Regístrate'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
