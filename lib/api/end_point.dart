import 'package:conversor_moedas/api/key.dart';

final key = getKey();

String urlFinances(){
  return 'https://api.hgbrasil.com/finance?format=json&key=$key';
}