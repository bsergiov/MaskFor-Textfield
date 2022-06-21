//
//  PhoneFormater.swift
//  MaskFor Textfield
//
//  Created by BSergio on 20.06.2022.
//

import UIKit

protocol InputMaskProtocol {
    func formattedString(from plainString: String) -> String
    func mask(_ textField: UITextField, range: NSRange, replacementString string: String) -> Bool
}

class PhoneFormatter {
    
    
    // MARK: - Properties
    
    private var pattern: String
    
    private let digit: Character = "#"
    private let alphabetic: Character = "*"
    
    // MARK: - Lifecycle
    
    init(pattern: String = "+# (###) ###-##-##") {
        self.pattern = pattern
    }
    
    /// Befor recomend use
    /// let filteredInput = String("plainString".unicodeScalars.filter(CharacterSet.alphanumerics.contains))
    func formattedString(from plainString: String) -> String {
        guard !pattern.isEmpty else { return plainString }
        
        let pattern: [Character] = Array(self.pattern)
        let allowedCharachters = CharacterSet.alphanumerics
        let filteredInput = String(plainString.unicodeScalars.filter(allowedCharachters.contains))
        let input: [Character] = Array(filteredInput)
        var formatted: [Character] = []
        
        var patternIndex = 0
        var inputIndex = 0
        
    loop: while inputIndex < input.count {
        let inputCharacter = input[inputIndex]
        let allowed: CharacterSet
        
        guard patternIndex < pattern.count else { break loop }
        
        switch pattern[patternIndex] {
        case digit:
            allowed = .decimalDigits
        case alphabetic:
            allowed = .letters
        default:
            formatted.append(pattern[patternIndex])
            patternIndex += 1
            continue loop
        }
        
        guard inputCharacter.unicodeScalars.allSatisfy(allowed.contains) else {
            inputIndex += 1
            continue loop
        }
        
        formatted.append(inputCharacter)
        patternIndex += 1
        inputIndex += 1
    }
        
        return String(formatted)
    }
}

extension PhoneFormatter: InputMaskProtocol {
    func mask(_ textField: UITextField, range: NSRange, replacementString string: String) -> Bool {
        let string = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
                let formatted = formattedString(from: string)
                textField.text = formatted
                return formatted.isEmpty
    }
}
