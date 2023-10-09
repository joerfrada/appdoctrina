import 'package:appdoctrina/values/colors.dart';
import 'package:flutter/material.dart';

class TextsPage extends StatefulWidget {
  const TextsPage({super.key});

  @override
  State<StatefulWidget> createState() => _TextsPageState();
}

class _TextsPageState extends State<TextsPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: MyColors.azul),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      alignment: Alignment.center,
                      child: const Text(
                        "Términos y condiciones",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 22,
                    left: 20,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vestibulum accumsan tortor id bibendum. Fusce accumsan ligula vel metus tristique viverra. Etiam vitae scelerisque velit. Cras fringilla nisi eget accumsan congue. Nam nec feugiat elit. Aenean suscipit, velit sed fermentum vulputate, lacus ipsum mollis justo, eget convallis metus augue eget ipsum. Vestibulum faucibus ac elit non iaculis. Curabitur sodales, sapien eget lobortis luctus, ex urna ornare eros, quis mollis mauris sapien sed arcu. Cras augue ante, fermentum mattis ex vehicula, suscipit congue nulla. Donec elementum erat quam. Vivamus vel malesuada ipsum, vitae mollis urna. Aliquam nec lacus ornare, maximus quam sit amet, ultricies sem. Praesent finibus ligula in felis sollicitudin pellentesque. Quisque cursus hendrerit lacus sit amet luctus. Mauris ut luctus orci.\n\nProin rhoncus bibendum consequat. Nam vehicula odio turpis, commodo aliquam turpis viverra ut. Curabitur eget est non lorem euismod tempus ac interdum sem. Nullam erat quam, consequat consectetur turpis ut, blandit euismod dui. Mauris vitae orci porttitor, viverra lectus quis, ornare diam. Praesent vulputate iaculis eros, et tempor lacus luctus at. Sed finibus arcu nisl, sed sagittis augue feugiat vel. Nulla posuere sem a nunc posuere, non dignissim lectus molestie. Etiam in nulla ac elit egestas rutrum. Etiam hendrerit neque posuere mauris hendrerit ullamcorper. Aliquam pretium ligula eu nisi placerat, a molestie risus vestibulum. Mauris porta mollis erat, ut mollis sem consequat eget.\n\nNunc ut nulla non ex pellentesque vestibulum in quis lorem. Phasellus et lacus ac tortor vulputate suscipit. Proin sit amet venenatis nulla. Ut iaculis ante sit amet hendrerit auctor. Integer at iaculis leo, et volutpat nulla. Donec dapibus consequat eros finibus aliquet. Mauris vestibulum, urna vel scelerisque auctor, ligula velit mollis neque, non fringilla ante libero et urna. Phasellus eu est magna. Nulla efficitur dictum dolor vitae consequat.\n\nEtiam a hendrerit urna. Integer mattis at massa ut hendrerit. Nullam porttitor molestie faucibus. Quisque et magna ultricies, viverra nunc tempor, sollicitudin quam. Phasellus gravida eros nec imperdiet fringilla. Aenean pretium dignissim nulla, vel finibus est ultricies consectetur. Vestibulum laoreet condimentum lorem. Sed congue porttitor ultricies. Nunc imperdiet, eros in viverra pharetra, purus tortor pellentesque urna, vel imperdiet tellus turpis eget odio. Vivamus vitae scelerisque sapien, vitae mollis mauris.\n\nSed ex tortor, venenatis at luctus id, egestas nec quam. Nunc fermentum posuere risus vitae dignissim. Phasellus id ex luctus, posuere sapien non, eleifend libero. Curabitur non enim ligula. Nam vel sodales quam, vel dignissim libero. Maecenas cursus feugiat dui. Nunc interdum ex sem, sit amet interdum ipsum elementum vel. Quisque blandit turpis ipsum, ac ultricies purus elementum at. Sed ultricies suscipit imperdiet. Vestibulum malesuada elit id erat fermentum, ut ullamcorper nulla malesuada.",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
