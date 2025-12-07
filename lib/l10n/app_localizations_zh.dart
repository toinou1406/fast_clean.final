// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get privacyFirst => '隐私至上';

  @override
  String get permissionScreenBody => 'FastClean 直接在您的设备上分析您的照片。任何内容都不会上传到服务器。';

  @override
  String get grantAccessContinue => '授予访问权限并继续';

  @override
  String get homeScreenTitle => 'FastClean';

  @override
  String get sortingMessageAnalyzing => '正在分析照片元数据...';

  @override
  String get sortingMessageBlurry => '正在检测模糊图像...';

  @override
  String get sortingMessageScreenshots => '正在搜索不良截图...';

  @override
  String get sortingMessageDuplicates => '正在检查重复项...';

  @override
  String get sortingMessageScores => '正在计算照片分数...';

  @override
  String get sortingMessageCompiling => '正在编译结果...';

  @override
  String get sortingMessageRanking => '按“不良”程度对照片进行排名...';

  @override
  String get sortingMessageFinalizing => '正在完成照片选择...';

  @override
  String get noMorePhotos => '找不到更多可删除的照片！';

  @override
  String errorOccurred(String error) {
    return '发生错误：$error';
  }

  @override
  String photosDeleted(int count, String space) {
    return '删除了 $count 张照片并节省了 $space';
  }

  @override
  String errorDeleting(String error) {
    return '删除照片时出错：$error';
  }

  @override
  String get reSort => '重新排序';

  @override
  String delete(int count) {
    return '删除 ($count)';
  }

  @override
  String get pass => '跳过';

  @override
  String get analyzePhotos => '分析照片';

  @override
  String fullScreenTitle(int count, int total) {
    return '$count / $total';
  }

  @override
  String get kept => '已保留';

  @override
  String get keep => '保留';

  @override
  String get failedToLoadImage => '无法加载图片';

  @override
  String get couldNotDelete => '无法删除照片。请再试一次。';

  @override
  String get photoAccessRequired => '需要完整的照片访问权限。';

  @override
  String get settings => '设置';

  @override
  String get storageUsed => '已用存储空间';

  @override
  String get spaceSavedThisMonth => '本月节省的空间';

  @override
  String get appTitle => 'FastClean';

  @override
  String get chooseYourLanguage => '选择你的语言';
}
