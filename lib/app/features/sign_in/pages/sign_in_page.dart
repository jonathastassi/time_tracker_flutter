import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/core/widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/app/features/sign_in/bloc/sign_in_bloc.dart';
import 'package:time_tracker_flutter_course/app/services/auth.dart';
import 'package:time_tracker_flutter_course/app/features/sign_in/pages/email_sign_in_page.dart';
import 'package:time_tracker_flutter_course/app/features/sign_in/widgets/sign_in_button.dart';
import 'package:time_tracker_flutter_course/app/features/sign_in/widgets/social_sign_in_button.dart';

class SignInPage extends StatelessWidget {
  static Widget create(BuildContext context) {
    final _auth = Provider.of<Auth>(context, listen: false);

    return Provider<SignInBloc>(
      create: (_) => SignInBloc(auth: _auth),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
        builder: (_, bloc, __) {
          return SignInPage(bloc);
        },
      ),
    );
  }

  final SignInBloc bloc;

  SignInPage(this.bloc);

  void _signInAnnonymous(BuildContext context) async {
    try {
      await bloc.signInAnnonymous();
    } catch (e) {
      showAlertDialog(
        context,
        title: "Error on sign in",
        content: e.toString(),
      );
    }
  }

  void _signInWithGoogle(BuildContext context) async {
    try {
      await bloc.signInWithGoogle();
    } catch (e) {
      showAlertDialog(
        context,
        title: "Error on sign in",
        content: e.toString(),
      );
    }
  }

  void _signInWithEmailAndPassword(BuildContext context) async {
    final _auth = Provider.of<Auth>(context, listen: false);

    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(auth: _auth),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracker"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<bool>(
            stream: bloc.isLoading,
            builder: (context, snapshot) {
              bool _isLoading = snapshot.data ?? false;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _headerLoading(_isLoading),
                  SizedBox(
                    height: 80,
                  ),
                  SocialSignInButton(
                    label: 'Sign in with Google',
                    image: 'assets/images/google-logo.png',
                    onPressed:
                        _isLoading ? null : () => _signInWithGoogle(context),
                    color: Colors.white,
                    fontColor: Colors.black87,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SignInButton(
                    label: "Sign in with e-mail",
                    color: Colors.indigo,
                    fontColor: Colors.white,
                    onPressed: () => _signInWithEmailAndPassword(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Text(
                      "or",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  SignInButton(
                    label: "Go annonymous",
                    color: Colors.greenAccent,
                    fontColor: Colors.black87,
                    onPressed:
                        _isLoading ? null : () => _signInAnnonymous(context),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget _headerLoading(bool _isLoading) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      "Sign In",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
