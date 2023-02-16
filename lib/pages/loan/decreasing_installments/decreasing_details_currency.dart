import 'package:flutter/material.dart';

class DecreasingDetailsCurrency extends StatelessWidget {
  final List<double> creditAmountCurrencyDetails;
  final List<double> installmentsCurrencyDetails;
  final List<double> interestPartCurrencyDetails;
  final String capitalCurrencyDetails;
  final String symbolValue;
  final List<double> capitalToBeRepaidCurrencyDetails;

  const DecreasingDetailsCurrency({
    Key? key,
    required this.creditAmountCurrencyDetails,
    required this.installmentsCurrencyDetails,
    required this.interestPartCurrencyDetails,
    required this.capitalCurrencyDetails,
    required this.symbolValue,
    required this.capitalToBeRepaidCurrencyDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailsCurrency dataCurrency = DetailsCurrency(
      creditAmountCurrencyDetails,
      installmentsCurrencyDetails,
      interestPartCurrencyDetails,
      capitalCurrencyDetails,
      symbolValue,
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
  List<double> creditAmountCurrencyDetails;
  List<double> installmentsCurrencyDetails;
  List<double> interestPartCurrencyDetails;
  String capitalCurrencyDetails;
  String symbolValue;
  List<double> capitalToBeRepaidCurrencyDetails;

  DetailsCurrency(
      this.creditAmountCurrencyDetails,
      this.installmentsCurrencyDetails,
      this.interestPartCurrencyDetails,
      this.capitalCurrencyDetails,
      this.symbolValue,
      this.capitalToBeRepaidCurrencyDetails,
      );

  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text('${creditAmountCurrencyDetails[index].toStringAsFixed(2)} $symbolValue')),
        DataCell(Text('${installmentsCurrencyDetails[index].toStringAsFixed(2)} $symbolValue')),
        DataCell(Text('${interestPartCurrencyDetails[index].toStringAsFixed(2)} $symbolValue')),
        DataCell(Text('$capitalCurrencyDetails $symbolValue')),
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
