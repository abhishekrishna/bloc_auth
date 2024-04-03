abstract class AppService {
  // String get locale;
  String get authToken;
  bool get isDarkMode;
  bool get isFirstUse;

  // Future<void> setLocale({
  //   required String locale,
  // });
  Future<void> setAuthToken({
    required String authToken,
  });

  Future<void> setIsDarkMode({
    required bool darkMode,
  });

  Future<void> setIsFirstUse({
    required bool isFirstUse,
  });
}
