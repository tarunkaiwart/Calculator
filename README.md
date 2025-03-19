# Calculator

1. Project Title and Description

# Calculator App (C# to Swift Migration)
This project is a migration of a calculator application from **Xamarin C#** to **native iOS Swift (UIKit)**. The goal of this migration is to ensure feature parity, performance improvements, and better platform integration using Swift.


---

2. Table of Contents

## Table of Contents
- [Project Overview](#project-overview)  
- [Tech Stack](#tech-stack)  
- [Features](#features)  
- [Installation](#installation)  
- [Architecture](#architecture)  
- [Migration Strategy](#migration-strategy)  
- [Challenges and Fixes](#challenges-and-fixes)  
- [Testing](#testing)  
- [Contributing](#contributing)  
- [License](#license)


---

3. Project Overview

## Project Overview
This project was originally built in Xamarin C# and migrated to Swift (UIKit) to leverage native iOS capabilities and improve app performance.
- **Source Framework:** Xamarin (C#)  
- **Target Framework:** Swift (UIKit)  
- **Goal:** Feature parity, performance optimization, and better native experience


---

4. Tech Stack

## Tech Stack
- **Swift** – Primary language for development  
- **UIKit** – For building the UI programmatically  
- **Xcode** – Development environment  
- **NSExpression** – For handling calculations  
- **Auto Layout** – For flexible UI design


---

5. Features

## Features
✅ Same UI layout and functionality as original C# app  
✅ Supports all basic arithmetic operations (+, -, ×, ÷)  
✅ Prevents multiple consecutive operators (e.g., 55++55)  
✅ Handles decimal precision correctly (e.g., 8 ÷ 5 = 1.6)  
✅ Maintains input after pressing '='  
✅ Auto Layout for responsive UI across devices


---

6. Installation

## Installation
1. Clone the repository:
```bash
git clone https://github.com/username/calculator-migration.git

2. Open the project in Xcode:



cd calculator-migration
open CalculatorApp.xcodeproj

3. Build and Run:



Select target device/simulator in Xcode

Press Cmd + R to run the app


---

### **7. Architecture**  
```markdown
## Architecture
- **MVC (Model-View-Controller):**  
  - `Model` – Contains the business logic (e.g., CalculatorEngine)  
  - `View` – Handles UI components (e.g., CalculatorViewController)  
  - `Controller` – Manages data flow and user interactions


---

8. Migration Strategy

## Migration Strategy
1. Analyzed C# code and defined target Swift structure  
2. Created UIViewController and set up Auto Layout programmatically  
3. Migrated business logic from C# to Swift using CalculatorEngine  
4. Implemented button handling and calculation processing  
5. Resolved edge cases like division precision and multiple operators


---

9. Challenges and Fixes

## Challenges and Fixes
### ➡️ Issue: Division result truncation (8 ÷ 5 showing as 1)  
**Fix:** Used `Double` instead of `Int` and handled decimal formatting manually  

### ➡️ Issue: Input clearing after `=` press  
**Fix:** Preserved input history in `calculationText` after calculation  

### ➡️ Issue: UI misalignment on different screen sizes  
**Fix:** Used Auto Layout for flexible and dynamic positioning


---

10. Testing

## Testing
### ✅ Unit Tests:
- Business logic (CalculatorEngine)  
- Edge cases for operators and division  

### ✅ UI Tests:
- Input handling  
- Correct result display  
- Button interactions


