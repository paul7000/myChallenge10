//
//  ViewController.swift
//  Challenge10
//
//  Created by Paweł Wójcik on 06/03/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var deathScore = 3
    var level = 1
    
    var passwords = [String]()
    var selectedPassword = String()
    var passwordToDisplay = String() {
        didSet {
            passwordLabel.placeholder = passwordToDisplay
        }
    }
    var usedLetters = [String]()
    var alphabet = [String]()
    var activatedButtons = [UIButton]()
    var scoreLabel: UILabel!
    var deathScoreLabel: UILabel!
    var passwordLabel: UITextField!
    var buttons = [UIButton]()
    var categoryLabel: UILabel!
    let categories = ["Family", "Body"]
    
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score: \(score)"
        scoreLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(scoreLabel)
        scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        scoreLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        
        deathScoreLabel = UILabel()
        deathScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        deathScoreLabel.text = "Life: \(deathScore)"
        deathScoreLabel.font = UIFont.systemFont(ofSize: 24)
        deathScoreLabel.backgroundColor = .red
        view.addSubview(deathScoreLabel)
        deathScoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        deathScoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        
        categoryLabel = UILabel()
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.text = "Category:  \(categories[level - 1])"
        categoryLabel.font = UIFont.systemFont(ofSize: 45)
        view.addSubview(categoryLabel)
        categoryLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 50).isActive = true
        categoryLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        
        passwordLabel = UITextField()
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.isUserInteractionEnabled = false
        passwordLabel.placeholder = "TEST TEXT"
        passwordLabel.font = UIFont.systemFont(ofSize: 44)
        passwordLabel.textAlignment = .center
        view.addSubview(passwordLabel)
        passwordLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 20).isActive = true
        passwordLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        passwordLabel.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -100).isActive = true
        
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        buttonsView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20).isActive = true
        buttonsView.widthAnchor.constraint(equalToConstant: 700).isActive = true
        buttonsView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        
        let heigh = 100
        let width = 100
        
        for row in 0..<5 {
            for col in 0..<7 {
                let button = UIButton(type: .system)
                button.setTitle("W", for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
                button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
                
                let frame = CGRect.init(x: col*width, y: row*heigh, width: width, height: heigh)
                button.frame = frame
                
                buttonsView.addSubview(button)
                buttons.append(button)
            }
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let stringURL = Bundle.main.url(forResource: "levell\(level)", withExtension: "txt") {
            if let levelContent = try? String.init(contentsOf: stringURL) {
                let passwordsCut = levelContent.components(separatedBy: ";")
                
                for password in passwordsCut {
                    passwords.append(password.uppercased())
                }
                print("vDL passwords: \(passwords)")
            }
        }
        
        if let plalfabetURL = Bundle.main.url(forResource: "plalfabet", withExtension: "txt") {
            if let plalfabetContent = try? String.init(contentsOf: plalfabetURL) {
                let plAlfabetLetters = plalfabetContent.components(separatedBy: " ")
                
                for letter in plAlfabetLetters {
                    alphabet.append(letter)
                }
            }
        }
    setButtonTitles()
    selectPassword()
    }
    
// KONIEC super.viewDidLoad
    

    func selectPassword () {
        if let pasSel = passwords.randomElement() {
            selectedPassword.append(pasSel)
            print("selectedPassword \(selectedPassword)")
            
            for _ in 0..<selectedPassword.count {
                passwordToDisplay += "?"
            }
            print("passwordToDisplay \(passwordToDisplay)")
            
            if let index = passwords.firstIndex(of: pasSel) {
            passwords.remove(at: index)
                print("passwordsLeft: \(passwords)")
            }
        }
    }

    
    

    func setButtonTitles() {
        if buttons.count == alphabet.count {
            for i in 0..<alphabet.count {
                buttons[i].setTitle(alphabet[i], for: .normal)
            }
        }
    }
    
    
    
    @objc func buttonTapped(sender: UIButton) {
        guard let buttonLetter = sender.titleLabel?.text else {return}
        
        usedLetters.append(buttonLetter)
        activatedButtons.append(sender)
        
        for btn in activatedButtons {
            btn.isHidden = true
        }

        var tempStr = ""
        
        for i in selectedPassword {
            if usedLetters.contains(String(i)) {
                tempStr += String(i)
            } else {
                tempStr += "?"
            }
            passwordToDisplay = tempStr
    }
        if tempStr.contains(buttonLetter) == true {
            score += 1
            if !tempStr.contains("?") {
                for btn in activatedButtons {
                    btn.isHidden = false
                }
                setNewWord()
            }
        } else {
            score -= 1
            errorMessage()
        }
        
        
    } //KONIEC
    
    
    
    
    func setNewWord() {
        
        if passwords.isEmpty {
            let ac = UIAlertController(title: "Congratulations!", message: "You move on to next category.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Let's go!", style: .cancel))
            present(ac, animated: true)
                
            level += 1
            activatedButtons.removeAll()
            usedLetters.removeAll()
            selectedPassword.removeAll()
            passwordToDisplay.removeAll()
            loadView()
            viewDidLoad()
        } else {
            let ac = UIAlertController(title: "Well done! Your score is \(score)", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .cancel))
            present(ac, animated: true)
            
        activatedButtons.removeAll()
        usedLetters.removeAll()
        selectedPassword.removeAll()
        passwordToDisplay.removeAll()
        selectPassword()
        }
    } // KONIEC
    
    
    
    
    func errorMessage() {
        let ac = UIAlertController(title: "Try again", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(ac, animated: true)
    } //KONIEC
}
