import 'package:cms/src/service/routing/params_list.dart';
import 'package:cms/src/service/routing/uri_extension.dart';

abstract class Routes {
  static const String root = '/';
  static const String welcome = '/welcome';

  static String collection() => '/collection';

  static String solo() => '/solo';

  static String editor() => '/editor';

  static String roles() => '/roles';

  static String settings() => '/settings';

  static String icons() => '/icons';

  static String collectionOf(String modelId) => '${collection()}/$modelId';

  static String soloModelGateway(String modelId) => '${solo()}/$modelId/gateway';

  static String pageOfSoloModel(String modelId) => '${solo()}/$modelId';

  static String createPageOfSoloModel(String modelId) => '${solo()}/$modelId/create';

  static String pageOfCollectionModel(String modelId, String pageId) => '${collectionOf(modelId)}/$pageId';

  static String createModelPage(String entityId) => '${editor()}/page/$entityId';

  static String editModel(String entityId) => '${editor()}/model/$entityId';

  static String createModel({QueryParameters? query}) {
    final String path = '${editor()}/model';
    if (query == null || query.isEmpty) {
      return path;
    }
    return Uri(path: path, queryParameters: query).toString();
  }

  static List<String> get _allRoutes {
    return [
      root,
      welcome,
      collection(),
      solo(),
      editor(),
      roles(),
      settings(),
      icons(),
      collectionOf(Params.modelId.forPath),
      soloModelGateway(Params.modelId.forPath),
      pageOfSoloModel(Params.modelId.forPath),
      createPageOfSoloModel(Params.modelId.forPath),
      pageOfCollectionModel(Params.modelId.forPath, Params.pageId.forPath),
      createModelPage(Params.modelId.forPath),
      editModel(Params.modelId.forPath),
      createModel(),
    ];
  }

  static String findRouteByUrlAndParams(String url, Map<String, String> pathParameters) {
    for (final String route in _allRoutes) {
      String tempRoute = route;
      for (final MapEntry<String, String> paramEntry in pathParameters.entries) {
        final String paramKey = ':${paramEntry.key}';
        final String paramValue = paramEntry.value;
        tempRoute = tempRoute.replaceAll(paramKey, paramValue);
      }
      if (tempRoute == url) {
        return route;
      }
    }
    return root;
  }
}
