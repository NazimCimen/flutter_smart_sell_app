import 'package:flutter/material.dart';

@immutable
final class StringConstants {
  const StringConstants._();

  // App
  static String get appName => 'Smart Sell';
  static String get appTagline => 'Dakikalar içinde akıllı teklif oluşturun';
  static String get appDescription =>
      'Smart Sell; satış ekiplerinin müşteri seçimlerine göre otomatik, tutarlı ve hızlı fiyat teklifleri oluşturmasını sağlar. Firma bilgileri bir kez kaydedilir, her teklifte tekrar kullanılabilir. Çıktılar anında PDF olarak paylaşılabilir.';

  // Common
  static String get continueText => 'Devam Et';
  static String get cancel => 'Vazgeç';
  static String get ok => 'Tamam';

  // Auth - headers
  // Auth - contextual headers
  static String get authLoginTitle => 'Hoş geldiniz';
  static String get authLoginSubtitle =>
      'Hesabınıza giriş yapın ve tekliflerinizi yönetin';
  static String get authSignupTitle => 'Aramıza katılın';
  static String get authSignupSubtitle =>
      'Smart Sell ile dakikalar içinde akıllı teklif oluşturun';
  // Backward-friendly defaults (used if specific titles not provided)
  static String get welcomeTitle => authLoginTitle;
  static String get welcomeSubtitle => appTagline;

  // Auth - fields
  static String get fullName => 'Ad Soyad';
  static String get phoneNumber => 'Telefon numarası';
  static String get email => 'E-posta adresi';
  static String get password => 'Şifreniz';

  // Auth - actions
  static String get login => 'Giriş yap';
  static String get signup => 'Kayıt ol';
  static String get logout => 'Çıkış yap';

  // Auth - footers
  static String get dontHaveAccount => 'Hesabınız yok mu? ';
  static String get haveAccount => 'Zaten hesabınız var mı? ';
  static String get goToSignup => 'Kayıt ol';
  static String get goToLogin => 'Giriş yap';

  // Feedback / Snackbars
  static String get loginSuccess => 'Hoş geldiniz!';
  static String get signupSuccess => 'Kayıt tamamlandı. Hemen başlayalım!';
  static String get invalidCredentials => 'Bilgilerinizi kontrol edip tekrar deneyin';
  static String get invalidSignupData => 'Lütfen tüm alanları kontrol edin';

  // Validation messages
  static String get validationNameRequired => 'Ad soyad gereklidir';
  static String get validationNameInvalid => 'Geçerli bir ad soyad girin';
  static String get validationEmailRequired => 'E-posta gereklidir';
  static String get validationEmailInvalid => 'Geçerli bir e-posta adresi girin';
  static String get validationPasswordRequired => 'Şifre gereklidir';
  static String get validationPasswordMinLength => 'Şifre en az 6 karakter olmalı';
  static String get validationPhoneRequired => 'Telefon numarası gereklidir';
  static String get validationPhoneInvalid => 'Geçerli bir telefon numarası girin';

  // PDF / Offer
  static String get createOffer => 'Teklif oluştur';
  static String get downloadPdf => 'PDF indir';
  static String get regenerate => 'Teklifi yenile';
}
