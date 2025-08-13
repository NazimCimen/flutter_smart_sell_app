import 'package:sell_smart/app/config/localization/locale_constants.dart';
import 'package:sell_smart/app/config/theme/theme_manager.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sell_smart/main.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

abstract class AppInit {
  Future<void> initialize();
  Future<void> run();
  Widget getApp();
}

class AppInitImpl extends AppInit {
  @override
  Widget getApp() {
    return EasyLocalization(
      supportedLocales: const [
        LocaleConstants.enLocale,
        LocaleConstants.trLocale,
        LocaleConstants.ptLocale,
        LocaleConstants.jaLocale,
        LocaleConstants.krLocale,
        LocaleConstants.cnLocale,
        LocaleConstants.ruLocale,
        LocaleConstants.frLocale,
        LocaleConstants.deLocale,
        LocaleConstants.itLocale,
        LocaleConstants.esLocale,
        LocaleConstants.saLocale,
      ],
      path: LocaleConstants.localePath,
      fallbackLocale: LocaleConstants.enLocale,

      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeManager>(
            create: (context) => ThemeManager(),
          ),
        
        ],
        child: DevicePreview(
          enabled: false,
          builder: (context) => const MyApp(),
        ),
      ),
    );
  }

  @override
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await EasyLocalization.ensureInitialized();
    await Hive.initFlutter();
   // setupDI();
   
    await ThemeManager().loadTheme();
   /// await getIt<PermissionService>().requestNotificationPermission();
  //  await getIt<LocalNotificationService>().initialize();
  }

  @override
  Future<void> run() async {
    await initialize();
    runApp(getApp());
  }
}
