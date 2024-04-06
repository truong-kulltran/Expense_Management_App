import 'package:viet_wallet/business/blocs/api_result_state.dart';
import 'package:viet_wallet/data/models/wallet.dart';
import 'package:viet_wallet/utils/enum/api_error_result.dart';

class CurrentFinancesState implements ApiResultState {
  final ApiError _apiError;
  final bool isLoading;
  final List<Wallet>? listWallet;

  CurrentFinancesState({
    ApiError apiError = ApiError.noError,
    this.isLoading = true,
    this.listWallet,
  }) : _apiError = apiError;

  @override
  ApiError get apiError => _apiError;
}

extension CurrentFinancesEx on CurrentFinancesState {
  CurrentFinancesState copyWith({
    ApiError? apiError,
    bool? isLoading,
    List<Wallet>? listWallet,
  }) =>
      CurrentFinancesState(
        apiError: apiError ?? this.apiError,
        isLoading: isLoading ?? this.isLoading,
        listWallet: listWallet ?? this.listWallet,
      );
}
