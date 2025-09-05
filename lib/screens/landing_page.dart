import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int sectionIndex) {
    // Calculate approximate position for each section
    final sectionPositions = [0, 600, 1200, 1800, 2400, 3000];
    if (sectionIndex < sectionPositions.length) {
      _scrollController.animateTo(
        sectionPositions[sectionIndex].toDouble(),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildHeroSection(context),
                _buildScreenshotsSection(),
                _buildFeaturesSection(),
                _buildTeamSection(),
                _buildHowItWorksSection(),
                _buildCTASection(context),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 80,
      floating: false,
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: Row(
          children: [
            Icon(
              Icons.account_balance_wallet,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(width: 8),
            Text(
              'BuddyCount',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      actions: [
        TextButton(
          onPressed: () {
            // This would link to your actual app when deployed
            // For now, just show a placeholder
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Coming Soon!'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: Text(
            'Try App',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24, 
        vertical: isMobile ? 60 : 80
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: isMobile ? 20 : 40),
          Text(
            'BuddyCount',
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 16 : 24),
          Text(
            'The easiest way to track shared expenses and balances with friends, roommates, and groups.',
            style: TextStyle(
              fontSize: isMobile ? 16 : 20,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 30 : 40),
          // Hero Screenshot
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/screenshots/completed_expense.png',
                height: isMobile ? 250 : 400,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 30 : 40),
          // Responsive button layout
          if (isMobile) ...[
            // Mobile: Stacked buttons
            Column(
              children: [
                _buildHeroButton(
                  context,
                  'Get Started',
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Coming Soon!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  isPrimary: true,
                ),
                const SizedBox(height: 16),
                _buildHeroButton(
                  context,
                  'Learn More',
                  () => _scrollToSection(2),
                  isPrimary: false,
                ),
              ],
            ),
          ] else ...[
            // Desktop: Side by side buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeroButton(
                  context,
                  'Get Started',
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Coming Soon!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  isPrimary: true,
                ),
                const SizedBox(width: 20),
                _buildHeroButton(
                  context,
                  'Learn More',
                  () => _scrollToSection(2),
                  isPrimary: false,
                ),
              ],
            ),
          ],
          SizedBox(height: isMobile ? 40 : 60),
        ],
      ),
    );
  }

  Widget _buildHeroButton(
    BuildContext context,
    String text,
    VoidCallback onPressed, {
    required bool isPrimary,
  }) {
    if (isPrimary) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          foregroundColor: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          side: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
  }

  Widget _buildScreenshotsSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24, 
            vertical: isMobile ? 60 : 80
          ),
          child: Column(
            children: [
              Text(
                'See BuddyCount in Action',
                style: TextStyle(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 16 : 24),
              Text(
                'Simple, yet intuitive interface designed for effortless expense tracking',
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 40 : 60),
              if (isMobile) ...[
                // Mobile: Stacked cards
                Column(
                  children: [
                    _buildScreenshotCard(
                      'assets/screenshots/no_expense.png',
                      'Clean Dashboard',
                      'Start with a clean, organized view of your groups',
                      height: 400,
                    ),
                    const SizedBox(height: 24),
                    _buildScreenshotCard(
                      'assets/screenshots/expense_fill.png',
                      'Easy Expense Entry',
                      'Add expenses quickly with our intuitive form',
                      height: 400,
                    ),
                    const SizedBox(height: 24),
                    _buildScreenshotCard(
                      'assets/screenshots/completed_expense.png',
                      'Track Everything',
                      'See all expenses and balances at a glance',
                      height: 400,
                    ),
                    const SizedBox(height: 24),
                    _buildScreenshotCard(
                      'assets/screenshots/prediction.png',
                      'Smart Predictions',
                      'Get AI-powered insights into your future spending patterns',
                      height: 400,
                    ),
                  ],
                ),
              ] else ...[
                // Desktop: 2x2 grid layout
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildScreenshotCard(
                            'assets/screenshots/no_expense.png',
                            'Clean Dashboard',
                            'Start with a clean, organized view of your groups',
                            height: 600,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildScreenshotCard(
                            'assets/screenshots/expense_fill.png',
                            'Easy Expense Entry',
                            'Add expenses quickly with our intuitive form',
                            height: 600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: _buildScreenshotCard(
                            'assets/screenshots/completed_expense.png',
                            'Track Everything',
                            'See all expenses and balances at a glance',
                            height: 600,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildScreenshotCard(
                            'assets/screenshots/prediction.png',
                            'Smart Predictions',
                            'Get AI-powered insights into your future spending patterns',
                            height: 600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildScreenshotCard(String imagePath, String title, String description, {double? height}) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: height ?? 300,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24, 
            vertical: isMobile ? 60 : 80
          ),
          child: Column(
            children: [
              Text(
                'Why Choose BuddyCount?',
                style: TextStyle(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 40 : 60),
              if (isMobile) ...[
                // Mobile: Stacked cards
                Column(
                  children: [
                    _buildFeatureCard(
                      icon: Icons.group,
                      title: 'Group Management',
                      description: 'Create and manage expense groups with friends, roommates, or travel companions.',
                      screenshot: 'assets/screenshots/no_expense.png',
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureCard(
                      icon: Icons.receipt_long,
                      title: 'Expense Tracking',
                      description: 'Easily add expenses with names, amounts, currencies, and split them between members. Keep track of spendings with our smart previews.',
                      screenshot: 'assets/screenshots/expense_fill.png',
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureCard(
                      icon: Icons.account_balance,
                      title: 'Smart Balances',
                      description: 'Automatic calculation of who owes what to whom, keeping everyone in sync.',
                      screenshot: 'assets/screenshots/completed_expense.png',
                    ),
                  ],
                ),
              ] else ...[
                // Desktop: Side by side cards
                Row(
                  children: [
                    Expanded(
                      child: _buildFeatureCard(
                        icon: Icons.group,
                        title: 'Group Management',
                        description: 'Create and manage expense groups with friends, roommates, or travel companions.',
                        screenshot: 'assets/screenshots/no_expense.png',
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildFeatureCard(
                        icon: Icons.receipt_long,
                        title: 'Expense Tracking',
                        description: 'Easily add expenses with names, amounts, currencies, and split them between members. Keep track of spendings with our smart previews.',
                        screenshot: 'assets/screenshots/expense_fill.png',
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildFeatureCard(
                        icon: Icons.account_balance,
                        title: 'Smart Balances',
                        description: 'Automatic calculation of who owes what to whom, keeping everyone in sync.',
                        screenshot: 'assets/screenshots/completed_expense.png',
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildTeamSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24, 
            vertical: isMobile ? 60 : 80
          ),
          color: Colors.grey.shade50,
          child: Column(
            children: [
              Text(
                'Who are we?',
                style: TextStyle(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 16 : 24),
              Text(
                'Meet the talented team behind BuddyCount',
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 40 : 60),
              if (isMobile) ...[
                // Mobile: Stacked cards
                Column(
                  children: [
                    _buildTeamMemberCard(
                      name: 'Sergey Komarov',
                      role: 'Frontend Developer',
                      icon: Icons.code,
                      color: Colors.blue,
                      githubUrl: 'https://github.com/shadyseko',
                    ),
                    const SizedBox(height: 24),
                    _buildTeamMemberCard(
                      name: 'Arthur Jacobs',
                      role: 'Backend Developer, devops',
                      icon: Icons.storage,
                      color: Colors.green,
                      githubUrl: 'https://github.com/arthur2479',
                    ),
                    const SizedBox(height: 24),
                    _buildTeamMemberCard(
                      name: 'Aude Laydu',
                      role: 'Lead Designer and backend developer',
                      icon: Icons.design_services,
                      color: Colors.purple,
                      githubUrl: 'https://github.com/eau2',
                    ),
                  ],
                ),
              ] else ...[
                // Desktop: Side by side cards
                Row(
                  children: [
                    Expanded(
                      child: _buildTeamMemberCard(
                        name: 'Sergey Komarov',
                        role: 'Frontend Developer',
                        icon: Icons.code,
                        color: Colors.blue,
                        githubUrl: 'https://github.com/shadyseko',
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildTeamMemberCard(
                        name: 'Arthur Jacobs',
                        role: 'Backend Developer, devops',
                        icon: Icons.storage,
                        color: Colors.green,
                        githubUrl: 'https://github.com/arthur2479',
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildTeamMemberCard(
                        name: 'Aude Laydu',
                        role: 'Lead Designer, backend developer',
                        icon: Icons.design_services,
                        color: Colors.purple,
                        githubUrl: 'https://github.com/eau2',
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildTeamMemberCard({
    required String name,
    required String role,
    required IconData icon,
    required Color color,
    required String githubUrl,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () async {
          // Open GitHub profile in new tab
          if (githubUrl.isNotEmpty) {
            try {
              final Uri url = Uri.parse(githubUrl);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Could not open ${name}\'s GitHub profile'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error opening ${name}\'s GitHub profile'),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                role,
                style: TextStyle(
                  fontSize: 16,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.link,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'GitHub Profile',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      decoration: TextDecoration.underline,
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

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required String screenshot,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 32,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                screenshot,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHowItWorksSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24, 
            vertical: isMobile ? 60 : 80
          ),
          color: Colors.grey.shade50,
          child: Column(
            children: [
              Text(
                'How It Works',
                style: TextStyle(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 40 : 60),
              if (isMobile) ...[
                // Mobile: Stacked cards
                Column(
                  children: [
                    _buildStepCard(
                      number: '1',
                      title: 'Create a Group',
                      description: 'Start by creating a group and adding your friends or roommates.',
                    ),
                    const SizedBox(height: 32),
                    _buildStepCard(
                      number: '2',
                      title: 'Add Expenses',
                      description: 'Record shared expenses like rent, groceries, or dinner bills.',
                    ),
                    const SizedBox(height: 32),
                    _buildStepCard(
                      number: '3',
                      title: 'Track Balances',
                      description: 'See who owes what and settle up easily with automatic calculations.',
                    ),
                    const SizedBox(height: 32),
                    _buildStepCard(
                      number: '4',
                      title: 'Smart Spending Predictions',
                      description: 'Get AI-powered insights into your future spending patterns and plan ahead.',
                    ),
                  ],
                ),
              ] else ...[
                // Desktop: Side by side cards
                Row(
                  children: [
                    Expanded(
                      child: _buildStepCard(
                        number: '1',
                        title: 'Create a Group',
                        description: 'Start by creating a group and adding your friends or roommates.',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStepCard(
                        number: '2',
                        title: 'Add Expenses',
                        description: 'Record shared expenses like rent, groceries, or dinner bills.',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStepCard(
                        number: '3',
                        title: 'Track Balances',
                        description: 'See who owes what and settle up easily with automatic calculations.',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStepCard(
                        number: '4',
                        title: 'Smart Spending Predictions',
                        description: 'Get AI-powered insights into your future spending patterns and plan ahead.',
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildStepCard({
    required String number,
    required String title,
    required String description,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCTASection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          const Text(
            'Ready to Get Started?',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'Join thousands of users who trust BuddyCount to manage their shared expenses.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              // This would link to your actual app when deployed
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Coming Soon! '),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Start Using BuddyCount',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      color: Colors.grey.shade900,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'BuddyCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                '© 2025 BuddyCount. All rights reserved.',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.grey),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Made with love using Flutter',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
