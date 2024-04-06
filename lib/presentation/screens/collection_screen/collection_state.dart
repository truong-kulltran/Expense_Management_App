import 'package:equatable/equatable.dart';
import 'package:viet_wallet/data/models/wallet.dart';

// class NewsCollectionState implements ApiResultState {
//   final bool isLoading;
//   final ApiError _apiError;
//   final List<Wallet>? listWallet;
//
//   NewsCollectionState({ApiError apiError = ApiError.noError, this.isLoading = false, this.listWallet}) : _apiError = apiError;
//
//   @override
//   ApiError get apiError => _apiError;
// }
//
// extension NewCollectionStateExtension on NewsCollectionState {
//   NewsCollectionState copyWith({bool? isLoading, ApiError? apiError, List<Wallet>? listWallet}) => NewsCollectionState(
//         isLoading: isLoading ?? this.isLoading,
//         apiError: apiError ?? this.apiError,
//         listWallet: listWallet ?? this.listWallet,
//       );
// }

abstract class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object> get props => [];
}

class InitializedState extends CollectionState {
  final List<Wallet> listWallet;

  const InitializedState({required this.listWallet});

  @override
  List<Object> get props => [listWallet];
}

class LoadingState extends CollectionState {}

class SuccessState extends CollectionState {
  final String fromEvent;

  const SuccessState({required this.fromEvent});
  @override
  List<Object> get props => [fromEvent];
}

class FailureState extends CollectionState {
  final String errorMessage;

  const FailureState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
