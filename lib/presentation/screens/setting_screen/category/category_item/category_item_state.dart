import 'package:viet_wallet/business/blocs/api_result_state.dart';
import 'package:viet_wallet/data/models/category_model.dart';
import 'package:viet_wallet/utils/enum/api_error_result.dart';

class CategoryItemState implements ApiResultState {
  final bool isLoading;
  final ApiError _apiError;
  final List<CategoryModel>? listExCategory;
  final List<CategoryModel>? listCoCategory;

  CategoryItemState({
    this.isLoading = false,
    ApiError apiError = ApiError.noError,
    this.listExCategory,
    this.listCoCategory,
  }) : _apiError = apiError;

  @override
  ApiError get apiError => _apiError;
}

extension CategoryItemStateEx on CategoryItemState {
  CategoryItemState copyWith({
    bool? isLoading,
    ApiError? apiError,
    List<CategoryModel>? listExCategory,
    List<CategoryModel>? listCoCategory,
  }) =>
      CategoryItemState(
        isLoading: isLoading ?? this.isLoading,
        apiError: apiError ?? this.apiError,
        listExCategory: listExCategory ?? this.listExCategory,
        listCoCategory: listCoCategory ?? this.listCoCategory,
      );
}
