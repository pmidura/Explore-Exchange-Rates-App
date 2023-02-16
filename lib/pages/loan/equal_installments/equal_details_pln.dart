import 'package:flutter/material.dart';

class EqualDetailsPLN extends StatelessWidget {
  final String resultPLN;
  final List<double> creditAmountPlnDetails;
  final List<double> interestPartPlnDetails;
  final List<double> capitalPartPlnDetails;
  final List<double> capitalToBeRepaidPlnDetails;

  const EqualDetailsPLN({
    Key? key,
    required this.resultPLN,
    required this.creditAmountPlnDetails,
    required this.interestPartPlnDetails,
    required this.capitalPartPlnDetails,
    required this.capitalToBeRepaidPlnDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailsPLN dataPLN = DetailsPLN(
      resultPLN,
      creditAmountPlnDetails,
      interestPartPlnDetails,
      capitalPartPlnDetails,
      capitalToBeRepaidPlnDetails,
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
                source: dataPLN,
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

class DetailsPLN extends DataTableSource {
  String resultPLN;
  List<double> creditAmountPlnDetails;
  List<double> interestPartPlnDetails;
  List<double> capitalPartPlnDetails;
  List<double> capitalToBeRepaidPlnDetails;

  DetailsPLN(
      this.resultPLN,
      this.creditAmountPlnDetails,
      this.interestPartPlnDetails,
      this.capitalPartPlnDetails,
      this.capitalToBeRepaidPlnDetails,
      );

  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text('${creditAmountPlnDetails[index].toStringAsFixed(2)} zł')),
        DataCell(Text('$resultPLN zł')),
        DataCell(Text('${interestPartPlnDetails[index].toStringAsFixed(2)} zł')),
        DataCell(Text('${capitalPartPlnDetails[index].toStringAsFixed(2)} zł')),
        DataCell(Text('${capitalToBeRepaidPlnDetails[index].toStringAsFixed(2)} zł')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => creditAmountPlnDetails.length;

  @override
  int get selectedRowCount => 0;
}
