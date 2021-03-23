//
//  ViewController.swift
//  Challenge10v2
//
//  Created by Paweł Wójcik on 19/03/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var level = 1
    var passwordStrings = [String]()
    var selectedPassword = String()
    var passwordQuestionmarked = [Character]()
    var passwordForDisplay = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectPasswords()
        questionMarkPassword()
        joinCharacters()
        
        title = passwordForDisplay
    }
    
    func selectPasswords() {
        
        if let url = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            if let urlContent = try? String.init(contentsOf: url) {
                let strings = urlContent.components(separatedBy: ";")
                    
                for string in strings {
                        passwordStrings.append(string)
                }
                print("passwordStrings: \(passwordStrings)")
                
                if let selPas = passwordStrings.randomElement() {
                selectedPassword.append(selPas)
            }
                print("selectedPassword: \(selectedPassword)")
        }
    }
}
    
    
    
    func questionMarkPassword() {
    
        passwordQuestionmarked = Array(selectedPassword)
        print("passwordQuestionmarked: \(passwordQuestionmarked)")
        
        for letter in passwordQuestionmarked {
            
        }
        
       
        }
    
    
    
    func joinCharacters() {
        
        let joinedCharacters = String(passwordQuestionmarked)
    }
}
