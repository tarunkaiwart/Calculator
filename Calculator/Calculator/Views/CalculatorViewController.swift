import UIKit

class CalculatorViewController: UIViewController {
    
    let engine = CalculatorEngine()
    
    let inputLabel = UILabel()
    let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        // Input Text View Configuration
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        inputLabel.textAlignment = .right
        inputLabel.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        inputLabel.textColor = .lightGray
        inputLabel.text = ""
        inputLabel.numberOfLines = 1
        inputLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(inputLabel)
        
        NSLayoutConstraint.activate([
            inputLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            inputLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            inputLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            inputLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Result View Configuration
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.textAlignment = .right
        resultLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        resultLabel.textColor = .white
        resultLabel.text = "0"
        resultLabel.numberOfLines = 1
        resultLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: inputLabel.bottomAnchor, constant: 10),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            resultLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Define Calculator Buttons Layout
        let buttonTitles: [[CalculatorKey]] = [
            [.backspace, .clear, .plusMinus, .divide],
            [.number("7"), .number("8"), .number("9"), .multiply],
            [.number("4"), .number("5"), .number("6"), .minus],
            [.number("1"), .number("2"), .number("3"), .plus],
            [.number("0"), .point, .equals]
        ]
        
        let buttonHeight: CGFloat = 70
        let buttonWidth: CGFloat = 80
        let spacing: CGFloat = 12
        
        var previousRowBottomAnchor: NSLayoutYAxisAnchor = resultLabel.bottomAnchor
        
        for (rowIndex, row) in buttonTitles.enumerated() {
            var previousButtonTrailingAnchor: NSLayoutXAxisAnchor? = nil
            
            for (colIndex, key) in row.enumerated() {
                let button = UIButton(type: .system)
                button.setTitle(key.getText(), for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 28, weight: .semibold)
                button.backgroundColor = key.isOperation() ? .orange : .darkGray
                button.setTitleColor(.white, for: .normal)
                button.layer.cornerRadius = 12
                button.translatesAutoresizingMaskIntoConstraints = false
                
                // Add action
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                button.tag = rowIndex * 4 + colIndex
                view.addSubview(button)
                
                // Auto Layout Constraints
                NSLayoutConstraint.activate([
                    button.heightAnchor.constraint(equalToConstant: buttonHeight),
                    button.widthAnchor.constraint(equalToConstant: buttonWidth)
                ])
                
                if let previousButton = previousButtonTrailingAnchor {
                    button.leadingAnchor.constraint(equalTo: previousButton, constant: spacing).isActive = true
                } else {
                    button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
                }
                
                button.topAnchor.constraint(equalTo: previousRowBottomAnchor, constant: rowIndex == 0 ? 20 : spacing).isActive = true
                
                previousButtonTrailingAnchor = button.trailingAnchor
            }
            
            if let lastButton = view.subviews.last as? UIButton {
                previousRowBottomAnchor = lastButton.bottomAnchor
            }
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let key = getKey(from: sender.tag) else { return }
        
        // Prevent operators as the first character
        if engine.calculationText.isEmpty, key.isOperation() {
            return
        }
        
        engine.processKeyPress(key: key)
        updateDisplay()
    }
    
    private func getKey(from tag: Int) -> CalculatorKey? {
        let buttonKeys: [[CalculatorKey]] = [
            [.clear, .plusMinus, .backspace, .divide],
            [.number("7"), .number("8"), .number("9"), .multiply],
            [.number("4"), .number("5"), .number("6"), .minus],
            [.number("1"), .number("2"), .number("3"), .plus],
            [.number("0"), .point, .equals]
        ]
        
        let row = tag / 4
        let col = tag % 4
        
        if row < buttonKeys.count, col < buttonKeys[row].count {
            return buttonKeys[row][col]
        }
        return nil
    }
    
    private func updateDisplay() {
        // Keep input visible after '=' press
        inputLabel.text = engine.calculationText.isEmpty ? "" : engine.calculationText
        
        //  Show result separately
        if !engine.resultText.isEmpty {
            resultLabel.text = engine.resultText
        } else {
            resultLabel.text = "0"
        }
    }
}
