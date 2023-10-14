import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:video_editor/pages/filter_page.dart';
import 'package:video_editor/utils/config_util.dart' as config;
import 'package:video_editor/utils/model/filter_wrapper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void toFilterPage(BuildContext context, final FilterWrapper wrapper) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FilterPage(wrapper: wrapper),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Flags'),
            tiles: config.editingOptions
                .map(
                  (key, value) => MapEntry(
                    key,
                    SettingsTile.switchTile(
                      onToggle: (value) {
                        setState(() {
                          config.editingOptions[key] = value;
                        });
                      },
                      initialValue: value,
                      leading: const Icon(Icons.flag),
                      title: Text(key),
                    ),
                  ),
                )
                .values
                .toList(),
          ),
          SettingsSection(
            title: const Text('Filters'),
            tiles: config.filters.entries.map((e) {
              return SettingsTile.navigation(
                onPressed: (context) => toFilterPage(context, e.value),
                leading: const Icon(Icons.filter),
                title: Text(e.key),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
