import 'enum_connect_state.dart';

class RequestState {
  static int SUCCESS = 1000; //操作成功
  static int PARAM_ERR = 1001; //参数错误
  static int NO_LOGIN = 1002; //未登录
  static int LOGIN_FAILED = 1003; //登陆失败
  static int LOGOUT_FAILED = 1004; //登出失败
  static int READ_DB_FAILED = 1005; //读取数据失败
  static int JSON_PARSE_ERR = 1006; //JSON解析错误
  static int LOGIN_PWD_ERR = 1007; //密码错误
  static int USER_NO_EXIST = 1008; //用户不存在
  static int REGIST_FAILED = 1009; //注册失败

  static String NONE = "";
  static String MSG_ADD_MARK_SUCCESS = "添加记号成功";
  static String MSG_GET_MARK_SUCCESS = "获取记号成功";
  static String MSG_NO_LOGIN = "未登录";
  static String MSG_LOGIN_SUCCESS = "登陆成功";
  static String MSG_REGIST_SUCCESS = "注册成功";
  static String MSG_REGIST_FAILED_ACCOUNT_EXIST = "账号已存在";
  static String MSG_READ_DB_FAILED = "读取数据失败";
  static String MSG_PARAM_ERR = "参数错误";
  static String MSG_LOGIN_FAILED = "登录失败";
  static String MSG_LOGOUT_FAILED = "登出失败";
  static String MSG_JSON_PARSE_ERR = "JSON解析错误";
  static String MSG_LOGIN_PWD_ERR = "密码错误";
  static String MSG_USER_NO_EXIST = "用户不存在";
  static String MSG_REGIST_FAILED = "注册失败";
  static String MSG_REFRESH_TOKEN_FAILED = "更新token失败";
  static String MSG_REFRESH_TOKEN_SUCCESS = "更新token成功";
  static String MSG_USER_EDIT_ERR = "编辑用户失败";
  static String MSG_USER_EDIT_SUCCESS = "编辑用户成功";
  static String MSG_POSITION_NO_EXIST = "地点不存在";
  static String MSG_GET_USERS_SUCCESS = "获取用户成功";
  static String MSG_GET_POSITIONS_SUCCESS = "获取地点成功";
}

class MarkRequestState {
  ConnectState? refreshState = ConnectState.none;
  ConnectState? addState = ConnectState.none;

  MarkRequestState({this.refreshState, this.addState});
}

class UserRequestState {
  ConnectState? loginState = ConnectState.none;
  ConnectState? editState = ConnectState.none;

  UserRequestState({this.loginState, this.editState});
}
