import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucky/src/data/properties.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';

import 'home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LBlock Calculator',
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [
          Consumer<HomeController>(
            builder: (context, controller, child) {
              if (controller.isDollar) {
                return TextButton(
                  onPressed: controller.changeCurrency,
                  child: Text(
                    "BNB",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              }
              return TextButton(
                onPressed: controller.changeCurrency,
                child: Text(
                  "\$",
                  style: Theme.of(context).textTheme.headline4,
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<HomeController>(
        builder: (context, controller, child) {
          return SafeArea(
            child: RefreshIndicator(
              key: controller.refreshIndicator,
              onRefresh: () => controller.loadInfos(),
              child: HomeContent(controller),
            ),
          );
        },
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent(
    this.controller, {
    Key? key,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.isError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off, size: 48),
          const SizedBox(height: 24),
          Text("Please verify your connectivity and retry.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5),
          const SizedBox(height: 16),
          Text(
              "Sometimes issue occurred because of API request overload, wait a few seconds before retrying.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption),
          const SizedBox(height: 16),
          TextButton(
            child: const Text("Retry"),
            onPressed: controller.loadInfos,
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Theme.of(context).dividerColor.withAlpha(10),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Data loaded on ${controller.loadedTime}",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ),
        ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Lottery",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: CountDownText(
                  due: controller.lotteryDate,
                  finishedText: "Done",
                  showLabel: true,
                  longDateName: true,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            ListTile(
              title: const Text("Jackpot price"),
              trailing: Text(
                controller.currentJackpot,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            ListTile(
              title: const Text("Royalties pool"),
              trailing: Text(
                controller.currentRoyalties,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Your holding",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller.holdingController,
                keyboardType: TextInputType.number,
                onChanged: controller.updateOwnerBlock,
                textAlign: TextAlign.end,
                decoration: const InputDecoration(
                  suffix: Text("LBLOCK"),
                ),
              ),
            ),
            ListTile(
              title: const Text("Current value"),
              trailing: Text(
                controller.userValue,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            ListTile(
              title: const Text("Future royalties"),
              trailing: Text(
                controller.futureUserRoyalties,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          color: Theme.of(context).dividerColor.withAlpha(10),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: controller.openTwitter,
                    icon: const Icon(FontAwesomeIcons.twitter),
                  ),
                  IconButton(
                    onPressed: controller.openTelegram,
                    icon: const Icon(FontAwesomeIcons.telegram),
                  ),
                  IconButton(
                    onPressed: controller.openWebsite,
                    icon: const Icon(FontAwesomeIcons.firefox),
                  ),
                  IconButton(
                    onPressed: controller.openStrimeGithub,
                    icon: const Icon(FontAwesomeIcons.github),
                  ),
                  IconButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: strimeWalletDialog,
                        useSafeArea: true),
                    icon: const Icon(FontAwesomeIcons.donate),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),
              const Text("Open source - Non official"),
              const SizedBox(height: 8),
              const Text("Feel free to support me :)"),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget strimeWalletDialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Non official application"),
      content: const Text(
          "Application has been developped on spare time, open source & publicity free.\nAny tips are welcomed !\nWallet: ${Properties.strimeAddress}"),
      actions: [
        TextButton(
          child: const Text("Copy wallet address"),
          onPressed: () {
            FlutterClipboard.copy(Properties.strimeAddress);
            const snackBar = SnackBar(
              content: Text(
                  'Wallet address has been copy on your clipboard, many thanks! <3'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text("Close"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}
