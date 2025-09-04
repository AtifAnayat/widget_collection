import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class ResumeBuilderScreen extends StatefulWidget {
  const ResumeBuilderScreen({super.key});

  @override
  _ResumeBuilderScreenState createState() => _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState extends State<ResumeBuilderScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  int _currentSection = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Personal Information Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _portfolioController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();

  // Data Lists
  final List<Experience> _experiences = [Experience()];
  final List<Education> _education = [Education()];
  final List<String> _skills = [''];
  final List<Language> _languages = [Language()];
  final List<String> _certifications = [''];
  final List<Project> _projects = [Project()];

  // Timeline Sections with enhanced design
  final List<TimelineSection> _sections = [
    TimelineSection(
      title: 'Personal Info',
      icon: Icons.person,
      color: Colors.blue,
    ),
    TimelineSection(title: 'Experience', icon: Icons.work, color: Colors.blue),
    TimelineSection(title: 'Education', icon: Icons.school, color: Colors.blue),
    TimelineSection(title: 'Skills', icon: Icons.star, color: Colors.blue),
    TimelineSection(
      title: 'Languages',
      icon: Icons.language,
      color: Colors.blue,
    ),
    TimelineSection(
      title: 'Certifications',
      icon: Icons.verified,
      color: const Color(0xFFffecd2),
    ),
    TimelineSection(
      title: 'Projects',
      icon: Icons.build,
      color: const Color(0xFFa8edea),
    ),
  ];

  // Enhanced color scheme
  static const Color _primaryColor = Color(0xFF2D3748);
  static const Color _accentColor = Color(0xFF667eea);
  static const Color _textColor = Color(0xFF2D3748);
  static const Color _secondaryTextColor = Color(0xFF718096);
  static const Color _backgroundColor = Color(0xFFF7FAFC);
  static const Color _cardBackground = Colors.white;
  static const Color _errorColor = Color(0xFFE53E3E);
  static const Color _successColor = Color(0xFF38A169);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEnhancedAppBar(),
            _buildEnhancedTimeline(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                child: Form(key: _formKey, child: _buildCurrentSection()),
              ),
            ),
            _buildEnhancedNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _sections[_currentSection].icon,
              color: _primaryColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Professional Resume Builder',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _primaryColor,
                  ),
                ),
                Text(
                  _sections[_currentSection].title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${_currentSection + 1}/${_sections.length}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedTimeline() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _sections.length,
          itemBuilder: (context, index) {
            final isActive = index == _currentSection;
            final isCompleted = index < _currentSection;
            final section = _sections[index];

            return GestureDetector(
              onTap: () {
                if (index <= _currentSection || _validateCurrentSection()) {
                  setState(() {
                    _currentSection = index;
                  });
                  _animationController.reset();
                  _animationController.forward();
                }
              },
              child: Container(
                width: 100,
                margin: const EdgeInsets.symmetric(
                  horizontal: 0,
                ), // tight spacing
                child: Column(
                  children: [
                    // Line + Circle indicator (stack to overlap)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // full horizontal line (behind circle)
                        Container(
                          height: 3,
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          color: index < _sections.length - 1
                              ? (isCompleted
                                    ? _primaryColor
                                    : Colors.grey.shade300)
                              : Colors.transparent,
                        ),
                        // Circle on top of line
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCompleted
                                ? _primaryColor
                                : (isActive
                                      ? _primaryColor
                                      : Colors.grey.shade200),
                            border: Border.all(
                              color: _primaryColor,
                              width: isActive ? 3 : 1.5,
                            ),
                            boxShadow: [
                              if (isActive)
                                BoxShadow(
                                  color: _primaryColor.withOpacity(0.2),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                            ],
                          ),
                          child: Icon(
                            isCompleted ? Icons.check : section.icon,
                            color: isCompleted
                                ? Colors.white
                                : (isActive ? Colors.white : _primaryColor),
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Title text
                    Text(
                      section.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isActive || isCompleted
                            ? Colors.black
                            : _secondaryTextColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCurrentSection() {
    switch (_currentSection) {
      case 0:
        return _buildPersonalInfoSection();
      case 1:
        return _buildExperienceSection();
      case 2:
        return _buildEducationSection();
      case 3:
        return _buildSkillsSection();
      case 4:
        return _buildLanguagesSection();
      case 5:
        return _buildCertificationsSection();
      case 6:
        return _buildProjectsSection();
      default:
        return Container();
    }
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: _textColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: _secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(height: 1, decoration: BoxDecoration(color: _primaryColor)),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    IconData? icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    bool required = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _textColor,
              ),
            ),
            if (required)
              const Text(
                ' *',
                style: TextStyle(color: _errorColor, fontSize: 16),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: _secondaryTextColor.withOpacity(0.8)),
            prefixIcon: icon != null
                ? Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: Colors.grey, size: 20),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: _sections[_currentSection].color,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _errorColor, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _errorColor, width: 2),
            ),
            fillColor: Colors.grey.shade50,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Personal Information',
          'Let\'s start with your basic details',
        ),
        _buildTextField(
          controller: _nameController,
          label: 'Full Name',
          hint: 'ABC...',
          icon: Icons.person,
          required: true,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Name is required' : null,
        ),
        const SizedBox(height: 24),
        _buildTextField(
          controller: _titleController,
          label: 'Professional Title',
          hint: 'Senior Software Engineer',
          icon: Icons.work,
          required: true,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Title is required' : null,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'abc@example.com',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                required: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Email is required';
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value!)) {
                    return 'Invalid email format';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _phoneController,
                label: 'Phone',
                hint: '+1 (555) 123-4567',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                required: true,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Phone is required' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildTextField(
          controller: _addressController,
          label: 'Address',
          hint: 'City, State, Country',
          icon: Icons.location_on,
          required: true,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Address is required' : null,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _linkedinController,
                label: 'LinkedIn',
                hint: 'linkedin.com/in/johndoe',
                icon: Icons.link,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _portfolioController,
                label: 'Portfolio/Website',
                hint: 'www.johndoe.com',
                icon: Icons.language,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildTextField(
          controller: _summaryController,
          label: 'Professional Summary',
          hint: 'Brief overview of your experience and key strengths...',
          maxLines: 5,
          required: true,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Summary is required' : null,
        ),
      ],
    );
  }

  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Work Experience',
          'Add your professional experience',
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _experiences.length,
          itemBuilder: (context, index) => _buildExperienceCard(index),
        ),
        const SizedBox(height: 24),
        _buildAddButton('Add Experience', Icons.add, () {
          setState(() {
            _experiences.add(Experience());
          });
        }),
      ],
    );
  }

  Widget _buildExperienceCard(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.work,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Experience ${index + 1}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _textColor,
                      ),
                    ),
                  ],
                ),
                if (_experiences.length > 1)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _experiences.removeAt(index);
                      });
                    },
                    icon: const Icon(Icons.delete_outline, color: _errorColor),
                    style: IconButton.styleFrom(
                      backgroundColor: _errorColor.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _experiences[index].jobTitle,
              label: 'Job Title',
              hint: 'Software Engineer',
              required: true,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Job title is required' : null,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _experiences[index].company,
              label: 'Company',
              hint: 'Tech Company Inc.',
              required: true,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Company is required' : null,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _experiences[index].startDate,
                    label: 'Start Date',
                    hint: 'Jan 2020',
                    required: true,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Start date is required'
                        : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _experiences[index].endDate,
                    label: 'End Date',
                    hint: 'Present',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _experiences[index].location,
              label: 'Location',
              hint: 'San Francisco, CA',
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _experiences[index].description,
              label: 'Job Description',
              hint: 'Describe your key responsibilities and achievements...',
              maxLines: 4,
              required: true,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Description is required' : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Education',
          'Your educational background and qualifications',
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _education.length,
          itemBuilder: (context, index) => _buildEducationCard(index),
        ),
        const SizedBox(height: 24),
        _buildAddButton('Add Education', Icons.add, () {
          setState(() {
            _education.add(Education());
          });
        }),
      ],
    );
  }

  Widget _buildEducationCard(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.school,
                        color: _primaryColor,
                        size: 25,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Education${index + 1}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _textColor,
                      ),
                    ),
                  ],
                ),
                if (_education.length > 1)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _education.removeAt(index);
                      });
                    },
                    icon: const Icon(Icons.delete_outline, color: _errorColor),
                    style: IconButton.styleFrom(
                      backgroundColor: _errorColor.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _education[index].degree,
              label: 'Degree',
              hint: 'Bachelor of Science in Computer Science',
              required: true,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Degree is required' : null,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _education[index].institution,
              label: 'Institution',
              hint: 'University of Technology',
              required: true,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Institution is required' : null,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _education[index].year,
                    label: 'Graduation Year',
                    hint: '2020',
                    required: true,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Year is required' : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _education[index].gpa,
                    label: 'GPA/Grade',
                    hint: '3.8/4.0',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Skills', 'List your technical and soft skills'),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _skills.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: _skills[index],
                      onChanged: (value) => _skills[index] = value,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'Skill ${index + 1}',
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _textColor,
                        ),
                        hintText:
                            'e.g., JavaScript, Python, Project Management',
                        hintStyle: TextStyle(
                          color: _secondaryTextColor.withOpacity(0.7),
                        ),
                        prefixIcon: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: _sections[_currentSection].color,
                            width: 2,
                          ),
                        ),
                        fillColor: Colors.grey.shade50,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                  if (_skills.length > 1)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _skills.removeAt(index);
                        });
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: _errorColor,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: _errorColor.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        _buildAddButton('Add Skill', Icons.add, () {
          setState(() {
            _skills.add('');
          });
        }),
      ],
    );
  }

  Widget _buildLanguagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Languages',
          'Languages you speak and your proficiency level',
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _languages.length,
          itemBuilder: (context, index) => _buildLanguageCard(index),
        ),
        const SizedBox(height: 24),
        _buildAddButton('Add Language', Icons.add, () {
          setState(() {
            _languages.add(Language());
          });
        }),
      ],
    );
  }

  Widget _buildLanguageCard(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            // Language TextField
            Expanded(
              flex: 2,
              child: _buildTextField(
                controller: _languages[index].name,
                label: 'Language',
                hint: 'English',
              ),
            ),
            const SizedBox(width: 16),

            // Dropdown (wrapped with Expanded to avoid overflow)
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Proficiency',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _textColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _languages[index].proficiency,
                    isExpanded: true, // 👈 important (avoids overflow)
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: _sections[_currentSection].color,
                          width: 2,
                        ),
                      ),
                      fillColor: Colors.grey.shade50,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    items:
                        const [
                              'Native',
                              'Fluent',
                              'Proficient',
                              'Intermediate',
                              'Basic',
                            ]
                            .map(
                              (level) => DropdownMenuItem(
                                value: level,
                                child: Text(level),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        _languages[index].proficiency = value!;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // Delete Button
            if (_languages.length > 1)
              IconButton(
                onPressed: () {
                  setState(() {
                    _languages.removeAt(index);
                  });
                },
                icon: const Icon(Icons.delete_outline, color: _errorColor),
                style: IconButton.styleFrom(
                  backgroundColor: _errorColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Certifications',
          'Professional certifications and licenses',
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _certifications.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: _certifications[index],
                      onChanged: (value) => _certifications[index] = value,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'Certification ${index + 1}',
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _textColor,
                        ),
                        hintText: 'e.g., AWS Certified Solutions Architect',
                        hintStyle: TextStyle(
                          color: _secondaryTextColor.withOpacity(0.7),
                        ),
                        prefixIcon: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: _sections[_currentSection].color,
                            width: 2,
                          ),
                        ),
                        fillColor: Colors.grey.shade50,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                  if (_certifications.length > 1)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _certifications.removeAt(index);
                        });
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: _errorColor,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: _errorColor.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        _buildAddButton('Add Certification', Icons.add, () {
          setState(() {
            _certifications.add('');
          });
        }),
      ],
    );
  }

  Widget _buildProjectsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Projects',
          'Showcase your key projects and achievements',
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _projects.length,
          itemBuilder: (context, index) => _buildProjectCard(index),
        ),
        const SizedBox(height: 24),
        _buildAddButton('Add Project', Icons.add, () {
          setState(() {
            _projects.add(Project());
          });
        }),
      ],
    );
  }

  Widget _buildProjectCard(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.build,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Project ${index + 1}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _textColor,
                      ),
                    ),
                  ],
                ),
                if (_projects.length > 1)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _projects.removeAt(index);
                      });
                    },
                    icon: const Icon(Icons.delete_outline, color: _errorColor),
                    style: IconButton.styleFrom(
                      backgroundColor: _errorColor.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _projects[index].name,
              label: 'Project Name',
              hint: 'E-commerce Platform',
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _projects[index].technologies,
              label: 'Technologies Used',
              hint: 'React, Node.js, MongoDB',
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _projects[index].description,
              label: 'Project Description',
              hint: 'Describe the project, your role, and key achievements...',
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _projects[index].link,
              label: 'Project Link',
              hint: 'https://github.com/username/project',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(String text, IconData icon, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _sections[_currentSection].color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          // BACK BUTTON
          if (_currentSection > 0)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _currentSection--;
                  });
                  _animationController.reset();
                  _animationController.forward();
                },
                icon: const Icon(Icons.arrow_back, color: Colors.grey),
                label: const Text(
                  'Previous',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey, width: 1.2),
                  foregroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            )
          else
            const Spacer(),

          const SizedBox(width: 16),

          // NEXT BUTTON
          if (_currentSection < _sections.length - 1)
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_validateCurrentSection()) {
                    setState(() {
                      _currentSection++;
                    });
                    _animationController.reset();
                    _animationController.forward();
                  }
                },
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  elevation: 5,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

          // FINAL SECTION (Preview + Generate)
          if (_currentSection == _sections.length - 1) ...[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF667eea).withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: _previewPDF,
                  icon: const Icon(Icons.preview, color: Colors.white),
                  label: const Text(
                    'Preview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF38A169), Color(0xFF2F855A)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF38A169).withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: _generateAndSharePDF,
                  icon: const Icon(Icons.download, color: Colors.white),
                  label: const Text(
                    'Generate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  bool _validateCurrentSection() {
    if (_formKey.currentState?.validate() ?? false) {
      return true;
    } else {
      _showErrorSnackBar('Please fill all required fields');
      return false;
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: _errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: _successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  // PDF Generation methods remain the same as in your original code
  Future<pw.Document> _generatePDF() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildPDFHeader(),
              pw.SizedBox(height: 25),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _buildPDFContactSection(),
                        pw.SizedBox(height: 20),
                        _buildPDFSkillsSection(),
                        pw.SizedBox(height: 20),
                        _buildPDFLanguagesSection(),
                        pw.SizedBox(height: 20),
                        _buildPDFCertificationsSection(),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 20),
                  pw.Expanded(
                    flex: 7,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _buildPDFSummarySection(),
                        pw.SizedBox(height: 20),
                        _buildPDFExperienceSection(),
                        pw.SizedBox(height: 20),
                        _buildPDFEducationSection(),
                        pw.SizedBox(height: 20),
                        _buildPDFProjectsSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
    return pdf;
  }

  pw.Widget _buildPDFHeader() {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#2C3E50'),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Text(
            _nameController.text,
            style: pw.TextStyle(
              fontSize: 28,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            _titleController.text,
            style: pw.TextStyle(
              fontSize: 16,
              color: PdfColor.fromHex('#BDC3C7'),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPDFContactSection() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildPDFSectionTitle('CONTACT'),
        pw.SizedBox(height: 12),
        _buildPDFContactItem('Email', _emailController.text),
        _buildPDFContactItem('Phone', _phoneController.text),
        _buildPDFContactItem('Address', _addressController.text),
        if (_linkedinController.text.isNotEmpty)
          _buildPDFContactItem('LinkedIn', _linkedinController.text),
        if (_portfolioController.text.isNotEmpty)
          _buildPDFContactItem('Portfolio', _portfolioController.text),
      ],
    );
  }

  pw.Widget _buildPDFContactItem(String label, String text) {
    if (text.isEmpty) return pw.SizedBox();
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex('#7F8C8D'),
            ),
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            text,
            style: pw.TextStyle(
              fontSize: 10,
              color: PdfColor.fromHex('#2C3E50'),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPDFSectionTitle(String title) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#34495E'),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 12,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.white,
        ),
      ),
    );
  }

  pw.Widget _buildPDFSkillsSection() {
    final filteredSkills = _skills.where((skill) => skill.isNotEmpty).toList();
    if (filteredSkills.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildPDFSectionTitle('SKILLS'),
        pw.SizedBox(height: 12),
        ...filteredSkills.map(
          (skill) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 4,
                  height: 4,
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#3498DB'),
                    shape: pw.BoxShape.circle,
                  ),
                ),
                pw.SizedBox(width: 8),
                pw.Expanded(
                  child: pw.Text(
                    skill,
                    style: pw.TextStyle(
                      fontSize: 10,
                      color: PdfColor.fromHex('#2C3E50'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildPDFLanguagesSection() {
    final filteredLanguages = _languages
        .where((lang) => lang.name.text.isNotEmpty)
        .toList();
    if (filteredLanguages.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildPDFSectionTitle('LANGUAGES'),
        pw.SizedBox(height: 12),
        ...filteredLanguages.map(
          (lang) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 8),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  lang.name.text,
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#2C3E50'),
                  ),
                ),
                pw.Text(
                  lang.proficiency,
                  style: pw.TextStyle(
                    fontSize: 9,
                    color: PdfColor.fromHex('#7F8C8D'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildPDFCertificationsSection() {
    final filteredCerts = _certifications
        .where((cert) => cert.isNotEmpty)
        .toList();
    if (filteredCerts.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildPDFSectionTitle('CERTIFICATIONS'),
        pw.SizedBox(height: 12),
        ...filteredCerts.map(
          (cert) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 4,
                  height: 4,
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#E67E22'),
                    shape: pw.BoxShape.circle,
                  ),
                ),
                pw.SizedBox(width: 8),
                pw.Expanded(
                  child: pw.Text(
                    cert,
                    style: pw.TextStyle(
                      fontSize: 10,
                      color: PdfColor.fromHex('#2C3E50'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildPDFSummarySection() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildPDFMainSectionTitle('PROFESSIONAL SUMMARY'),
        pw.SizedBox(height: 12),
        pw.Text(
          _summaryController.text,
          style: pw.TextStyle(
            fontSize: 11,
            lineSpacing: 1.4,
            color: PdfColor.fromHex('#2C3E50'),
          ),
          textAlign: pw.TextAlign.justify,
        ),
      ],
    );
  }

  pw.Widget _buildPDFMainSectionTitle(String title) {
    return pw.Column(
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex('#2C3E50'),
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Container(height: 2, width: 50, color: PdfColor.fromHex('#3498DB')),
      ],
    );
  }

  pw.Widget _buildPDFExperienceSection() {
    final filteredExp = _experiences
        .where(
          (exp) => exp.jobTitle.text.isNotEmpty && exp.company.text.isNotEmpty,
        )
        .toList();
    if (filteredExp.isEmpty) return pw.SizedBox();

    final itemContents = filteredExp
        .map(
          (exp) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 16),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  margin: const pw.EdgeInsets.only(top: 0, right: 12),
                  width: 8,
                  height: 8,
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#3498DB'),
                    shape: pw.BoxShape.circle,
                  ),
                ),
                pw.Expanded(child: _buildPDFExperienceContent(exp)),
              ],
            ),
          ),
        )
        .toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildPDFMainSectionTitle('WORK EXPERIENCE'),
        pw.SizedBox(height: 16),
        if (itemContents.isNotEmpty)
          pw.Stack(
            children: [
              pw.Positioned(
                left: 3,
                top: 0,
                bottom: 0,
                child: pw.Container(
                  width: 2,
                  color: PdfColor.fromHex('#BDC3C7'),
                ),
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: itemContents,
              ),
            ],
          ),
      ],
    );
  }

  pw.Widget _buildPDFExperienceContent(Experience exp) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          exp.jobTitle.text,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex('#2C3E50'),
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          exp.company.text,
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex('#3498DB'),
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Row(
          children: [
            pw.Text(
              '${exp.startDate.text} - ${exp.endDate.text.isEmpty ? "Present" : exp.endDate.text}',
              style: pw.TextStyle(
                fontSize: 10,
                color: PdfColor.fromHex('#7F8C8D'),
              ),
            ),
            if (exp.location.text.isNotEmpty) ...[
              pw.SizedBox(width: 12),
              pw.Text(
                exp.location.text,
                style: pw.TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromHex('#7F8C8D'),
                ),
              ),
            ],
          ],
        ),
        if (exp.description.text.isNotEmpty) ...[
          pw.SizedBox(height: 8),
          pw.Text(
            exp.description.text,
            style: pw.TextStyle(
              fontSize: 10,
              lineSpacing: 1.3,
              color: PdfColor.fromHex('#2C3E50'),
            ),
            textAlign: pw.TextAlign.justify,
          ),
        ],
      ],
    );
  }

  pw.Widget _buildPDFEducationSection() {
    final filteredEdu = _education
        .where(
          (edu) =>
              edu.degree.text.isNotEmpty && edu.institution.text.isNotEmpty,
        )
        .toList();
    if (filteredEdu.isEmpty) return pw.SizedBox();

    final itemContents = filteredEdu
        .map(
          (edu) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 12),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  margin: const pw.EdgeInsets.only(top: 0, right: 12),
                  width: 8,
                  height: 8,
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#27AE60'),
                    shape: pw.BoxShape.circle,
                  ),
                ),
                pw.Expanded(child: _buildPDFEducationContent(edu)),
              ],
            ),
          ),
        )
        .toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildPDFMainSectionTitle('EDUCATION'),
        pw.SizedBox(height: 16),
        if (itemContents.isNotEmpty)
          pw.Stack(
            children: [
              pw.Positioned(
                left: 3,
                top: 0,
                bottom: 0,
                child: pw.Container(
                  width: 2,
                  color: PdfColor.fromHex('#BDC3C7'),
                ),
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: itemContents,
              ),
            ],
          ),
      ],
    );
  }

  pw.Widget _buildPDFEducationContent(Education edu) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          edu.degree.text,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex('#2C3E50'),
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          edu.institution.text,
          style: pw.TextStyle(fontSize: 11, color: PdfColor.fromHex('#3498DB')),
        ),
        pw.SizedBox(height: 4),
        pw.Row(
          children: [
            pw.Text(
              edu.year.text,
              style: pw.TextStyle(
                fontSize: 10,
                color: PdfColor.fromHex('#7F8C8D'),
              ),
            ),
            if (edu.gpa.text.isNotEmpty) ...[
              pw.SizedBox(width: 12),
              pw.Text(
                'GPA: ${edu.gpa.text}',
                style: pw.TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromHex('#7F8C8D'),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  pw.Widget _buildPDFProjectsSection() {
    final filteredProjects = _projects
        .where((proj) => proj.name.text.isNotEmpty)
        .toList();
    if (filteredProjects.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildPDFMainSectionTitle('PROJECTS'),
        pw.SizedBox(height: 16),
        ...filteredProjects.map(
          (proj) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 12),
            child: _buildPDFProjectItem(proj),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildPDFProjectItem(Project proj) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          proj.name.text,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex('#2C3E50'),
          ),
        ),
        if (proj.technologies.text.isNotEmpty) ...[
          pw.SizedBox(height: 4),
          pw.Text(
            'Technologies: ${proj.technologies.text}',
            style: pw.TextStyle(
              fontSize: 10,
              color: PdfColor.fromHex('#E67E22'),
            ),
          ),
        ],
        if (proj.description.text.isNotEmpty) ...[
          pw.SizedBox(height: 6),
          pw.Text(
            proj.description.text,
            style: pw.TextStyle(
              fontSize: 10,
              lineSpacing: 1.3,
              color: PdfColor.fromHex('#2C3E50'),
            ),
          ),
        ],
        if (proj.link.text.isNotEmpty) ...[
          pw.SizedBox(height: 4),
          pw.Text(
            'Link: ${proj.link.text}',
            style: pw.TextStyle(
              fontSize: 9,
              color: PdfColor.fromHex('#3498DB'),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _previewPDF() async {
    if (!_validateRequiredFields()) return;
    try {
      final pdf = await _generatePDF();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFPreviewScreen(pdfDocument: pdf),
        ),
      );
    } catch (e) {
      _showErrorSnackBar('Error generating PDF: $e');
    }
  }

  Future<void> _generateAndSharePDF() async {
    if (!_validateRequiredFields()) return;
    try {
      _showLoadingDialog();
      final pdf = await _generatePDF();
      final output = await pdf.save();
      final tempDir = await getTemporaryDirectory();
      final file = File(
        '${tempDir.path}/resume_${_nameController.text.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      await file.writeAsBytes(output);
      Navigator.pop(context); // Close loading dialog
      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Resume - ${_nameController.text}');
      _showSuccessSnackBar('Resume generated and ready to share!');
    } catch (e) {
      Navigator.pop(context);
      _showErrorSnackBar('Error generating PDF: $e');
    }
  }

  bool _validateRequiredFields() {
    if (_nameController.text.isEmpty ||
        _titleController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _summaryController.text.isEmpty) {
      _showErrorSnackBar('Please fill in all required fields in Personal Info');
      setState(() {
        _currentSection = 0;
      });
      return false;
    }
    return true;
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(_accentColor),
              ),
              const SizedBox(width: 20),
              const Expanded(
                child: Text(
                  'Generating your professional resume...',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _titleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _linkedinController.dispose();
    _portfolioController.dispose();
    _summaryController.dispose();
    for (var exp in _experiences) {
      exp.dispose();
    }
    for (var edu in _education) {
      edu.dispose();
    }
    for (var lang in _languages) {
      lang.dispose();
    }
    for (var proj in _projects) {
      proj.dispose();
    }
    super.dispose();
  }
}

// Data Models
class Experience {
  final TextEditingController jobTitle = TextEditingController();
  final TextEditingController company = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController description = TextEditingController();

  void dispose() {
    jobTitle.dispose();
    company.dispose();
    startDate.dispose();
    endDate.dispose();
    location.dispose();
    description.dispose();
  }
}

class Education {
  final TextEditingController degree = TextEditingController();
  final TextEditingController institution = TextEditingController();
  final TextEditingController year = TextEditingController();
  final TextEditingController gpa = TextEditingController();

  void dispose() {
    degree.dispose();
    institution.dispose();
    year.dispose();
    gpa.dispose();
  }
}

class Language {
  final TextEditingController name = TextEditingController();
  String proficiency = 'Fluent';

  void dispose() {
    name.dispose();
  }
}

class Project {
  final TextEditingController name = TextEditingController();
  final TextEditingController technologies = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController link = TextEditingController();

  void dispose() {
    name.dispose();
    technologies.dispose();
    description.dispose();
    link.dispose();
  }
}

class TimelineSection {
  final String title;
  final IconData icon;
  final Color color;

  TimelineSection({
    required this.title,
    required this.icon,
    required this.color,
  });
}

class PDFPreviewScreen extends StatelessWidget {
  final pw.Document pdfDocument;

  const PDFPreviewScreen({super.key, required this.pdfDocument});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resume Preview',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF2D3748),
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            tooltip: "Save PDF",
            onPressed: () => _savePDF(context),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: "Share PDF",
            onPressed: () => _sharePDF(context),
          ),
          IconButton(
            icon: const Icon(Icons.print),
            tooltip: "Print PDF",
            onPressed: _printPDF,
          ),
        ],
      ),
      body: PdfPreview(
        build: (format) => pdfDocument.save(),
        allowSharing: false, // custom share button use karenge
        allowPrinting: false,
        canChangePageFormat: false,
        canDebug: false,
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: "resume_preview.pdf",
      ),
    );
  }

  /// Save PDF to Downloads / Temporary Folder
  Future<void> _savePDF(BuildContext context) async {
    try {
      final output = await pdfDocument.save();
      final dir = await getApplicationDocumentsDirectory();
      final file = File(
        "${dir.path}/resume_${DateTime.now().millisecondsSinceEpoch}.pdf",
      );
      await file.writeAsBytes(output);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("PDF saved at: ${file.path}"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Share PDF
  Future<void> _sharePDF(BuildContext context) async {
    try {
      final output = await pdfDocument.save();
      final tempDir = await getTemporaryDirectory();
      final file = File(
        "${tempDir.path}/resume_${DateTime.now().millisecondsSinceEpoch}.pdf",
      );
      await file.writeAsBytes(output);

      await Share.shareXFiles([XFile(file.path)], text: 'Professional Resume');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sharing PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Print PDF
  Future<void> _printPDF() async {
    await Printing.layoutPdf(onLayout: (format) async => pdfDocument.save());
  }
}

Future<pw.Document> generateProfessionalPDF({
  required String name,
  required String title,
  required String email,
  required String phone,
  required String summary,
  required List<String> skills,
  required List<Map<String, String>> experiences,
  required List<Map<String, String>> education,
}) async {
  final pdf = pw.Document();

  final baseColor = PdfColor.fromHex('#2C3E50');
  final accentColor = PdfColor.fromHex('#3498DB');

  pw.Widget sectionTitle(String text) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        text.toUpperCase(),
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
          color: baseColor,
        ),
      ),
      pw.SizedBox(height: 4),
      pw.Container(height: 2, width: 50, color: accentColor),
      pw.SizedBox(height: 12),
    ],
  );

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      build: (context) => [
        // Header
        pw.Container(
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            color: baseColor,
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                name,
                style: pw.TextStyle(
                  fontSize: 26,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                ),
              ),
              pw.SizedBox(height: 6),
              pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColor.fromHex('#BDC3C7'),
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 20),

        // Contact Info
        sectionTitle("Contact"),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Email: $email", style: pw.TextStyle(fontSize: 11)),
            pw.Text("Phone: $phone", style: pw.TextStyle(fontSize: 11)),
          ],
        ),
        pw.SizedBox(height: 20),

        // Summary
        sectionTitle("Professional Summary"),
        pw.Text(
          summary,
          style: pw.TextStyle(fontSize: 11, lineSpacing: 1.4),
          textAlign: pw.TextAlign.justify,
        ),
        pw.SizedBox(height: 20),

        // Skills
        if (skills.isNotEmpty) ...[
          sectionTitle("Skills"),
          pw.Wrap(
            spacing: 8,
            runSpacing: 6,
            children: skills
                .map(
                  (s) => pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: pw.BoxDecoration(
                      color: accentColor,
                      borderRadius: pw.BorderRadius.circular(6),
                    ),
                    child: pw.Text(
                      s,
                      style: pw.TextStyle(color: PdfColors.white, fontSize: 10),
                    ),
                  ),
                )
                .toList(),
          ),
          pw.SizedBox(height: 20),
        ],

        // Experience
        if (experiences.isNotEmpty) ...[
          sectionTitle("Work Experience"),
          ...experiences.map(
            (exp) => pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 12),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    exp['jobTitle'] ?? '',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    exp['company'] ?? '',
                    style: pw.TextStyle(fontSize: 11, color: accentColor),
                  ),
                  if ((exp['description'] ?? '').isNotEmpty)
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(top: 4),
                      child: pw.Text(
                        exp['description']!,
                        style: pw.TextStyle(fontSize: 10),
                      ),
                    ),
                ],
              ),
            ),
          ),
          pw.SizedBox(height: 20),
        ],

        // Education
        if (education.isNotEmpty) ...[
          sectionTitle("Education"),
          ...education.map(
            (edu) => pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 10),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    edu['degree'] ?? '',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    edu['institution'] ?? '',
                    style: pw.TextStyle(fontSize: 11, color: accentColor),
                  ),
                  if ((edu['year'] ?? '').isNotEmpty)
                    pw.Text(
                      "Year: ${edu['year']}",
                      style: pw.TextStyle(fontSize: 10),
                    ),
                ],
              ),
            ),
          ),
        ],
      ],
    ),
  );

  return pdf;
}
