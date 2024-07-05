import 'package:food_assignment/features/shared/data/remote/remote.dart';
// import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/domain/models/paginated_response.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';
import 'package:food_assignment/features/shared/globals.dart';

import '../../../shared/domain/models/either.dart';

abstract class DashboardDatasource {
  Future<Either<AppException, PaginatedResponse>> fetchPaginatedProducts(
      {required int skip});
  Future<Either<AppException, PaginatedResponse>> searchPaginatedProducts(
      {required int skip, required String query});
}

class DashboardRemoteDatasource extends DashboardDatasource {
  final NetworkService networkService;
  DashboardRemoteDatasource(this.networkService);

  @override
  Future<Either<AppException, PaginatedResponse>> fetchPaginatedProducts(
      {required int skip}) async {
    final response = await networkService.get(
      '/products',
      queryParameters: {
        'size': skip,
        'limit': PRODUCTS_PER_PAGE,
      },
    );

    return response.fold(
      (l) => Left(l),
      (r) {
        final jsonData = r.data;
        if (jsonData == null) {
          return Left(
            AppException(
              identifier: 'fetchPaginatedData',
              statusCode: 0,
              message: 'The data is not in the valid format.',
            ),
          );
        }
        final paginatedResponse =
            PaginatedResponse.fromJson(jsonData, jsonData['data'] ?? []);
        return Right(paginatedResponse);
      },
    );
  }

  @override
  Future<Either<AppException, PaginatedResponse>> searchPaginatedProducts(
      {required int skip, required String query}) async {
    final response = await networkService.get(
      '/products',
      queryParameters: {
        'size': skip,
        'limit': PRODUCTS_PER_PAGE,
        'search':query,
      },
    );

    return response.fold(
      (l) => Left(l),
      (r) {
        final jsonData = r.data;
        if (jsonData == null) {
          return Left(
            AppException(
              identifier: 'search PaginatedData',
              statusCode: 0,
              message: 'The data is not in the valid format.',
            ),
          );
        }
        // final paginatedResponse =
        //     PaginatedResponse.fromJson(jsonData, jsonData['products'] ?? []);

        final paginatedResponse =
        PaginatedResponse.fromJson(jsonData, jsonData['data'] ?? []);
        return Right(paginatedResponse);
      },
    );
  }
}
