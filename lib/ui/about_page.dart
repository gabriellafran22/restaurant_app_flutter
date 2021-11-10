import 'package:flutter/material.dart';
import 'package:restaurant_app/widgets/custom_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  static const routeName = '/about_page';

  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleText('About'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText(
                'About App',
              ),
              const SizedBox(height: 10),
              contentText(
                  'This is an app that shows a list of restaurants. It is build using flutter with the purpose of '
                  'a submission project to learn the fundamentals of using flutter.\n'
                  'Last Updated on 9 November 2021.'),
              const SizedBox(height: 20),
              titleText(
                'Creator Profile',
              ),
              const SizedBox(height: 10),
              contentText(
                  'Hi, my name is Gabriella and I developed this app for a submission project and also for fun. '
                  'I am really interested in native android (kotlin) & multi-platform app development (flutter). '
                  'Currently, I am still learning and really hope that I could master both flutter and kotlin language 😊.'),
              const SizedBox(height: 40),
              titleText(
                'Find me or reach out to me on:',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ContactImg(
                      url: 'mailto:gabriellafranchesca22@gmail.com',
                      imgLocation: 'assets/images/gmail_logo.png',
                      context: context),
                  ContactImg(
                      url: 'https://www.instagram.com/gabriellafran22',
                      imgLocation: 'assets/images/instagram_logo.png',
                      context: context),
                  ContactImg(
                      url:
                          'https://www.linkedin.com/in/gabriella-franchesca-8066b81a0/',
                      imgLocation: 'assets/images/linkedin_logo.png',
                      context: context),
                  ContactImg(
                      url: 'https://github.com/gabriellafran22',
                      imgLocation: 'assets/images/github_logo.png',
                      context: context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactImg extends StatelessWidget {
  final String url;
  final String imgLocation;
  final BuildContext context;

  const ContactImg(
      {Key? key,
      required this.url,
      required this.imgLocation,
      required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, right: 30.0),
      child: InkWell(
        onTap: openURL,
        child: Image.asset(
          imgLocation,
          height: 50,
          width: 50,
        ),
      ),
    );
  }

  void openURL() async => await canLaunch(url)
      ? await launch(url)
      : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Supported App to open $url not found"),
        ));
}
