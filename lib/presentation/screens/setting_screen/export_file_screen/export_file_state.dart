import 'package:equatable/equatable.dart';
import 'package:viet_wallet/data/models/wallet.dart';

abstract class ExportState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends ExportState {}

class ErrorServerState extends ExportState {}

class ErrorInternetState extends ExportState {}

class ExportInitial extends ExportState {
  final List<Wallet> listWallet;

  ExportInitial({required this.listWallet});

  @override
  List<Object> get props => [listWallet];
}

class ExportFileState extends ExportState {}
