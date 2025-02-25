
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:urban_forest/provider/account_provider.dart';
import 'package:urban_forest/provider/user.dart';
import 'package:urban_forest/reusable_widgets/reusable_methods.dart';
import 'package:urban_forest/utils/reference.dart';
import 'package:urban_forest/view/main_function/profile/user_profile.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({ Key? key, required this.model }) : super(key: key);

  final AccountModel model;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  UserAccount user = UserAccount();

  @override
  void initState() {
    super.initState();
  }

  getUser() async {
    await widget.model.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.green, // primary color
      ),
      child: SimpleSettingsTile(
        title: 'Account Setting',
        subtitle: 'Privacy, Account, Searching',
        leading: settingIcon(Icons.settings, Colors.green),
        child: SettingsScreen(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SettingsGroup(
                title: "General", 
                children: [
                  Theme(
                    data: ThemeData(
                      primarySwatch: Colors.green, // primary color
                    ),
                    child: buildPrivacy()
                  ),
                  const SizedBox(height: 12,),
                  buildPlantPP(),
                  const SizedBox(height: 12,),
                  buildProfile()
                ]
              ),
            ),
    
            const SizedBox(height: 28,),
            (globalLevel > 1) ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SettingsGroup(
                title: "System Setting", 
                children: [
                  buildAdvancedSettings()
                ]
              ),
            ) : Container()
          ]
        ),
      ),
    );
  }

  Widget buildPrivacy() => SimpleSettingsTile(
    title: 'Privacy Policy',
    subtitle: '',
    leading: settingIcon(Icons.privacy_tip, Colors.amber),
    child: SettingsScreen(
      title: "Privacy Policy",
      children:[
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: privacyPolicy(),
        )
      ]
    ),
  ); 
  Widget buildPlantPP() => SimpleSettingsTile(
    title: 'About Pl@ntNet AI',
    subtitle: '',
    leading: settingIcon(Icons.grass, Colors.green),
    child: SettingsScreen(
      title: "AI Terms Of Use",
      children:[
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: plantNetpp()
        )
      ]
    ),
  ); 

  Widget buildProfile() => SimpleSettingsTile(
    title: 'User Profile',
    subtitle: '',
    leading: settingIcon(Icons.person, Colors.blueAccent),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(model: widget.model,),
        )
      );
    },
  );

  Widget buildAdvancedSettings() =>  ExpandableSettingsTile(
    leading: const Icon(Icons.developer_mode),
    expanded: true,
    title: 'Advanced Setting',
    subtitle: 'Upload method',
    children: <Widget>[
      CheckboxSettingsTile(
        leading: const Icon(Icons.upload),
        settingKey: 'key-advanced-upload-ArcGIS',
        title: 'Upload data to ArcGIS',
        onChange: (value) async {
          debugPrint('key-advanced-upload-ArcGIS: $value');
          await widget.model.getUpload();
        },
      ),

      SimpleSettingsTile(
        title: 'Advanced Setting',
        subtitle: 'This setting is only available for advanced users',
        enabled: false,
      )
    ],
  ); 
}