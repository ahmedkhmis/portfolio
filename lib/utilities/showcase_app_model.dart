import 'package:flutter/material.dart';

/// Model for portfolio showcase projects.
class ShowcaseAppModel {
  final String name;
  final String description;
  final String? githubURL;
  final String? playStoreURL;
  final String? appStoreURL;
  final String topic;
  final List<String> techStack;
  final IconData? icon;
  final String? image;
  final List<String> screenshots;

  const ShowcaseAppModel({
    required this.name,
    required this.description,
    required this.topic,
    this.githubURL,
    this.playStoreURL,
    this.appStoreURL,
    this.techStack = const [],
    this.icon,
    this.image,
    this.screenshots = const [],
  });
}

// ─── Professional Projects ──────────────────────────────────────────
const professionalApps = [
  ShowcaseAppModel(
    name: 'ICCP Community App',
    description:
        'Mobile app for the Islamic Community Center of Potomac – prayer times, events, donations, and news feeds.',
    topic: 'Community Services',
    techStack: ['Flutter', 'Clean Architecture', 'Cubit', 'FCM'],
    image: 'assets/images/projectsIcon/iccp.png',
    appStoreURL: 'https://apps.apple.com/us/app/iccp-connect/id6751505425',
    playStoreURL: 'https://play.google.com/store/apps/details?id=com.agentera.iccpmdApp&hl=en_US',
  ),
    ShowcaseAppModel(
    name: 'Al Vetrina',
    description:
        'High-end product marketplace – Flutter mobile + ReactJS admin + Node.js backend.',
    topic: 'E-commerce',
    techStack: ['Flutter', 'ReactJS', 'Node.js', 'MySQL'],
    image: 'assets/images/projectsIcon/alvetrina.png',
    appStoreURL: 'https://apps.apple.com/us/app/al-vetrina-app/id6468264636',
  ),
  ShowcaseAppModel(
    name: 'Jeyad 360',
    description:
        'Integrated Arabic platform for horse stable management – horse care, admin ops, and financials.',
    topic: 'Horse Management',
    techStack: ['Flutter', 'Clean Architecture', 'Cubit'],
    image: 'assets/images/projectsIcon/jayed360.png',
  ),
    ShowcaseAppModel(
    name: 'WindERP Mobile',
    description:
        'Enterprise resource planning app: inventory management, sales tracking, and employee management.',
    topic: 'ERP',
    techStack: ['Flutter', 'MVVM', 'Provider'],
    image: 'assets/images/projectsIcon/windERP.png',
  ),
  ShowcaseAppModel(
    name: 'AutoPal',
    description:
        'Cross-platform vehicle management application with team leadership and code reviews.',
    topic: 'Vehicle Management',
    techStack: ['Flutter', 'Clean Architecture', 'BLoC'],
    image: 'assets/images/projectsIcon/autopal.png',
  ),
  ShowcaseAppModel(
    name: 'Wind Caisse',
    description:
        'Cross-platform cash register for desktop and Android – sales, scanning, inventory, and tracking.',
    topic: 'Point of Sale',
    techStack: ['Flutter', 'MVVM', 'Provider', 'Windows'],
    image: 'assets/images/projectsIcon/windCaisse.png',
  ),
  ShowcaseAppModel(
    name: 'Medical Appointments',
    description:
        'Appointment management app for doctor-patient scheduling with calendar integration.',
    topic: 'Healthcare',
    techStack: ['Flutter', 'MVVM', 'Provider'],
    image: 'assets/images/projectsIcon/doctor.jpg',
  ),
  ShowcaseAppModel(
    name: 'Wind Pronostics',
    description:
        'B2B football prediction app with real-time match forecasts, analytics, and scoring predictions.',
    topic: 'Sports Tech',
    techStack: ['Flutter', 'MVVM', 'Provider'],
    image: 'assets/images/projectsIcon/windPronostics.png',
  ),
  ShowcaseAppModel(
    name: 'VisitMe',
    description:
        'Meeting management app consuming RESTful APIs – auth, scheduling, notifications.',
    topic: 'Meeting Management',
    techStack: ['Flutter', 'MVVM', 'Provider', 'REST API'],
    image: 'assets/images/projectsIcon/visitMe.png',
  ),
];

// ─── Academic Projects ──────────────────────────────────────────────
const academicApps = [
  ShowcaseAppModel(
    name: 'Chat App – Firebase',
    description:
        'Real-time chat application built with React Native and Firebase.',
    topic: 'Real-time Chat',
    techStack: ['React Native', 'Firebase'],
    icon: Icons.chat_bubble,
    githubURL: 'https://github.com/ahmedkhmis/ChatApp_FireBase',
  ),
  ShowcaseAppModel(
    name: 'Lab CRUD – ActiveMQ',
    description:
        'Middleware lab: communication between pharmacy and laboratory Java apps via ActiveMQ.',
    topic: 'Middleware',
    techStack: ['Java', 'ActiveMQ'],
    icon: Icons.science,
    githubURL:
        'https://github.com/ahmedkhmis/Labo_crude_with_ActiveMq-Middleware-',
  ),
  ShowcaseAppModel(
    name: 'E-commerce Pottery Store',
    description:
        'E-commerce site for pottery using native PHP, HTML5, CSS, and Bootstrap.',
    topic: 'E-commerce',
    techStack: ['PHP', 'HTML', 'CSS', 'Bootstrap'],
    icon: Icons.store,
    githubURL: 'https://github.com/ahmedkhmis/E-commerce-Pottery-_PHP_native_',
  ),
  ShowcaseAppModel(
    name: 'Pottery Model Creator',
    description:
        'Web app to create pottery models online with price estimation using Vue.js and Firebase.',
    topic: 'Web App',
    techStack: ['Vue.js', 'Firebase', 'Bootstrap'],
    icon: Icons.brush,
    githubURL: 'https://github.com/ahmedkhmis/PotteryModel-final-version',
  ),
  ShowcaseAppModel(
    name: 'Lung Cancer Prediction',
    description:
        'ML project comparing XGBClassifier, Random Forest, KNN, and more for cancer prediction.',
    topic: 'Machine Learning',
    techStack: ['Python', 'Flask', 'Pandas', 'Scikit-learn'],
    icon: Icons.analytics,
    githubURL: 'https://github.com/ahmedkhmis/Prediction-cancer',
  ),
  ShowcaseAppModel(
    name: 'Contact App – Android',
    description:
        'Android contact management app with database and HTML export.',
    topic: 'Android',
    techStack: ['Java', 'Android Studio', 'SQLite'],
    icon: Icons.contacts,
    githubURL: 'https://github.com/ahmedkhmis/-Contact_With_Android_Studio',
  ),
  ShowcaseAppModel(
    name: 'Connect Four – Python',
    description: 'Classic Connect Four game built with Python and Tkinter.',
    topic: 'Game',
    techStack: ['Python', 'Tkinter'],
    icon: Icons.grid_4x4,
    githubURL: 'https://github.com/ahmedkhmis/Jeu-Puissance-4-avec-Python',
  ),
];
