import 'package:clipboard/clipboard.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class fun
{
  static Future<void>openurl(String link) async {
  var url=link;
  if(await canLaunch(url))
  {
  await launch(url);
  }
  else
  {
  await launch(url);
  }
  }

  static Future<void>sharelink(String link) async {
    Share.share(link);
  }

  static Future<void>copylink(String link) async {
    FlutterClipboard.copy(link);
  }
}