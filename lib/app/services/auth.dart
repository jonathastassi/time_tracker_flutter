import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Stream<User?> get authStateChanges;

  Future<void> signOut();
  Future<void> signInAnnonymous();
  Future<void> signInWithEmailAndPassword();
  Future<void> signInWithGoogle();
}

class Auth implements BaseAuth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  // TODO: implement currentUser
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<void> signInAnnonymous() async {
    await _auth.signInAnonymously();
  }

  @override
  Future<void> signInWithEmailAndPassword() {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
