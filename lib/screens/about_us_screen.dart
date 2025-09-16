import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/design_tokens.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  // Professional color scheme
  static const Color primaryDarkRed = Color(0xFF8B0000);
  static const Color accentRed = Color(0xFFB71C1C);
  static const Color creamBackground = Color(0xFFFFFBF7);

  // Key features data
  final List<Map<String, dynamic>> keyFeatures = [
    {
      'title': '24/7 Service',
      'description': 'Round-the-clock availability for your cravings',
      'icon': Icons.access_time,
      'color': Colors.blue,
    },
    {
      'title': 'Quality Ingredients',
      'description': 'Fresh, premium ingredients in every dish',
      'icon': Icons.restaurant,
      'color': Colors.green,
    },
    {
      'title': 'Friendly Staff',
      'description': 'Warm, professional service every time',
      'icon': Icons.people,
      'color': Colors.orange,
    },
    {
      'title': 'Our Location',
      'description': 'Convenient location in the city',
      'icon': Icons.location_on,
      'color': Colors.purple,
    },
  ];

  // Contact form data
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Round The Clock',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.25,
          ),
        ),
        backgroundColor: primaryDarkRed,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      body: Container(
        color: creamBackground,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero banner section
                _buildHeroBanner(),

                const SizedBox(height: DesignTokens.spacingXxl),

                // Brand story section
                _buildBrandStory(),

                const SizedBox(height: DesignTokens.spacingXxl),

                // Key features section
                _buildKeyFeatures(),

                const SizedBox(height: DesignTokens.spacingXxl),

                // Contact and location section
                _buildContactSection(),

                const SizedBox(height: DesignTokens.spacingXxl),

                // Contact form
                _buildContactForm(),

                const SizedBox(height: DesignTokens.spacingXxl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: DesignTokens.spacingMd),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Hero image
            Image.asset('assets/images/hero-1.jpg', fit: BoxFit.cover),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),

            // Content overlay
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingMd),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Round The Clock',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingXs),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spacingSm,
                      vertical: DesignTokens.spacingXs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusMd,
                      ),
                    ),
                    child: const Text(
                      '24/7 ALWAYS OPEN',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandStory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Story',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeXxl,
              fontWeight: FontWeight.bold,
              color: primaryDarkRed,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  '"Round The Clock was born from a simple idea: good food should be available whenever you want it."',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeMd,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                Text(
                  'We believe that great food shouldn\'t be limited by time. Whether it\'s a midnight craving or an early morning breakfast, Round The Clock is here to serve you with the same quality and care, 24 hours a day, 7 days a week.',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeSm,
                    color: Colors.grey[700],
                    height: 1.5,
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

  Widget _buildKeyFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacingMd,
          ),
          child: Text(
            'Why Choose Us',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeXxl,
              fontWeight: FontWeight.bold,
              color: primaryDarkRed,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacingMd,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: DesignTokens.spacingMd,
            mainAxisSpacing: DesignTokens.spacingMd,
            childAspectRatio:
                1.3, // Increased from 1.1 to give more vertical space
          ),
          itemCount: keyFeatures.length,
          itemBuilder: (context, index) {
            final feature = keyFeatures[index];
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: feature['title'] == 'Our Location'
                    ? _openLocation
                    : null,
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                child: Container(
                  padding: const EdgeInsets.all(
                    DesignTokens.spacingSm,
                  ), // Reduced padding
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(
                          DesignTokens.spacingSm,
                        ), // Reduced padding
                        decoration: BoxDecoration(
                          color: feature['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            DesignTokens.radiusMd,
                          ),
                        ),
                        child: Icon(
                          feature['icon'],
                          color: feature['color'],
                          size: 28, // Reduced icon size
                        ),
                      ),
                      SizedBox(
                        height: DesignTokens.spacingXs,
                      ), // Reduced spacing
                      Flexible(
                        child: Text(
                          feature['title'],
                          style: TextStyle(
                            fontSize:
                                DesignTokens.fontSizeSm, // Reduced font size
                            fontWeight: FontWeight.bold,
                            color: primaryDarkRed,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: DesignTokens.spacingXs,
                      ), // Reduced spacing
                      Flexible(
                        child: Text(
                          feature['description'],
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeXs,
                            color: Colors.grey[600],
                            height: 1.2, // Reduced line height
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find Us',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeXxl,
              fontWeight: FontWeight.bold,
              color: primaryDarkRed,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildContactItem(
                  Icons.phone,
                  'Phone',
                  '(525) 123-4567',
                  Colors.green,
                ),
                const Divider(height: 1),
                _buildContactItem(
                  Icons.email,
                  'Email',
                  'hello@roundtheclock.com',
                  Colors.blue,
                ),
                const Divider(height: 1),
                _buildContactItem(
                  Icons.location_on,
                  'Address',
                  '3rd floor, IGBT Best Flats\nGuwahati, Assam 781035',
                  Colors.red,
                ),
                const Divider(height: 1),
                _buildContactItem(
                  Icons.access_time,
                  'Hours',
                  'Open 24 hours, 7 days a week',
                  Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingSm),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacingSm),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: DesignTokens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeXs,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Get In Touch',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeXxl,
              fontWeight: FontWeight.bold,
              color: primaryDarkRed,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusMd,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spacingMd,
                      vertical: DesignTokens.spacingMd,
                    ),
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusMd,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spacingMd,
                      vertical: DesignTokens.spacingMd,
                    ),
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                TextField(
                  controller: messageController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusMd,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spacingMd,
                      vertical: DesignTokens.spacingMd,
                    ),
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitContactForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryDarkRed,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: DesignTokens.spacingMd,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusMd,
                        ),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      'Send Message',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to open Google Maps location
  Future<void> _openLocation() async {
    const url =
        'https://www.google.com/maps/place/Isbt-Guwahati/@26.116511,91.721923,21z/data=!4m6!3m5!1s0x375a5c7b11eb9ba1:0x29a329fd4ecb888f!8m2!3d26.1164805!4d91.7219495!16s%2Fg%2F1wk4bfbn?hl=en&entry=ttu&g_ep=EgoyMDI1MDkxMC4wIKXMDSoASAFQAw%3D%3D';

    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not open maps. Please check your internet connection.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _submitContactForm() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final message = messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Clear form
    nameController.clear();
    emailController.clear();
    messageController.clear();

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Thank you for your message! We\'ll get back to you soon.',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
