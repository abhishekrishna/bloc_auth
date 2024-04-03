import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/features/login/bloc/login_bloc.dart';
import 'package:flutter_login/features/login/login.dart';
import 'package:formz/formz.dart';

import '../../../app_icons_icons.dart';
import '../../../core/const/colors.dart';
import '../../../core/widget/widgets.dart';

final FocusNode emailFocusNode = FocusNode();
final TextEditingController emailController = TextEditingController();

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: ListView(
            padding: const EdgeInsets.only(left: 10, top: 70, right: 10),
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  onTap: () {
                    // ignore: lines_longer_than_80_chars
                    ///Kill app, running process, close app and kill all running Dart VM process regarding app
                    // exit(0);
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    AppIcons.left,
                    color: ColorTheme.lightBaseColor,
                    size: 18,
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  "Enter your Mobile Number",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 28,
                      fontFamily: 'PoppinsReg',
                      fontWeight: FontWeight.w600,
                      color: ColorTheme.lightBaseColor),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20, left: 8),
                  child: Text(
                    " We will send OTP to your number ",
                    style: const TextStyle(
                        fontFamily: 'PoppinsReg',
                        fontSize: 14,
                        color: ColorTheme.lightBaseColor),
                  )),
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/Vector/Email_Verification_DarkTheme.png',
                height: 227,
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 8, right: 8),
                  child: SizedBox(
                    height: 60,
                    child: BlocBuilder<LoginBloc, LoginState>(
                        buildWhen: (previous, current) =>
                            previous.username != current.username,
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: CustomWidgets().customTextField(
                              context,
                              null,
                              null,
                              emailFocusNode,
                              emailController,
                              "Email ID",
                              " ",
                              () {
                                emailController.clear();
                              },
                              false,
                              (value) {
                                // Dispatch the LoginUsernameChanged event here when the text field changes
                                context
                                    .read<LoginBloc>()
                                    .add(LoginUsernameChanged(value));
                              },
                            ),
                          );
                        }),
                  )),
              SizedBox(
                height: 50,
              ),
              Container(
                alignment: Alignment.center,
                width: 230,
                child:
                    CustomWidgets().customButton(context, 'Send OTP', () async {
                  print("ontap");
                  context.read<LoginBloc>().add(
                        LoginSubmitted(),
                      );
                }, false),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 50,
              )
            ],
          )),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'username',
            errorText:
                state.username.displayError != null ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: state.isValid
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
                child: const Text('Login'),
              );
      },
    );
  }
}
