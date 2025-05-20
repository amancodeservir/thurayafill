import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  void startMonitoring(Function(bool) onStatusChange) {
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      if (results.isEmpty || results.first == ConnectivityResult.none) {
        onStatusChange(false);
      } else {
        onStatusChange(true);
      }
    });
  }

  void stopMonitoring() {
    _subscription.cancel();
  }
}
