import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:viet_wallet/utilities/enum/enum.dart';
import 'package:viet_wallet/utilities/enum/wallet_type.dart';

import '../network/model/frequency_model.dart';

bool isNotNullOrEmpty(dynamic obj) => !isNullOrEmpty(obj);

/// For String, List, Map
bool isNullOrEmpty(dynamic obj) =>
    obj == null ||
    ((obj is String || obj is List || obj is Map) && obj.isEmpty);

String formatterDouble(double value) {
  final formatter = NumberFormat("#,##0.00", "en_US");
  return formatter.format(value);
}

String formatterInt(int? value) {
  if (value == null) {
    return '0';
  }
  final formatter = NumberFormat("#,##0.00", "en_US");
  return formatter.format(value);
}

String formatterBalance(String str) {
  var result = NumberFormat.compact(locale: 'en').format(int.parse(str));
  if (result.contains('K') && result.length > 3) {
    result = result.substring(0, result.length - 1);
    var prefix = (result.split('.').last.length) + 1;
    var temp = (double.parse(result) * .001).toStringAsFixed(prefix);
    result = '${double.parse(temp)}M';
  }
  return result;
}

IconData getIconWallet({String? walletType}) {
  if (walletType == null) {
    return Icons.help_outline;
  }
  if (walletType == WalletAccountType.wallet.name) {
    return Icons.wallet;
  }
  if (walletType == WalletAccountType.bank.name) {
    return Icons.account_balance;
  }
  if (walletType == WalletAccountType.eWallet.name) {
    return Icons.local_atm;
  }
  return Icons.payment;
}

String getNameWalletType({String? walletType}) {
  if (walletType == WalletAccountType.wallet.name) {
    return 'Ví tiền mặt';
  }
  if (walletType == WalletAccountType.bank.name) {
    return 'Tài khoản ngân hàng';
  }
  if (walletType == WalletAccountType.eWallet.name) {
    return "Ví điện tử";
  }
  return "Khác";
}

String formatToLocaleVietnam(DateTime date) {
  return '${DateFormat.EEEE('vi').format(date)} - ${DateFormat('dd/MM/yyyy').format(date)}';
}

TransactionType getTransactionType(String transactionTypeString) {
  switch (transactionTypeString.toUpperCase()) {
    case 'EXPENSE':
      return TransactionType.expense;
    case 'INCOME':
      return TransactionType.income;
    default:
      // Handle unrecognized transaction type if needed
      throw Exception('Invalid transaction type: $transactionTypeString');
  }
}

FrequencyType getFrequencyType(String frequencyTypeString) {
  switch (frequencyTypeString.toUpperCase()) {
    case 'DAILY':
      return FrequencyType.daily;
    case 'WEEK':
      return FrequencyType.week;
    case 'MONTHLY':
      return FrequencyType.monthly;
    case 'QUARTERLY':
      return FrequencyType.quarterly;
    case 'YEARLY':
      return FrequencyType.yearly;
    case 'WEEKDAY':
      return FrequencyType.weekday;
    default:
      // Handle unrecognized frequency type if needed
      throw Exception('Invalid frequency type: $frequencyTypeString');
  }
}

setFrequencyType(FrequencyType type) {
  if (type == FrequencyType.daily) {
    return FrequencyType.daily.name.toUpperCase();
  } else if (type == FrequencyType.week) {
    return FrequencyType.week.name.toUpperCase();
  } else if (type == FrequencyType.monthly) {
    return FrequencyType.monthly.name.toUpperCase();
  } else if (type == FrequencyType.quarterly) {
    return FrequencyType.quarterly.name.toUpperCase();
  } else if (type == FrequencyType.yearly) {
    return FrequencyType.yearly.name.toUpperCase();
  } else if (type == FrequencyType.weekday) {
    return FrequencyType.weekday.name.toUpperCase();
  }
}

List<DayOfWeek> getDayOfWeekListFromStrings(List<String> dayInWeeks) {
  List<DayOfWeek> dayOfWeekList = [];

  for (String dayOfWeekString in dayInWeeks) {
    switch (dayOfWeekString.toUpperCase()) {
      case 'MONDAY':
        dayOfWeekList.add(DayOfWeek(1, 'Thứ 2', 'Monday'));
        break;
      case 'TUESDAY':
        dayOfWeekList.add(DayOfWeek(2, 'Thứ 3', 'Tuesday'));
        break;
      case 'WEDNESDAY':
        dayOfWeekList.add(DayOfWeek(3, 'Thứ 4', 'Wednesday'));
        break;
      case 'THURSDAY':
        dayOfWeekList.add(DayOfWeek(4, 'Thứ 5', 'Thursday'));
        break;
      case 'FRIDAY':
        dayOfWeekList.add(DayOfWeek(5, 'Thứ 6', 'Friday'));
        break;
      case 'SATURDAY':
        dayOfWeekList.add(DayOfWeek(6, 'Thứ 7', 'Saturday'));
        break;
      case 'SUNDAY':
        dayOfWeekList.add(DayOfWeek(7, 'Chủ nhật', 'Sunday'));
        break;
      default:
        // Handle invalid day of the week if needed
        break;
    }
  }

  return dayOfWeekList;
}

String getTitleByFrequencyType(FrequencyType frequencyType) {
  Frequency? frequency = listFrequency.firstWhere(
    (freq) => freq.frequencyType == frequencyType,
  );

  return frequency.title;
}

Frequency getFrequencyByType(FrequencyType frequencyType) {
  return listFrequency.firstWhere(
    (frequency) => frequency.frequencyType == frequencyType,
    orElse: () => Frequency(
      title: 'Hàng ngày',
      frequencyType: FrequencyType.daily,
    ), // Default value if no match is found
  );
}

String getListDayName(List<DayOfWeek>? listDayOfWeek) {
  List<DayOfWeek> listDay = listDayOfWeek ?? [];
  String listDayName = '';
  listDay.sort((a, b) => a.index.compareTo(b.index));
  List<String> titles = listDay.map((day) => day.title).toList();

  if (listDay.length == 7) {
    listDayName = 'Tất cả các ngày trong tuần';
  } else {
    listDayName = titles.join(', ');
  }
  return listDayName;
}

String getDateTimeFormat(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}
