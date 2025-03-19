import Foundation

class CalculatorEngine {
    
    var calculationText: String = ""
    var resultText: String = ""
    private var currentExpression: String = ""
    private var isResultDisplayed: Bool = false
    
    func processKeyPress(key: CalculatorKey) {
        switch key {
        case .number(let value):
            if isResultDisplayed {
                reset()
            }
            calculationText += value
            currentExpression += value
            
        case .plus, .minus, .multiply, .divide:
            if !currentExpression.isEmpty {
                calculationText += key.getText()
                currentExpression += key.getText()
            }
            
        case .point:
            if !currentExpression.contains(".") {
                calculationText += "."
                currentExpression += "."
            }
            
        case .equals:
            if !currentExpression.isEmpty {
                calculateResult()
            }
            
        case .clear:
            reset()
            
        case .backspace:
            if !calculationText.isEmpty {
                calculationText.removeLast()
                currentExpression = String(currentExpression.dropLast())
            }
            
        case .plusMinus:
            togglePlusMinus()
        }
    }
    
    private func calculateResult() {
        let formattedExpression = currentExpression
                                    .replacingOccurrences(of: "×", with: "*")
                                    .replacingOccurrences(of: "÷", with: "/")
        
        if formattedExpression.contains("/") {
            //  Manual handling for division to avoid integer truncation
            let components = formattedExpression.split(separator: "/")
            if components.count == 2,
               let dividend = Double(components[0]),
               let divisor = Double(components[1]),
               divisor != 0 {
                
                let result = dividend / divisor
                resultText = formatResult(result)
                isResultDisplayed = true
                return
            }
        }
        
        // Handle other operations using NSExpression
        let expression = NSExpression(format: formattedExpression)
        if let result = expression.expressionValue(with: nil, context: nil) as? Double {
            resultText = formatResult(result)
            isResultDisplayed = true
        }
    }

    private func formatResult(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value)) // No decimal places for whole numbers
        } else {
            return String(format: "%.6f", value).replacingOccurrences(of: "\\.?0+$", with: "", options: .regularExpression)
        }
    }

    private func togglePlusMinus() {
        if currentExpression.hasPrefix("-") {
            currentExpression.removeFirst()
            calculationText.removeFirst()
        } else {
            currentExpression = "-" + currentExpression
            calculationText = "-" + calculationText
        }
    }
    
    private func reset() {
        calculationText = ""
        resultText = ""
        currentExpression = ""
        isResultDisplayed = false
    }
    
    private func cleanDecimalPoint(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value))
        } else {
            return String(format: "%.6f", value).trimmingCharacters(in: CharacterSet(charactersIn: "0").inverted)
        }
    }
}
