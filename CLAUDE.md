# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Faiadashu FHIRDash is a Flutter package that provides widgets for building healthcare applications following the HL7® FHIR® R4 standard. It focuses on UI components for FHIR questionnaires, clinical observations, and healthcare data visualization.

## Development Commands

Use fvm for all flutter commands.

### Core Flutter Commands

- `fvm flutter pub get` - Install dependencies
- `fvm flutter pub upgrade` - Update dependencies
- `fvm flutter test` - Run tests
- `fvm flutter analyze` - Static analysis

### Project-Specific Commands

- `./tool/upgrade_packages.sh` - Upgrade packages for all projects (main, faiadashu_online, faiabench, example)
- `./tool/generate_localizations.sh` - Generate localizations and format code
- `fvm flutter gen-l10n` - Generate localization files only
- `dart format --fix lib` - Format library code

### Example App Commands

- `cd example && flutter run` - Run the example application
- `./example/tool/run_web.sh` - Run example app for web
- `./example/tool/build_android_release.sh` - Build Android release

### Benchmarking App Commands

- `cd faiabench && flutter run` - Run the benchmarking app
- `./faiabench/tool/run_web.sh` - Run benchmark app for web

## Architecture

### Core Module Structure

The library is organized into several main modules under `lib/`:

- **questionnaires/** - Core questionnaire functionality

  - `model/` - Data models (QuestionnaireModel, QuestionnaireResponseModel, item models)
  - `view/` - UI widgets (QuestionnaireResponseFiller, QuestionnaireScrollerPage, QuestionnaireStepperPage)
  - `resource_provider/` - FHIR resource providers

- **fhir_types/** - FHIR data type widgets and extensions
- **observations/** - Clinical observation display components
- **l10n/** - Internationalization (supports EN, DE, ES, AR, JA, FR, IT)
- **coding/** - FHIR coding system support
- **logging/** - Logging utilities
- **resource_provider/** - Base resource provider interfaces

### Key Design Patterns

#### Model-View-Provider Architecture

- **Models** (`questionnaires/model/`): Handle FHIR questionnaire logic and state
- **Views** (`questionnaires/view/`): UI widgets that consume models
- **Providers** (`resource_provider/`): Abstract data access layer

#### Widget Composition

- `QuestionnaireResponseFiller` - Main orchestrator widget
- `QuestionnaireItemFiller` - Individual question widgets
- Presentation widgets: `QuestionnaireScrollerPage`, `QuestionnaireStepperPage`

#### Expression Evaluation

- FHIRPath expression support for dynamic questionnaire behavior
- Expression evaluators in `questionnaires/model/expression/`

### Important Classes

- `QuestionnaireModel` - Represents a FHIR questionnaire
- `QuestionnaireResponseModel` - Manages questionnaire responses and validation
- `QuestionnaireItemModel` - Individual questionnaire items
- `FhirResourceProvider` - Interface for FHIR resource access
- `LaunchContext` - Initialization context for questionnaires

## Code Quality

### Analysis Configuration

- Uses `package:lint` for standard Dart linting
- `dart_code_metrics` for advanced code quality metrics
- Cyclomatic complexity limit: 20
- Max nesting level: 5
- Max parameters: 6
- Source lines per method: 80

### Code Formatting

- Line length limit disabled (lines_longer_than_80_chars: false)
- Trailing comma preferred
- Single widget per file (with private widget exceptions)

## Dependencies

### Core Dependencies

- `fhir: ^0.8.0` - FHIR R4 data models (uses forked version from phellowseven)
- `fhir_path` - FHIRPath expression evaluation (git dependency)
- `flutter_localizations` - Internationalization support
- `intl: ^0.19.0` - Localization utilities

### UI Dependencies

- `webview_flutter` - Web content display
- `scrollable_positioned_list` - Advanced scrolling
- `simple_html_css` - HTML/CSS rendering
- `file_selector` - File picking functionality

## Testing

Run tests with standard Flutter command:

```bash
fvm flutter test
```

Tests are excluded from code metrics analysis.

## Localization

The package supports multiple languages with ARB files in `lib/l10n/arb/`:

- English (en) - Primary
- German (de)
- Spanish (es)
- Arabic (ar)
- Japanese (ja)
- French (fr)
- Italian (it)

Generate localizations after ARB file changes:

```bash
./tool/generate_localizations.sh
```
