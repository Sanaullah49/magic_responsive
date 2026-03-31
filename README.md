# magic_responsive

`magic_responsive` is a lightweight Flutter package for adaptive layouts that
respond to the space they actually get, not a pile of app-wide breakpoints.

Instead of wiring `MediaQuery`, `LayoutBuilder`, and hard-coded width checks
into every screen, you describe the shape you want:

- `MagicFlex` keeps siblings side-by-side while each child still has a
  comfortable width, then stacks them automatically.
- `MagicGrid` picks a sensible column count from the available width and your
  preferred tile width.
- `MagicContainer` and `SmartContainer` cap content width and scale padding so
  wide layouts do not feel stretched.

## Why it exists

Flutter responsiveness often turns into repetitive plumbing:

- measure the screen
- define breakpoints
- duplicate row and column markup
- recalculate grid counts by hand

`magic_responsive` pushes that into a small heuristic layer so most layouts can
adapt from mobile to desktop with far less boilerplate.

## Features

- Container-aware layout decisions
- Width-per-child heuristic instead of hard-coded breakpoints
- Optional animated layout transitions
- Auto-expanding horizontal panels with one flag
- Grid column calculation with no manual `crossAxisCount`
- Adaptive content width and padding for web and desktop shells

## Getting started

Add the package:

```yaml
dependencies:
  magic_responsive: ^0.0.1
```

Then import it:

```dart
import 'package:magic_responsive/magic_responsive.dart';
```

## Usage

### MagicFlex

```dart
MagicFlex(
  minChildWidth: 280,
  spacing: 24,
  expandChildrenWhenHorizontal: true,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: const [
    ProfileSummaryCard(),
    ActivityFeedCard(),
  ],
)
```

`MagicFlex` derives the switch point from the number of children, the spacing,
and the desired minimum width per child. In most cases that means no explicit
breakpoint is needed.

### MagicGrid

```dart
MagicGrid(
  targetChildWidth: 220,
  minChildWidth: 160,
  childAspectRatio: 1.2,
  children: products
      .map((product) => ProductCard(product: product))
      .toList(),
)
```

The grid chooses how many columns fit while trying to keep tiles close to the
target width.

### SmartContainer

```dart
SmartContainer(
  maxWidth: 1080,
  child: ListView(
    children: const [
      DashboardHeader(),
      SizedBox(height: 24),
      AnalyticsSection(),
    ],
  ),
)
```

`SmartContainer` is an alias for `MagicContainer`. It keeps content centered,
caps the maximum width, and scales side padding with the available space.

## Example

The package includes a demo app in [`example/lib/main.dart`](example/lib/main.dart)
that shows a marketing-style hero and a responsive card grid resizing across
mobile, tablet, and desktop widths.

Run it with:

```bash
cd example
flutter run -d chrome
```

## Notes

- The package uses lightweight heuristics, not expensive intrinsic
  measurement of every child.
- If you need pixel-perfect editorial layouts, you can still fall back to
  custom Flutter layout code for those screens.
