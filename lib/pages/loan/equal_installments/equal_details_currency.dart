import 'package:flutter/material.dart';

class EqualDetailsCurrency extends StatelessWidget {
  final String resultCurrency;
  final String symbolValue;
  final List<double> creditAmountCurrencyDetails;
  final List<double> interestPartCurrencyDetails;
  final List<double> capitalPartCurrencyDetails;
  final List<double> capitalToBeRepaidCurrencyDetails;

  const EqualDetailsCurrency({
    Key? key,
    required this.resultCurrency,
    required this.symbolValue,
    required this.creditAmountCurrencyDetails,
    required this.interestPartCurrencyDetails,
    required this.capitalPartCurrencyDetails,
    required this.capitalToBeRepaidCurrencyDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailsCurrency dataCurrency = DetailsCurrency(
      resultCurrency,
      symbolValue,
      creditAmountCurrencyDetails,
      interestPartCurrencyDetails,
      capitalPartCurrencyDetails,
      capitalToBeRepaidCurrencyDetails,
    );

    return Scaffold(
      backgroundColor: const Color(0xff0E1117),
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, bottom: 50.0),
        child: ListView(
          children: <Widget>[
            Theme(
              data: Theme.of(context).copyWith(
                cardColor: const Color(0xff0E1117),
                dividerColor: Colors.grey[600]!,
                dataTableTheme: const DataTableThemeData(
                  dividerThickness: 1,
                  dataTextStyle: TextStyle(fontSize: 15, color: Colors.white),
                  headingTextStyle: TextStyle(fontSize: 15, color: Colors.white),
                ),
                textTheme: const TextTheme(
                  bodyText2: TextStyle(color: Colors.white),
                ),
              ),
              child: PaginatedDataTable(
                source: dataCurrency,
                rowsPerPage: PaginatedDataTable.defaultRowsPerPage,
                arrowHeadColor: Colors.white,
                // columnSpacing: 100,
                // horizontalMargin: 60,
                columns: const <DataColumn>[
                  DataColumn(label: Text('Kwota kredytu')),
                  DataColumn(label: Text('Rata')),
                  DataColumn(label: Text('Cz. Odsetk.')),
                  DataColumn(label: Text('Cz. Kapit.')),
                  DataColumn(label: Text('Do spłaty')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsCurrency extends DataTableSource {
  String resultCurrency;
  String symbolValue;
  List<double> creditAmountCurrencyDetails;
  List<double> interestPartCurrencyDetails;
  List<double> capitalPartCurrencyDetails;
  List<double> capitalToBeRepaidCurrencyDetails;

  DetailsCurrency(
      this.resultCurrency,
      this.symbolValue,
      this.creditAmountCurrencyDetails,
      this.interestPartCurrencyDetails,
      this.capitalPartCurrencyDetails,
      this.capitalToBeRepaidCurrencyDetails,
      );

  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text('${creditAmountCurrencyDetails[index].toStringAsFixed(2)} $symbolValue')),
        DataCell(Text('$resultCurrency $symbolValue')),
        DataCell(Text('${interestPartCurrencyDetails[index].toStringAsFixed(2)} $symbolValue')),
        DataCell(Text('${capitalPartCurrencyDetails[index].toStringAsFixed(2)} $symbolValue')),
        DataCell(Text('${capitalToBeRepaidCurrencyDetails[index].toStringAsFixed(2)} $symbolValue')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => creditAmountCurrencyDetails.length;

  @override
  int get selectedRowCount => 0;
}
