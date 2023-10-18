import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const MyHomePage(),
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ar', 'SA')],
        locale: const Locale("ar"));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = '';
  TextEditingController? _controller;
  AudioCache? audioCache;

  @override
  void initState() {
    super.initState();
    audioCache = AudioCache();
    audioCache!.play('audio/pray.mp3');
    _controller = TextEditingController()
      ..addListener(() {
        text = _controller!.text;
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.black,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  height: size.height,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: size.height * .95,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                height: size.height * .18,
                              ),
                              Image.asset(
                                'assets/images/header.jpg',
                                height: size.height * .18,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 6),
                            child: TextFormField(
                                onChanged: (val) {
                                  text = val
                                      .replaceAll('ة', 'ه')
                                      .replaceAll('ي.', 'ی.')
                                      .replaceAll('ي،', 'ی،')
                                      .replaceAll('ي"', 'ی"')
                                      .replaceAll('ي)', 'ی)')
                                      .replaceAll('ي ', 'ی ')
                                      .replaceAll(
                                          'ي', val.endsWith('ي') ? 'ی ' : 'ٮ')
                                      .replaceAll('ب', 'ٮ')
                                      .replaceAll('ت', 'ٮ')
                                      .replaceAll('ث', 'ٮ')
                                      .replaceAll('ج', 'ح')
                                      .replaceAll('خ', 'ح')
                                      .replaceAll('ك', 'ک')
                                      .replaceAll('ق', 'ٯ')
                                      .replaceAll('ف', 'ڡ')
                                      .replaceAll('ذ', 'د')
                                      .replaceAll('ز', 'ر')
                                      .replaceAll('ي', 'ٮ')
                                      .replaceAll('ش', 'س')
                                      .replaceAll('ض', 'ص')
                                      .replaceAll('ظ', 'ط')
                                      .replaceAll('غ', 'ع')
                                      .replaceAll('أ', 'ا')
                                      .replaceAll('إ', 'ا')
                                      .replaceAll('إ', 'ا')
                                      .replaceAll('ن', 'ں');
                                  _controller!.text = text;
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: 'الصق النص هنا'),
                                maxLines: 6),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 6),
                            child: TextFormField(
                                controller: _controller,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: 'الںص الٮدٮل'),
                                maxLines: 6),
                          ),
                          CupertinoButton(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 40),
                              color: Colors.black45,
                              child: const Text(
                                'انسخ النص',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              onPressed: () async {
                                audioCache!.play('audio/pray.mp3');

                                await Clipboard.setData(
                                    ClipboardData(text: text));
                                Toast.show('تم نسخ النص بنجاح.',
                                    duration: Toast.lengthShort,
                                    gravity: Toast.bottom);

                                // copied successfully
                              }),
                          Expanded(child: SizedBox()),
                          Image.asset(
                            'assets/images/footer.png',
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
