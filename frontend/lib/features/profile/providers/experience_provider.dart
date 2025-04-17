import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/experience.dart';

part 'experience_provider.g.dart';

@riverpod
Future<List<Experience>> experiences(ExperiencesRef ref) async {
  // Simulate network delay
  await Future.delayed(const Duration(seconds: 1));

  // Return actual experience data
  return [
    Experience(
      id: '1',
      company: 'Informatics Int. Limited',
      position: 'Software Engineer',
      description:
          'Contributed to Designing and Creating Internal Business management system(InfoHR) using React, Node and Express which increased Company revenue by 225%. Designed and Developed the e-Passport system while working closely with International Organization for Migration of Sri Lanka. Used React and Typescript to build the Frontend of the system.',
      startDate: DateTime(2021, 1),
      endDate: DateTime(2022, 8),
      location: 'Sri Lanka',
      technologies: ['React', 'Node.js', 'Express', 'TypeScript'],
      companyLogo: 'assets/images/informatics.png',
    ),
    Experience(
      id: '2',
      company: 'Informatics Int. Limited',
      position: 'Trainee Software Engineer',
      description:
          'Designed and Developed SLRCMS(Readmission Case Management System for Sri Lanka) which was the biggest success for the Company in last few years which lead to Winning Merit at the National ICT Awards NBQSA 2020 in October. Earned extensive knowledge about Angular and API handling through working closely with Senior Developers.',
      startDate: DateTime(2019, 9),
      endDate: DateTime(2020, 12),
      location: 'Sri Lanka',
      technologies: ['Angular', 'API Integration', 'TypeScript'],
      companyLogo: 'assets/images/informatics.png',
    ),
    Experience(
      id: '3',
      company: 'Informatics Int. Limited',
      position: 'Intern Software Engineer',
      description:
          'Started as a UI/UX Designer and Learned basic concepts of system design through contributing to the RCMS(Readmission Case Management System for European Union) project. Contributed to creating a language model which integrated Sinhala and Tamil Languages into Sri Lankan Government official website and Web Apps. Contributed to Creating components of RCMS project using Angular Framework, PrimeNG UI framework.',
      startDate: DateTime(2019, 3),
      endDate: DateTime(2019, 9),
      location: 'Sri Lanka',
      technologies: ['Angular', 'PrimeNG', 'UI/UX Design'],
      companyLogo: 'assets/images/informatics.png',
    ),
  ];
}
