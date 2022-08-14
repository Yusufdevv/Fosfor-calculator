import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutMaker extends StatelessWidget {
  const AboutMaker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("CopyRight by "),
        IconButton(
            onPressed: () async {
              const url = "https:/t.me/Yusufdevv";

              if (await canLaunch(url)) {
                await launch(url);
              }
            },
            icon: const Icon(
              Icons.telegram,
              color: Colors.blue,
            )),
        const Text(
          "@Yusufdevv",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
