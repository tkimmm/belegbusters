import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';

class RFIDReader extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<RFIDReader> {
  // _stream is a subscription to the stream returned by `NFC.read()`.
  // The subscription is stored in state so the stream can be canceled later
  StreamSubscription<NDEFMessage> _stream;
  // _tags is a list of scanned tags
  List<NDEFMessage> _tags = [];
  bool _supportsNFC = false;
  // Errors are unlikely to happen on Android unless the NFC tags are
  // poorly formatted or removed too soon, however on iOS at least one
  // error is likely to happen. NFCUserCanceledSessionException will
  // always happen unless you call readNDEF() with the `throwOnUserCancel`
  // argument set to false.
  // NFCSessionTimeoutException will be thrown if the session timer exceeds
  // 60 seconds (iOS only).
  // And then there are of course errors for unexpected stuff. Good fun!
  // _readNFC() calls `NFC.readNDEF()` and stores the subscription and scanned
  // tags in state
  void _readNFC(BuildContext context) {
    try {
      // ignore: cancel_subscriptions
      StreamSubscription<NDEFMessage> subscription =
          NFC.readNDEF().listen((tag) {
        print(tag.payload);
        setState(() {
          _tags.insert(0, tag);
          _stopReading();
        });
      }, onDone: () {
        setState(() {
          _stream = null;
        });
      }, onError: (e) {
        setState(() {
          _stream = null;
        });
        if (!(e is NFCUserCanceledSessionException)) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Error!"),
              content: Text(e.toString()),
            ),
          );
        }
      });

      setState(() {
        _stream = subscription;
      });
    } catch (err) {
      print("error: $err");
    }
  }

  void _stopReading() {
    _stream?.cancel();
    setState(() {
      _stream = null;
    });
  }

  @override
  void initState() {
    super.initState();
    NFC.isNDEFSupported.then((supported) {
      setState(() {
        _supportsNFC = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _stream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text(
            'NFC Receipt Scanning',
            style: TextStyle(fontSize: 14.0, color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white12,
          actions: <Widget>[],
        ),
        body: ListView.builder(
          itemCount: _tags.length,
          itemBuilder: (context, index) {
            const TextStyle payloadTextStyle = const TextStyle(
              fontSize: 15,
              color: const Color(0xFF454545),
            );
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Builder(
                    builder: (context) {
                      // Build list of records
                      List<Widget> records = [];
                      for (int i = 0; i < _tags[index].records.length; i++) {
                        records.add(Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Transaction ${i + 1} - ${_tags[index].records[i].type}",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF666666),
                              ),
                            ),
                            Text(
                              _tags[index].records[i].payload.toString(),
                              style: payloadTextStyle,
                            )
                            // Text(
                            //   _tags[index].records[i].data,
                            //   style: payloadTextStyle,
                            // ),
                          ],
                        ));
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: records,
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 50.0,
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) {
            if (!_supportsNFC) {
              return FlatButton(
                child: Text("NFC unsupported"),
                onPressed: null,
              );
            }
            return FloatingActionButton(
              child: _stream == null ? Icon(Icons.add) : Icon(Icons.swap_horiz),
              backgroundColor: Colors.orange,
              onPressed: () {
                if (_stream == null) {
                  _readNFC(context);
                } else {
                  _stopReading();
                }
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
