import 'package:flutter/material.dart';
import 'package:web_socket_app/model/currency_model.dart';

TableRow currencyTitleRow() => const TableRow(
      children: [
        Text(
          "Name",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          "Quantity",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          "Price",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          "Time",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );

TableRow currencyValuesRow({
  required CurrenyModel currency,
}) =>
    TableRow(
      children: [
        Text(
          currency.name.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        Text(currency.quantity.toString()),
        Text(currency.price.toString()),
        Text(currency.time.toString()),
      ],
    );
