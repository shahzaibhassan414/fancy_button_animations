# Fancy Button Animations

A lightweight and easy-to-use Flutter package for adding beautiful, interactive animations to your buttons. Stand out from the crowd with scale, pulse, and glow effects!

## Features

- **Scale Animation**: Shrinks slightly when pressed, providing tactile feedback.
- **Pulse Animation**: A continuous, gentle growing/shrinking effect to draw attention.
- **Glow Animation**: Adds a soft, customizable glow around your button.
- **Customizable**: Control duration, scale factors, colors, and more.

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  fancy_button_animations: ^0.0.1
```

Or run:

```bash
flutter pub add fancy_button_animations
```

## Usage

Import the package:

```dart
import 'package:fancy_button_animations/fancy_button_animations.dart';
```

### Basic Scale Button

```dart
FancyButton(
  onPressed: () => print("Button Pressed!"),
  child: const Text("Tap Me", style: TextStyle(color: Colors.white)),
)
```

### Pulse Button

```dart
FancyButton(
  style: FancyButtonStyle.pulse,
  color: Colors.purple,
  onPressed: () {},
  child: const Text("Look at Me!", style: TextStyle(color: Colors.white)),
)
```

### Glow Button

```dart
FancyButton(
  style: FancyButtonStyle.glow,
  color: Colors.orange,
  onPressed: () {},
  child: const Text("Glowing Button", style: TextStyle(color: Colors.white)),
)
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `child` | `Widget` | *Required* | The widget inside the button (usually a Text). |
| `onPressed` | `VoidCallback?` | `null` | Callback when the button is tapped. |
| `style` | `FancyButtonStyle` | `FancyButtonStyle.scale` | The animation type (`scale`, `pulse`, `glow`). |
| `config` | `FancyButtonConfig` | `const FancyButtonConfig()` | Animation timing and factor settings. |
| `color` | `Color?` | `Theme primary` | Background color of the button. |
| `padding` | `EdgeInsetsGeometry` | `horiz: 24, vert: 12` | Inner spacing. |
| `borderRadius`| `BorderRadius?` | `circular(8)` | Roundness of the button corners. |

### FancyButtonConfig

| Field | Type | Default |
|-------|------|---------|
| `scaleFactor` | `double` | `0.95` |
| `duration` | `Duration` | `150ms` |
| `curve` | `Curve` | `Curves.easeInOut` |

## Animations in Action

![Scale Animation](https://raw.githubusercontent.com/user/repo/main/assets/scale.gif)
![Pulse Animation](https://raw.githubusercontent.com/user/repo/main/assets/pulse.gif)

## License

MIT License.
