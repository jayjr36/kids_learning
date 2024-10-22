import 'package:flutter/material.dart';
import 'package:kids_learning/screens/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Sample data for onboarding pages
  final List<Map<String, String>> _onboardingData = [
    {
      'image':
          'https://img.freepik.com/free-photo/education-study-childhood-skill-word_53876-121550.jpg',
      'title': 'Welcome to Kids Learning!',
      'description':
          'An engaging app to help your kids learn the alphabet and numbers.'
    },
    {
      'image':
          'https://i0.wp.com/www.simplyseptember.com/wp-content/uploads/2018/03/Blog-Post-Cover-Images-7.png?fit=810%2C450&ssl=1',
      'title': 'Fun Alphabet Learning',
      'description':
          'Interactive games to teach your child the letters of the alphabet.'
    },
    {
      'image':
          'https://smartmemories.pl/wp-content/uploads/2023/09/IMG_8976-min-scaled.jpg',
      'title': 'Exciting Number Quizzes',
      'description': 'Test your child’s knowledge with fun quizzes on numbers!'
    },
    {
      'image':
          'https://readingeggs.co.uk/_next/image/?url=https%3A%2F%2Fimages.ctfassets.net%2Flhzh8coidz9i%2F1ePfhCWofNuISWQ9mMvBBE%2Fb13f741be40d0706fe045dd7f7656145%2Falphabet-games-202006.jpg%3Fw%3D940%26h%3D529%26fit%3Dfill&w=1920&q=75',
      'title': 'Let’s Start Learning!',
      'description': 'Join us and make learning enjoyable for your child!'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green[100],
      body: PageView.builder(
        controller: _pageController,
        itemCount: _onboardingData.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return _buildPage(
            _onboardingData[index]['image']!,
            _onboardingData[index]['title']!,
            _onboardingData[index]['description']!,
          );
        },
      ),
      bottomSheet: _currentPage == _onboardingData.length - 1
          ? TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(_onboardingData.length - 1);
                    },
                    child: const Text('Skip'),
                  ),
                  Row(
                    children: List.generate(
                      _onboardingData.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Colors.green
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildPage(String image, String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image.startsWith('https')
            ? Image.network(
                image,
                height: 250,
                width: 250,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
              )
            : SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: Colors.green.shade800,
                )),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
