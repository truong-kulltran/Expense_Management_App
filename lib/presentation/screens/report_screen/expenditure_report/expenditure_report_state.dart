import 'package:viet_wallet/business/blocs/api_result_state.dart';
import 'package:viet_wallet/data/models/category_report_model.dart';
import 'package:viet_wallet/utils/enum/api_error_result.dart';

class ExpenditureReportState implements ApiResultState {
  final bool isLoading;
  final ApiError _apiError;
  final List<CategoryReportModel>? listReport;

  ExpenditureReportState({
    this.isLoading = true,
    ApiError apiError = ApiError.noError,
    this.listReport
  }) : _apiError = apiError;

  @override
  ApiError get apiError => _apiError;

  ExpenditureReportState copyWith({
    bool? isLoading,
    ApiError? apiError,
    List<CategoryReportModel>? listReport
  }) =>
      ExpenditureReportState(
        isLoading: isLoading ?? this.isLoading,
        apiError: apiError ?? this.apiError,
        listReport: listReport ?? this.listReport,
      );
}
