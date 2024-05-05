



bool areAllNonNull(List<Object?> objects) {
  // Use a for loop to iterate through the objects
  for (final object in objects) {
    if (object == null) {
      return false; // Return false if any object is null
    }
  }
  // If the loop completes without finding any null objects, return true
  return true;
}

bool isEmailAddressValid(String email) {
  // Define a regular expression pattern for a valid email address
  const emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
  // Create a RegExp object with the pattern
  final regExp = RegExp(emailPattern);
  // Use the RegExp's hasMatch method to check if the email matches the pattern
  return regExp.hasMatch(email);
}