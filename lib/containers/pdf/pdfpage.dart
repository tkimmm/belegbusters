import 'package:flutter/material.dart';
import 'package:belegbusters/containers/pdf/pdfbuilder.dart';

class PdfPageTest extends StatelessWidget {
  @override
  Widget layout(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: FlatButton(shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
            ),
            child: Text(
              'View Report',
            ),
            color: Colors.orange,
            onPressed: () {
              reportView(context);
            },)),
        Expanded(child: FlatButton(shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
            ),
            child: Text(
              'Print Report',
            ),
            color: Colors.orange,
            onPressed: () {
              reportView(context);
            },)),
        Expanded(child: FlatButton(shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
            ),
            child: Text(
              'Placeholder',
            ),
            color: Colors.orange,
            onPressed: () {
              reportView(context);
            },)),
      ],
    );
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: layout(context),
      ),
    );
  }
}
