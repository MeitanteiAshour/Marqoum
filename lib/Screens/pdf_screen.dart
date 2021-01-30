import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marqoum/Screens/bookmark.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class PDFScreen extends StatefulWidget {
  final int index;
  PDFScreen({this.index});
  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  int index;
  PdfController pdfController;

  int currentPage = 0;
  double _opacity = 1;
  @override
  void initState() {
    pdfController = PdfController(
      document: PdfDocument.openAsset('assets/legends.pdf'),
      initialPage: 10,
      viewportFraction: 1.3
    );
    Future.delayed(
        Duration(milliseconds: 100),
        () => pdfController.animateToPage(10,
            duration: Duration(milliseconds: 500), curve: Curves.ease));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xff26292D),
          child: RepaintBoundary(
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: GestureDetector(
                    onTap: () => setState(
                        () => _opacity == 0 ? _opacity = 1 : _opacity = 0),
                    child: PdfView(
                      controller: pdfController,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 150,
                  child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(seconds: 1),
                    child: Container(
                      width: 90,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FaIcon(
                              FontAwesomeIcons.clipboardList,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          Material(
                            type: MaterialType.transparency,
                            child: Text(
                              'ملاحظة',
                              style: TextStyle(
                                color: Color(0xff493628),
                                fontFamily: 'NeoSans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffd49448),
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.elliptical(20, 20),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 250,
                  child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(seconds: 1),
                    child: Container(
                      width: 90,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FaIcon(
                              FontAwesomeIcons.shareSquare,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          Material(
                            type: MaterialType.transparency,
                            child: Text(
                              'مشاركة',
                              style: TextStyle(
                                color: Color(0xff493628),
                                fontFamily: 'NeoSans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffd49448),
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.elliptical(20, 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
