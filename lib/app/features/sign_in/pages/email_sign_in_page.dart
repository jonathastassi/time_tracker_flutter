import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/core/widgets/custom_elevated_button.dart';
import 'package:time_tracker_flutter_course/app/core/widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/app/services/auth.dart';
import 'package:time_tracker_flutter_course/app/features/sign_in/validators/sign_in_validators.dart';

enum FormTypeSignIn {
  register,
  signIn,
}

class EmailSignInPage extends StatefulWidget {
  final Auth auth;

  EmailSignInPage({required this.auth});

  @override
  _EmailSignInPageState createState() => _EmailSignInPageState();
}

class _EmailSignInPageState extends State<EmailSignInPage>
    with SignInValidators {
  FormTypeSignIn _formTypeSignIn = FormTypeSignIn.signIn;
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _setLoading(bool _loading) {
    setState(() {
      _isLoading = _loading;
    });
  }

  void _focusOnInputError() {
    if (emailValidate(_email) != null) {
      _emailFocusNode.requestFocus();
    } else if (passwordValidate(_password) != null) {
      _passwordFocusNode.requestFocus();
    }
  }

  void _submit(BuildContext context) async {
    try {
      _setLoading(true);

      if (_formKey.currentState?.validate() == true) {
        if (_formTypeSignIn == FormTypeSignIn.signIn) {
          await widget.auth.signInWithEmailAndPassword(_email, _password);
        } else {
          await widget.auth.createUserWithEmailAndPassword(_email, _password);
        }

        Navigator.pop(context);
      } else {
        _focusOnInputError();
      }
    } on FirebaseAuthException catch (e) {
      showAlertDialog(
        context,
        title: "Error on sign in",
        content: e.message ?? "",
      );
    } finally {
      _setLoading(false);
    }
  }

  void _toggleFormType() {
    setState(
      () {
        _formTypeSignIn = _formTypeSignIn == FormTypeSignIn.signIn
            ? FormTypeSignIn.register
            : FormTypeSignIn.signIn;
      },
    );

    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final String _textButtonPrimary =
        _formTypeSignIn == FormTypeSignIn.signIn ? "Sign in" : "Register";
    final String _textButtonSecondary = _formTypeSignIn == FormTypeSignIn.signIn
        ? "Need an account? Register"
        : "Have an account? Sign in";

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    focusNode: _emailFocusNode,
                    controller: _emailController,
                    enabled: !_isLoading,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: "E-mail",
                      hintText: "example@example.com",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: emailValidate,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    focusNode: _passwordFocusNode,
                    controller: _passwordController,
                    obscureText: true,
                    enabled: !_isLoading,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "******",
                    ),
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () => _submit(context),
                    validator: passwordValidate,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomElevatedButton(
                    onPressed: () => _submit(context),
                    enabled: !_isLoading,
                    color: Colors.indigo,
                    child: Text(
                      _textButtonPrimary,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextButton(
                    onPressed: _isLoading ? null : _toggleFormType,
                    child: Text(_textButtonSecondary),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
