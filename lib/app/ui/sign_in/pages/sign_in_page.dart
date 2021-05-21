import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/core/widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/app/services/auth.dart';
import 'package:time_tracker_flutter_course/app/ui/sign_in/pages/email_sign_in_page.dart';
import 'package:time_tracker_flutter_course/app/ui/sign_in/widgets/sign_in_button.dart';
import 'package:time_tracker_flutter_course/app/ui/sign_in/widgets/social_sign_in_button.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  void _signInAnnonymous(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final _auth = Provider.of<Auth>(context, listen: false);
      await _auth.signInAnnonymous();
    } catch (e) {
      showAlertDialog(
        context,
        title: "Error on sign in",
        content: e.toString(),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _signInWithGoogle(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final _auth = Provider.of<Auth>(context, listen: false);
      await _auth.signInWithGoogle();
    } catch (e) {
      showAlertDialog(
        context,
        title: "Error on sign in",
        content: e.toString(),
      );
    } finally {
      setState(() => _isLoading = false);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _headerLoading(),
            SizedBox(
              height: 80,
            ),
            SocialSignInButton(
              label: 'Sign in with Google',
              image: 'assets/images/google-logo.png',
              onPressed: _isLoading ? null : () => _signInWithGoogle(context),
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
              onPressed: _isLoading ? null : () => _signInAnnonymous(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerLoading() {
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
