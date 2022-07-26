import 'package:assignment/constants/strings.dart';
import 'package:assignment/models/sample_data.dart';
import 'package:assignment/utilities/internet_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailsPage extends StatefulWidget {
  User? user;
  UserDetailsPage({Key? key, this.user}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late double width;
  late double height;
  bool? isInternetConnected;
  final InternetConnectivity _internetConnectivity = InternetConnectivity();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _internetConnectivity.isInternetConnectivityAvailable().then((onValue) {
        isInternetConnected = onValue;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.1),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: Colors.black,
            size: 32,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        title: Text(AppStrings().userDetails,
            style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ),
      body: buildUserDataWidget(),
    );
  }

  Widget buildUserDataWidget() {
    String imageUrl = widget.user!.picture ?? "";
    return Column(
      children: [
        isInternetConnected != null && isInternetConnected!
            ? Image.network(
                imageUrl,
                width: width * 0.4,
                errorBuilder: (context, _, StackTrace? stackTrace) =>
                    const Icon(Icons.error, size: 84, color: Colors.black26),
              )
            : const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage('images/account.png')),
              ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${widget.user!.title} ${widget.user!.firstName} ${widget.user!.lastName}',
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.user!.picture!,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}
