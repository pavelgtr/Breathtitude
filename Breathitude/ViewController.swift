// viewController.swift

import UIKit

class ViewController: UIViewController {
    
    let buttonOne = UIButton()
    let buttonTwo = UIButton()
    let buttonThree = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        setupLabel()
        setupConstraints()
        setupButtonActions()
    }
    
    private func setupButtons() {
        setupButton(buttonOne, title: SelectProgram.Program.wimHof.rawValue, backgroundColor: UIColor(hex: 0xA878EC))
        setupButton(buttonTwo, title: SelectProgram.Program.pavel.rawValue, backgroundColor: UIColor(hex: 0x80D197))
        setupButton(buttonThree, title: SelectProgram.Program.tonyRobbins.rawValue, backgroundColor: UIColor(hex: 0x19A7CE))
    }
    
    private func setupButton(_ button: UIButton, title: String, backgroundColor: UIColor) {
        view.addSubview(button)
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 10
    }
    
    private func setupLabel() {
        let myLabel = UILabel()
        view.addSubview(myLabel)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.adjustsFontSizeToFitWidth = true
        myLabel.text = "Welcome to Meditation for Dummies"
        myLabel.textAlignment = .center
        myLabel.font = .systemFont(ofSize: 25)
        myLabel.numberOfLines = 2
        myLabel.sizeToFit()
    }
    
    private func setupConstraints() {
        guard let myLabel = view.subviews.first(where: { $0 is UILabel }) as? UILabel else {
            print("No UI Label found in subviews")
            return
        }
        let bottomMargin: CGFloat = view.bounds.width > view.bounds.height ? -80 : -150
        
        NSLayoutConstraint.activate([
            // MyLabel constraints
            myLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            myLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            myLabel.bottomAnchor.constraint(equalTo: buttonOne.topAnchor, constant: bottomMargin),
            
            // Button constraints
            buttonOne.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonOne.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            buttonOne.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            buttonOne.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonOne.heightAnchor.constraint(equalToConstant: 40),
            
            buttonTwo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            buttonTwo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            buttonTwo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonTwo.topAnchor.constraint(equalTo: buttonOne.bottomAnchor, constant: 25),
            buttonTwo.heightAnchor.constraint(equalToConstant: 40),
            
            buttonThree.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            buttonThree.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            buttonThree.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonThree.topAnchor.constraint(equalTo: buttonTwo.bottomAnchor, constant: 25),
            buttonThree.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setupButtonActions() {
        buttonOne.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        buttonTwo.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        buttonThree.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        print("\(sender.currentTitle ?? "Button") was tapped!")
        
        let playerViewController = PlayerViewController() //creates an instance of the next view
        self.navigationController?.pushViewController(playerViewController, animated: true) //pushViewcontroller is used when building UIKit programmatically
        playerViewController.selectedButtonTitle = sender.currentTitle ?? ""
        playerViewController.myImage.backgroundColor = sender.backgroundColor
    }
    
}
