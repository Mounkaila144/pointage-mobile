import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_face_api_beta/face_api.dart' as Regula;
import 'package:loading_animations/loading_animations.dart';
import 'package:mobile/Page/ENteSortir.dart';
import 'package:mobile/Page/message.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Auth/exceptions/form_exceptions.dart';
import '../Auth/services/Crud.dart';
import '../Auth/services/helper_service.dart';
import '../Page/theme.dart';


class FacePage extends StatefulWidget {
  @override
  _FacePageState createState() => _FacePageState();
  Future<void> FaceUrl() async {
   await  _FacePageState().facedetecturl();
  }
}

class _FacePageState extends State<FacePage> {
  static final HttpWithMiddleware https =
  HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  Future<String> fetchEmployee1() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var id = _prefs.getInt('id');
    final response = await https.get(
      HelperService.buildUri("employees/$id"),
    );

    final statusType = (response.statusCode);
    switch (statusType) {
      case 200:
        final user=employee1FromJson(response.body);
        return user.imageName;
      case 400:
        final json = jsonDecode(response.body);
        throw handleFormErrors(json);
      case 300:
      case 500:
      default:
        throw FormGeneralException(message: 'Error contacting the server!');
    }
  }



  var image1 = new Regula.MatchFacesImage();
  var image2 = new Regula.MatchFacesImage();
  var img1 = Image.asset('assets/images/portrait.png');
  var img2 = Image.asset('assets/images/portrait.png');
  int _similarity = 0;
  String _liveness = "nil";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await facedetecturl();
      await afficheCamera();
      await matchFaces();
    });
    initPlatformState();
  }
  push(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Porte()));

  }
  Future<String?> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }
  Future<void> facedetecturl() async {
    var name= await fetchEmployee1();
    //ByteData bytes=(await Image.network("https://192.168.43.219:8000/image/face/$name")) as ByteData;
    //var buffer= await bytes.buffer;
    //var m= await base64.encode(Uint8List.view(buffer));
    final m = await networkImageToBase64("https://192.168.43.219:8000/image/face/$name");
    print(m);
    return await setImage(
        true,
        base64Decode(
            m!
        ),
        Regula.ImageType.LIVE);
  }

  Future<void> afficheCamera() async {
    return await Regula.FaceSDK.presentFaceCaptureActivity().then((result) =>
        setImage(
            false,
            base64Decode(
                Regula
                    .FaceCaptureResponse
                    .fromJson(json.decode(result))
                !.image
                !.bitmap
                !.replaceAll("\n", "")
            ),
            Regula.ImageType.LIVE));
  }

  Future<void> initPlatformState() async {}

  showAlertDialog(BuildContext context, bool first) => showDialog(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(title: Text("Select option"), actions: [
            // ignore: deprecated_member_use
            FlatButton(
                child: Text("Use gallery"),
                onPressed: () async {
                  ByteData bytes=await rootBundle.load('assets/images/mkl.jpg');
                  var buffer=bytes.buffer;
                  var m=base64.encode(Uint8List.view(buffer));
                  setImage(
                      first,
                      base64Decode(
                          m
                      ),
                      Regula.ImageType.LIVE);
                  Navigator.pop(context);
                }),
            // ignore: deprecated_member_use
            FlatButton(
                child: Text("Use camera"),
                onPressed: () {
                  Regula.FaceSDK.presentFaceCaptureActivity().then((result) =>
                      setImage(
                          first,
                          base64Decode(
                              Regula
                                  .FaceCaptureResponse
                                  .fromJson(json.decode(result))
                                  !.image
                                  !.bitmap
                                  !.replaceAll("\n", "")
                          ),
                          Regula.ImageType.LIVE));
                  Navigator.pop(context);
                })
          ]));

  setImage(bool first, List<int> imageFile, int type) {
    if (imageFile == null) return;
    setState(() => _similarity = 0);
    if (first) {
      image1.bitmap = base64Encode(imageFile);
      image1.imageType = type;
    } else {
      image2.bitmap = base64Encode(imageFile);
      image2.imageType = type;
      setState(() => img2 = Image.memory(imageFile as Uint8List));
    }
  }

  clearResults() {
    setState(() {
      img1 = Image.asset('assets/images/portrait.png');
      img2 = Image.asset('assets/images/portrait.png');
      _similarity = 0;
      _liveness = "nil";
    });
    image1 = new Regula.MatchFacesImage();
    image2 = new Regula.MatchFacesImage();
  }

  matchFaces() {
    if (image1 == null ||
        image1.bitmap == null ||
        image1.bitmap == "" ||
        image2 == null ||
        image2.bitmap == null ||
        image2.bitmap == "") return;
    setState(() => _similarity = 1);
    var request = new Regula.MatchFacesRequest();
    request.images = [image1, image2];
    Regula.FaceSDK.matchFaces(jsonEncode(request)).then((value) {
      var response = Regula.MatchFacesResponse.fromJson(json.decode(value));
      Regula.FaceSDK.matchFacesSimilarityThresholdSplit(
          jsonEncode(response?.results), 0.75)
          .then((str) {
        var split = Regula.MatchFacesSimilarityThresholdSplit.fromJson(
            json.decode(str));
        setState(() => _similarity = split!.matchedFaces.length > 0
            ? ((split.matchedFaces[0]!.similarity! * 100)).toInt()
            : 3);
      });
    });
  }

  liveness() => Regula.FaceSDK.startLiveness().then((value) {
    var result = Regula.LivenessResponse.fromJson(json.decode(value));
    setImage(true, base64Decode(result!.bitmap!.replaceAll("\n", "")),
        Regula.ImageType.LIVE);
    setState(() => _liveness = result.liveness == 0 ? "passed" : "unknown");
  });

  Widget createButton(String text, VoidCallback onPress) => Container(
    // ignore: deprecated_member_use
    child: FlatButton(
        color: Color.fromARGB(50, 10, 10, 10),
        onPressed: onPress,
        child: Text(text)),
    width: 250,
  );

  Widget createImage(image, VoidCallback onPress) => Material(
      child: InkWell(
        onTap: onPress,
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(height: 150, width: 150, image: image),
          ),
        ),
      ));

  @override
  Widget build(BuildContext context) => Scaffold(
    body:(_similarity==1 || _similarity==0)?
    themejolie(donner: Center(
      child: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          LoadingJumpingLine.circle(
            borderColor: Colors.red,
            borderSize: 3.0,
            size: 200.0,
            backgroundColor: Colors.yellow,
            duration: Duration(milliseconds: 500),
          ),
        ],
      ),
    ),):(_similarity>90?MessageSucces() :(Messagepointage()))
  ,

  );
}
