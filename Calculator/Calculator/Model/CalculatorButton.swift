//
//  CalculatorButton.swift
//  Calculator
//
//  Created by shubham.garg19 on 19/03/25.
//

import Foundation

enum CalculatorKey {
    case number(String)
    case plus
    case minus
    case multiply
    case divide
    case equals
    case clear
    case backspace
    case point
    case plusMinus
    
    func getText() -> String {
        switch self {
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "×"
        case .divide: return "/"
        case .equals: return "="
        case .clear: return "C"
        case .backspace: return "←"
        case .point: return "."
        case .plusMinus: return "±"
        case .number(let value): return value
        }
    }
    
    func isOperation() -> Bool {
        switch self {
        case .plus, .minus, .multiply, .divide:
            return true
        default:
            return false
        }
    }
}

struct CalculatorButton {
    let key: CalculatorKey
    let text: String
    
    init(key: CalculatorKey) {
        self.key = key
        self.text = key.getText()
    }
}
