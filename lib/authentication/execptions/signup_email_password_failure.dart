class SignupEmailPasswordFailure {
  final String message;

  const SignupEmailPasswordFailure(
      [this.message = "An unknown error occurred!"]);

  // Factory constructor to handle different Firebase exception codes
  factory SignupEmailPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignupEmailPasswordFailure(
            "Please enter a stronger password.");
      case 'email-already-in-use':
        return const SignupEmailPasswordFailure(
            "An account already exists for this email.");
      case 'invalid-email':
        return const SignupEmailPasswordFailure(
            "The email address is not valid.");
      case 'operation-not-allowed':
        return const SignupEmailPasswordFailure(
            "This operation is not allowed. Please contact support.");
      case 'user-disabled':
        return const SignupEmailPasswordFailure(
            "This user has been disabled. Please contact support.");
      case 'user-not-found':
        return const SignupEmailPasswordFailure(
            "No user found for that email.");
      case 'wrong-password':
        return const SignupEmailPasswordFailure(
            "Incorrect password. Please try again.");
      case 'too-many-requests':
        return const SignupEmailPasswordFailure(
            "Too many requests. Please try again later.");
      case 'network-request-failed':
        return const SignupEmailPasswordFailure(
            "Network error. Please check your internet connection.");
      default:
        return const SignupEmailPasswordFailure();
    }
  }
}
