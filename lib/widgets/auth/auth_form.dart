import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String userName,
    String password,
    bool isLogin,
  ) sumbitFn;

  const AuthForm(this.sumbitFn, {Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;
  String userEmail = '';
  String userName = '';
  String userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid!) {
      _formKey.currentState?.save();
      widget.sumbitFn(
        userEmail.trim(),
        userName.trim(),
        userPassword.trim(),
        isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty || !value.contains("@")) {
                          return "Please enter a valid email address.";
                        }
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                    ),
                    onSaved: (value) {
                      if (value != null) {
                        userEmail = value;
                      }
                    },
                  ),
                  if (!isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Please enter at least 4 characters.';
                          }
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      onSaved: (value) {
                        if (value != null) {
                          userName = value;
                        }
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password must be at least 7 characters long';
                        }
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    onSaved: (value) {
                      if (value != null) {
                        userPassword = value;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(isLogin ? "Login" : "Register"),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(
                      isLogin
                          ? "Create new account"
                          : 'I already have an account',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
