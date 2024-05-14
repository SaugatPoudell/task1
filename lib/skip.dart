import 'package:flutter/widgets.dart';
class Skip  extends ChangeNotifier{
bool Skipped;

Skip(
  {
    this.Skipped=false
  }
);

void SkippedSender()
{
  
   Skipped=true;
   print(Skipped);
notifyListeners();
}

}