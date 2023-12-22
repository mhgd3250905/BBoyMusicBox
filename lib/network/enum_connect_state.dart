import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum ConnectState {
  waiting,
  done,
  err,
  none,
}

extension ConnectStateExtension on ConnectState {
  String get name => describeEnum(this);

  bool get isWaiting {
    return this == ConnectState.waiting;
  }

  bool get isDone {
    return this == ConnectState.done;
  }

  bool get isErr {
    return this == ConnectState.err;
  }

  bool get isNone {
    return this == ConnectState.none;
  }

  ///获取当前状态的默认加载icon(动画？）
  Widget get curIcon {
    switch (this) {
      case ConnectState.waiting:
        return Lottie.asset(
          'assets/lottie_loading_plane.json',
          key: ValueKey(this),
          width: 25.0,
          height: 25.0,
        );
      case ConnectState.done:
        return Lottie.asset(
          'assets/lottie_add_success.json',
          key: ValueKey(this),
          width: 25.0,
          height: 25.0,
        );
      case ConnectState.err:
        return Lottie.asset(
          'assets/lottie_error.json',
          key: ValueKey(this),
          width: 25.0,
          height: 25.0,
        );
      case ConnectState.none:
        return SizedBox.shrink(key: ValueKey(this));
    }
  }
}
