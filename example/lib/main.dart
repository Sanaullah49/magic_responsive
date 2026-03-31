import 'package:flutter/material.dart';
import 'package:magic_responsive/magic_responsive.dart';

void main() {
  runApp(const MagicApp());
}

class MagicApp extends StatelessWidget {
  const MagicApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF0F766E),
      brightness: Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFFF6F3EC),
        useMaterial3: true,
      ),
      home: const DemoScreen(),
    );
  }
}

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF7F2E7), Color(0xFFE8F4EF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SmartContainer(
            maxWidth: 1120,
            child: ListView(
              children: const [
                SizedBox(height: 12),
                _Header(),
                SizedBox(height: 28),
                _HeroSection(),
                SizedBox(height: 28),
                _SectionTitle(
                  eyebrow: 'Auto-adaptive',
                  title: 'One API, every screen width',
                  subtitle:
                      'Resize this window to watch the layout re-balance '
                      'without manual breakpoints.',
                ),
                SizedBox(height: 18),
                _FeaturesGrid(),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MagicFlex(
      minChildWidth: 360,
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'magic_responsive',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            'No breakpoints required',
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MagicFlex(
      minChildWidth: 320,
      spacing: 24,
      expandChildrenWhenHorizontal: true,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: const Color(0xFF102A43),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Responsive layouts that adapt to the space they get.',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Build rows that become stacks, grids that choose their own '
                'column count, and content shells that stay readable from '
                'mobile to desktop.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.82),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 22),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: const [
                  _MetricChip(label: 'MagicFlex', value: 'Auto stack'),
                  _MetricChip(label: 'MagicGrid', value: 'Auto columns'),
                  _MetricChip(label: 'SmartContainer', value: 'Adaptive shell'),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBF5),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0xFFD7E5DF)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 28,
                offset: Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            children: const [
              _PreviewPanel(
                title: 'Wide container',
                description:
                    'Two panels stay side by side when each one can '
                    'breathe.',
                accent: Color(0xFF0F766E),
              ),
              SizedBox(height: 14),
              _PreviewPanel(
                title: 'Tight container',
                description:
                    'The same widgets stack automatically instead of '
                    'squishing.',
                accent: Color(0xFFB45309),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String subtitle;

  const _SectionTitle({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow.toUpperCase(),
          style: theme.textTheme.labelLarge?.copyWith(
            color: const Color(0xFF0F766E),
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: const Color(0xFF102A43),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF4A5568),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _FeaturesGrid extends StatelessWidget {
  const _FeaturesGrid();

  @override
  Widget build(BuildContext context) {
    return MagicGrid(
      targetChildWidth: 240,
      minChildWidth: 180,
      maxColumns: 4,
      childAspectRatio: 0.95,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        _FeatureCard(
          title: 'Container-aware',
          body:
              'Layouts react to the width they actually receive, so nested '
              'panes and sidebars behave better than global breakpoints.',
          accent: Color(0xFF0F766E),
        ),
        _FeatureCard(
          title: 'Less boilerplate',
          body:
              'Stop repeating `LayoutBuilder`, `MediaQuery`, and custom '
              'crossAxisCount math all over the app.',
          accent: Color(0xFF2563EB),
        ),
        _FeatureCard(
          title: 'Better defaults',
          body:
              'Adaptive padding, content width caps, spacing, and animated '
              'reflow make common screens feel polished faster.',
          accent: Color(0xFFB45309),
        ),
        _FeatureCard(
          title: 'Easy escape hatches',
          body:
              'You can still pass an explicit breakpoint or custom sizing '
              'when a screen needs tighter control.',
          accent: Color(0xFF7C3AED),
        ),
      ],
    );
  }
}

class _MetricChip extends StatelessWidget {
  final String label;
  final String value;

  const _MetricChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        '$label  •  $value',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PreviewPanel extends StatelessWidget {
  final String title;
  final String description;
  final Color accent;

  const _PreviewPanel({
    required this.title,
    required this.description,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 60,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF102A43),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF52606D),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final String body;
  final Color accent;

  const _FeatureCard({
    required this.title,
    required this.body,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 20,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF102A43),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF52606D),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
