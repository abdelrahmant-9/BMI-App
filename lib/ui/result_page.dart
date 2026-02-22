import 'package:bmi/models/bmi_result_viewmodel.dart';
import 'package:bmi/api/api_service.dart';
import 'package:flutter/material.dart';
import '../core/theme/colors.dart';

class ResultPage extends StatefulWidget {
  final String name;
  final int age;
  final double height;
  final double weight;
  final bool isMale;
  final double bmi;

  const ResultPage({
    super.key,
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
    required this.isMale,
    required this.bmi,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String _quote = "Loading quote...";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuote();
  }

  Future<void> _fetchQuote() async {
    final apiService = ApiService();
    try {
      final quote = await apiService.fetchRandomQuote();
      if (mounted) {
        setState(() {
          _quote = quote;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _quote = "Failed to load quote. Please try again later.";
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = BmiResultViewModel(bmi: widget.bmi);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name.isNotEmpty ? widget.name : 'User',
                                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.white),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'A ${widget.age > 0 ? widget.age : '--'} years old ${widget.isMale ? 'male' : 'female'}.',
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.white),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  widget.bmi.toStringAsFixed(1),
                                  style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w700, color: AppColors.white),
                                ),
                                const Text(
                                  'BMI Calc',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.white),
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${widget.height.toStringAsFixed(0)} cm', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.white)),
                                        const Text('Height', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.white)),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    const SizedBox(height: 50, child: VerticalDivider(color: Colors.white, thickness: 1)),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${widget.weight.toStringAsFixed(0)} kg', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.white)),
                                        const SizedBox(height: 2),
                                        const Text('Weight', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 280,
                            child: Image.asset('assets/images/body.png'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                      decoration: BoxDecoration(
                        color: viewModel.color,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(viewModel.status, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.white)),
                          Text(viewModel.message, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.white)),
                          const SizedBox(height: 10),
                          _isLoading
                              ? const Center(child: CircularProgressIndicator(color: Colors.white))
                              : Text(
                                  _quote,
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.white, fontStyle: FontStyle.italic),
                                ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20), // Added for spacing
                  ],
                                ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                    child: const Text('Calculate BMI Again', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
