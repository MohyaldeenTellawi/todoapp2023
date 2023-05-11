import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/ui/pages/login_page.dart';
import 'package:todo/ui/theme.dart';



class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('About',
        style: GoogleFonts.lato(
          fontSize: 24,fontWeight: FontWeight.bold,
          color: darkGreyClr
        ),
        ),
        elevation: 0,
          backgroundColor: Colors.white,
        leading: IconButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
          onPressed: (){
            Get.to(const logInScreen());
          },
          icon: const Icon(Icons.arrow_back_ios,size: 24,
            color:darkGreyClr),
        ),
      ),
      body: _portbody()
    );
  }

  Padding _landbody(){
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/icon.png',width: 100,height: 100,
                      fit: BoxFit.scaleDown,
                    ),
                    const SizedBox(width: 20),
                    Text('ToDo2023',
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 24, fontWeight: FontWeight.bold,
                          )
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          const CircleAvatar(
                            backgroundImage: AssetImage('images/my1.jpeg'),
                            radius: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Mohyaldeen Tellawi',
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      color: darkGreyClr,
                                      fontSize: 18, fontWeight: FontWeight.bold,
                                    )
                                ),
                              ),
                              const SizedBox(width: 3),
                              const Icon(Icons.copyright_rounded,color: darkGreyClr,),
                              const SizedBox(width: 3),
                              Text('To Do (V 1.0) 2023',
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18, fontWeight: FontWeight.bold,
                                    )
                                ),),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.mail_outline_rounded,color: Colors.black,),
                              const SizedBox(width: 10),
                              Text('mohyaldeentellawi@gmail.com',
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      color: darkGreyClr,
                                      fontSize: 18, fontWeight: FontWeight.bold,
                                    )
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.webhook_sharp,color: Colors.black,),
                              const SizedBox(width: 10),
                              Text('https://github.com/MuhittinT',
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      color: darkGreyClr,
                                      fontSize: 18, fontWeight: FontWeight.bold,
                                    )
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: darkGreyClr,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              '* This application help you to manage your daily tasks comfortably.\n * It remind you of tasks by sending notifications.'
                                  '\n * The existing color list help you choose a color for the task according to its importance',
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18, fontWeight: FontWeight.bold,
                                  )
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                      ],
                    ),
                  ],
                ),
            ),
      ),
    );
  }

  Container _portbody() {
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                 Image.asset('images/icon.png',width: 100,height: 100,
                 fit: BoxFit.scaleDown,
                 ),
                  const SizedBox(width: 20),
                  Text('ToDo2023',
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 24, fontWeight: FontWeight.bold,
                      )
                  ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                    children: [
                Container(
                  margin: const EdgeInsets.only(left:7,right: 7 ),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: darkGreyClr,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child:  Text(
                            'This application help you to manage\n your daily tasks comfortably',
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18, fontWeight: FontWeight.bold,
                                )
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                Image.asset('images/todoabout.webp',
                          width: 60,height: 60,
                  color: darkGreyClr,
                          ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                     Container(
                       margin: const EdgeInsets.only(left: 7,right: 7),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: darkGreyClr,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child:  Text(
                        'It remind you of tasks by\n sending notifications.',
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              color: Colors.white70,
                              fontSize: 18, fontWeight: FontWeight.bold,
                            )
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Image.asset('images/newremind.webp',
                  width: 80,height: 80,
                    color: darkGreyClr,
                  )
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                   Container(
                     margin: const EdgeInsets.only(left: 7,right: 7),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: darkGreyClr,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child:  Text(
                        'The existing color list help you\n choose a color for the task\n according to its importance',
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              color: Colors.white70,
                              fontSize: 18, fontWeight: FontWeight.bold,
                            )
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Image.asset('images/color.png',
                  width: 90,height: 90,)
                ],
              ),
              const SizedBox(height: 60),
              Container(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: const [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/my1.jpeg'),
                      radius: 60,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text('Mohyaldeen Tellawi',
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            color: darkGreyClr,
                            fontSize: 18, fontWeight: FontWeight.bold,
                          )
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(Icons.copyright_rounded,color: darkGreyClr,),
                    const SizedBox(width: 10),
                    Text('To Do (V 1.0) 2023',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18, fontWeight: FontWeight.bold,
                        )
                    ),),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    const Icon(Icons.mail_outline_rounded,color: Colors.black,),
                    const SizedBox(width: 10),
                    Text('mohyaldeentellawi@gmail.com',
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            color: darkGreyClr,
                            fontSize: 18, fontWeight: FontWeight.bold,
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    const Icon(Icons.webhook_sharp,color: Colors.black,),
                    const SizedBox(width: 10),
                    Text('https://github.com/MuhittinT',
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            color: darkGreyClr,
                            fontSize: 18, fontWeight: FontWeight.bold,
                          )
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
