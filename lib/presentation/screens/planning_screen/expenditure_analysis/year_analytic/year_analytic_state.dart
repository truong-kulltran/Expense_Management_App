import 'package:viet_wallet/business/blocs/api_result_state.dart';
import 'package:viet_wallet/data/models/analytic_model.dart';
import 'package:viet_wallet/utils/enum/api_error_result.dart';

class YearAnalyticState implements ApiResultState {
  final bool isLoading;
  final ApiError _apiError;
  final AnalyticModel? data;

  YearAnalyticState({
    this.isLoading = false,
    ApiError apiError = ApiError.noError,
    this.data,
  }) : _apiError = apiError;

  @override
  ApiError get apiError => _apiError;
}

extension YearAnalyticStateEx on YearAnalyticState {
  YearAnalyticState copyWith({
    bool? isLoading,
    ApiError? apiError,
    AnalyticModel? data,
  }) =>
      YearAnalyticState(
        isLoading: isLoading ?? this.isLoading,
        apiError: apiError ?? this.apiError,
        data: data ?? this.data,
      );
}
