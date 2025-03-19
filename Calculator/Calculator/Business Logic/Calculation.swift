//
//  Calculation.swift
//  Calculator
//
//  Created by shubham.garg19 on 19/03/25.
//


import Foundation

class Calculation {
    
    static func calculateResult(keys: [CalculatorKey]) -> String {
        var elements = [String]()
        var currentNumber = ""
        
        for key in keys {
            switch key {
            case .number(let value):
                currentNumber += value
            case .point:
                if !currentNumber.contains(".") {
                    currentNumber += "."
                }
            case .plus, .minus, .multiply, .divide:
                if !currentNumber.isEmpty {
                    elements.append(currentNumber)
                    currentNumber = ""
                }
                elements.append(key.getText())
            case .equals:
                if !currentNumber.isEmpty {
                    elements.append(currentNumber)
                }
            default:
                break
            }
        }
        
        if !currentNumber.isEmpty {
            elements.append(currentNumber)
        }
        
        if elements.isEmpty { return "0" }
        
        // Handle Multiplication and Division First (Operator Precedence)
        var processedElements = processMultiplicationAndDivision(elements)
        
        // Handle Addition and Subtraction
        let result = processAdditionAndSubtraction(processedElements)
        
        // Clean trailing decimal point if present
        return cleanDecimalPoint(result)
    }
    
    // Handles multiplication and division (higher precedence)
    private static func processMultiplicationAndDivision(_ elements: [String]) -> [String] {
        var result = [String]()
        var index = 0
        
        while index < elements.count {
            let element = elements[index]
            
            if element == "×" || element == "÷" {
                if let left = Double(result.last ?? ""), let right = Double(elements[index + 1]) {
                    let value = element == "×" ? left * right : (right != 0 ? left / right : 0)
                    result[result.count - 1] = String(value)
                    index += 1 // Skip next element since it's already processed
                }
            } else {
                result.append(element)
            }
            index += 1
        }
        
        return result
    }
    
    // Handles addition and subtraction (lower precedence)
    private static func processAdditionAndSubtraction(_ elements: [String]) -> Double {
        var result: Double = 0
        var currentOperation: String?
        
        for element in elements {
            if let value = Double(element) {
                if let operation = currentOperation {
                    if operation == "+" {
                        result += value
                    } else if operation == "-" {
                        result -= value
                    }
                } else {
                    result = value
                }
            } else if element == "+" || element == "-" {
                currentOperation = element
            }
        }
        
        return result
    }
    
    // Removes trailing ".0" if the result is an integer
    private static func cleanDecimalPoint(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value))
        } else {
            return String(format: "%.6f", value).trimmingCharacters(in: CharacterSet(charactersIn: "0").inverted)
        }
    }
}


