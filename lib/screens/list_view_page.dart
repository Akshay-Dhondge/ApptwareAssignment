import 'dart:convert';
import 'dart:developer';
import 'package:assignment/constants/strings.dart';
import 'package:assignment/controllers/controller.dart';
import 'package:assignment/models/sample_data.dart';
import 'package:assignment/screens/user_details_page.dart';
import 'package:assignment/utilities/internet_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  final controller = Get.put(Controller());
  bool _loading = false;
  List<User> _users = [];
  final ScrollController _scrollController = ScrollController();
  int pageNumber = 1;
  late InternetConnectivity _internetConnectivity;
  bool isInternetConnected = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    _internetConnectivity = InternetConnectivity();
    _internetConnectivity
        .isInternetConnectivityAvailable()
        .then((onValue) async {
      isInternetConnected = onValue;
      if (onValue) {
        showProgressDialog();
        callGetSampleDataListApi(pageNumber);
      } else {
        final prefs = await SharedPreferences.getInstance();
        String usersData = prefs.getString(AppStrings().userData) ?? "";
        if (usersData != "") {
          List tempList = jsonDecode(usersData);
          tempList.forEach((element) {
            _users.add(User.fromJson(element));
          });
        }

        setState(() {});
      }
    });
  }

  void showProgressDialog() {
    setState(() {
      _loading = true;
    });
  }

  void hideProgressDialog() {
    setState(() {
      _loading = false;
    });
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0 &&
        !controller.hasReachedEndOfResults) {
      pageNumber++;
      callGetSampleDataListApi(pageNumber);
    }

    return false;
  }

  int _calculateListItemCount() {
    if (!isInternetConnected) {
      return _users.length;
    }
    if (controller.hasReachedEndOfResults) {
      return _users.length;
    } else {
      return _users.length + 1;
    }
  }

  callGetSampleDataListApi(int pageNumber) async {
    controller.refresh();
    await controller.getSampleData(pageNumber: pageNumber);
    hideProgressDialog();
    controller.sampleDataModel.isNotEmpty ? setSampleData() : null;
  }

  setSampleData() async {
    String userData = jsonEncode(controller.sampleDataModel);
    _users.addAll(controller.sampleDataModel);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(AppStrings().userData, userData);
  }

  ///DATA VARIABLES
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.1),
        titleSpacing: 0,
        title: Text(AppStrings().userList,
            style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ),
      body: isInternetConnected || _users.isNotEmpty
          ? buildUserList()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(AppStrings().noInternetMessage,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
            ),
    );
  }

  buildUserList() {
    return Column(
      children: [
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: ListView.separated(
              itemCount: _calculateListItemCount(),
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return index >= _users.length
                    ? _buildLoaderListItem()
                    : buildNewUserTile(index);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 12,
                );
              },
              padding: const EdgeInsets.all(10),
            ),
          ),
        ),
      ],
    );
  }

  buildNewUserTile(int index) {
    return GestureDetector(
      onTap: () {
        Get.to(UserDetailsPage(
          user: _users[index],
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 10,
                offset: const Offset(2, 2),
              ),
            ]),
        child: Row(
          children: [
            isInternetConnected
                ? Image.network(
                    _users[index].picture!,
                    width: 84,
                    height: 84,
                    errorBuilder: (context, _, StackTrace? stackTrace) =>
                        const Icon(Icons.error,
                            size: 84, color: Colors.black26),
                  )
                : const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage('images/account.png')),
                  ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${_users[index].title} ${_users[index].firstName} ${_users[index].lastName}',
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
                      _users[index].picture!,
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
          ],
        ),
      ),
    );
  }

  Widget _buildLoaderListItem() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
