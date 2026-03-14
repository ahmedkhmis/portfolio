import 'dart:js_interop';

@JS('emailjs.send')
external JSPromise<JSAny> _emailjsSend(
  JSString serviceId,
  JSString templateId,
  JSObject templateParams,
  JSString publicKey,
);
Future<bool> sendEmail({
  required String name,
  required String email,
  required String subject,
  required String message,
}) async {
  try {
    const serviceId = String.fromEnvironment('EMAILJS_SERVICE_ID');
    const templateId = String.fromEnvironment('EMAILJS_TEMPLATE_ID');
    const publicKey = String.fromEnvironment('EMAILJS_PUBLIC_KEY');

    final params = <String, String>{
      'name': name,
      'email': email,
      'title': subject,
      'time': DateTime.now().toString(),
      'message': message,
      'to_email': 'ahmedkhmis99@gmail.com',
    }.jsify();

    await _emailjsSend(
      serviceId.toJS,
      templateId.toJS,
      params as JSObject,
      publicKey.toJS,
    ).toDart;

    return true;
  } catch (_) {
    return false;
  }
}
