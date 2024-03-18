import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../provider/my_provider.dart';

class SettingsTab extends StatelessWidget {
  String lang = "English";
  String mode = "Light";

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.language,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: provider.mode == ThemeMode.light
                          ? colorBlack
                          : Colors.white,
                    ),
              ),
              Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(vertical: 30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true,
                      value: provider.languageCode == "en"
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      items: [
                        AppLocalizations.of(context)!.english,
                        AppLocalizations.of(context)!.arabic,
                      ]
                          .map((e) => DropdownMenuItem(
                                child: Text("$e"),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (String? value) {
                        (value == AppLocalizations.of(context)!.english
                            ? provider.ChangeLanguage("en")
                            : provider.ChangeLanguage("ar"));
                      },
                    ),
                  )),
              Text(
                AppLocalizations.of(context)!.mode,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: provider.mode == ThemeMode.light
                          ? colorBlack
                          : Colors.white,
                    ),
              ),
              Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(vertical: 30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true,
                      value: provider.mode == ThemeMode.light
                          ? AppLocalizations.of(context)!.light
                          : AppLocalizations.of(context)!.dark,
                      items: [
                        AppLocalizations.of(context)!.light,
                        AppLocalizations.of(context)!.dark,
                      ]
                          .map((e) => DropdownMenuItem(
                                child: Text("$e"),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        (value == AppLocalizations.of(context)!.light
                            ? provider.ChangeTheme(ThemeMode.light)
                            : provider.ChangeTheme(ThemeMode.dark));
                      },
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
