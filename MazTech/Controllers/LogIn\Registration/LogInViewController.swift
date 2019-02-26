//
//  LoginController.swift
//  MazTech
//
//  Created by Yury Morozov on 11.10.2018.
//  Copyright © 2018 Yury Morozov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    var listOfChatsTableViewController: ListOfChatsTableViewController?
    
    // MARK: - Container with emailTF and passwordTF
    public let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    // MARK: - LogIn Button creating
    lazy var logInButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Войти", for: .normal  )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
        
        button.alpha = 0.5
        button.isEnabled = false
        
        return button
    }()
    
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailTextField.text
        let password = passwordTextField.text
        let formFilled = email != nil && email != "" && password != nil && password != ""
        setLogInButton(enabled: formFilled)
    }
    
    func setLogInButton(enabled:Bool) {
        if enabled {
            logInButton.alpha = 1.0
            logInButton.isEnabled = true
        } else {
            logInButton.alpha = 0.5
            logInButton.isEnabled = false
        }
    }
    
    // MARK: - handleLogIn
    @objc func handleLogIn() {
        
        setLogInButton(enabled: false)
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                
                let signInAlert = UIAlertController(title: "Внимание!", message: "Произошла ошибка: \(error!.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                signInAlert.addAction(okAction)
                self.present(signInAlert, animated: true, completion: {
                    self.setLogInButton(enabled: false)
                    self.logInButton.setTitle("Войти", for: .normal)
                })
                
                return
            }
            
            //Successfully logged in our user
            print("Successfully logged in our user")
            self.listOfChatsTableViewController?.fetchUserAndSetupNavBarTitle()
            self.dismiss(animated: true, completion: nil)
        }
        
    }// end of method
    
    // MARK: - SignInButton creating
    lazy var signInButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Зарегистрироваться", for: .normal  )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleRegister() {
        let reg = SignInViewController()
        self.present(reg, animated: true, completion: nil)
    }
    
    // MARK: - emailTextField creating
    public let emailTextField: UITextField = {
        let email = UITextField()
        email.placeholder = "Email: ivanov@mail.ru"
        email.translatesAutoresizingMaskIntoConstraints = false
        email.keyboardType = .emailAddress
        email.clearButtonMode = .whileEditing
        email.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        return email
    }()
    
    // MARK: - passwordTextField creating
    public let passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = "Пароль: 12345"
        password.isSecureTextEntry = true
        password.translatesAutoresizingMaskIntoConstraints = false
        password.clearButtonMode = .whileEditing
        password.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        return password
    }()
    
    // MARK: - Separator for emailTextView creating
    public let sepatatorForEmailTextField: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    // MARK: - Create a label on the top of screen
    public let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "ВСЕРОССИЙСКИЙ КОНКУРС СРЕДИ ТЕХНИЧЕСКИХ СПЕЦИАЛИСТОВ"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = NSTextAlignment.center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.textColor = UIColor.white
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        //MARK: - Adding all Subview on MAIN VIEW
        view.addSubview(inputsContainerView)
        view.addSubview(logInButton)
        view.addSubview(signInButton)
        view.addSubview(logoLabel)
        
        setupinputsContainerView()
        setupSignInButton()
        setupLogInButton()
        setupLabelConstraint()
        setupTextFieldsDelegateAndNotifications()
        dismissKeyboardWhenTouchOutside()
        setupSendResetPasswordButton()
    }
    
    // MARK: - Add TextFields delegate and notifications
    fileprivate func setupTextFieldsDelegateAndNotifications(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = -120
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide , object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = 0.0
        }
    }
    
    // MARK - Status Bar change color
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // MARK: - Create for container constraints (x,y, widht, height)
    public func setupinputsContainerView() {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: - EmailTextView adding on container and crating constraints for TextView
        inputsContainerView.addSubview(emailTextField)
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -16).isActive = true
        
        // MARK: - SepatatorForEmailTextField adding on container
        inputsContainerView.addSubview(sepatatorForEmailTextField)
        sepatatorForEmailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        sepatatorForEmailTextField.heightAnchor.constraint(equalToConstant: 1).isActive = true
        sepatatorForEmailTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        sepatatorForEmailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        
        // MARK: - PasswordTextView adding on container and crating constraints for TextView
        inputsContainerView.addSubview(passwordTextField)
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: sepatatorForEmailTextField.bottomAnchor).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -16).isActive = true
    }
    
    // MARK: - Create for signIn button constraints (x,y, widht, height)
    public func setupLogInButton() {
        logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logInButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        logInButton.widthAnchor.constraint(equalTo: view.widthAnchor , constant: -24)  .isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    // MARK: - Create for register button constraints (x,y, widht, height)
    public func setupSignInButton() {
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 8).isActive = true
        signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24)  .isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    // MARK: - Create for logo image constraints (x,y, widht, height)
    public func setupLabelConstraint() {
        logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoLabel.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        logoLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16).isActive = true
        logoLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
            return true
        } else {
            textField.resignFirstResponder()
            return true
        }
    }
    
    private func dismissKeyboardWhenTouchOutside() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToView)))
    }
    @objc func tapToView() {
        //Dismiss keyboard
        view.endEditing(true)
    }
    
    // MARK: - SendResetPassoword Button creating
    lazy var sendResetPasswordButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Забыли пароль?", for: .normal  )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
        return button
    }()
    
    @objc func handleResetPassword() {
        
        let resetPasswordAlert = UIAlertController(title: "Введите Ваш e-mail", message: nil, preferredStyle: .alert)
        
        resetPasswordAlert.addTextField { (emailTextField) in
            emailTextField.placeholder = "ivanov@mazdaeur.com"
        }
        
        let sendAction = UIAlertAction(title: "Востановить", style: .default) { (action) in
            
            //let emailField = resetPasswordAlert.textFields![0]
            let email = resetPasswordAlert.textFields?.first?.text
            
            Auth.auth().sendPasswordReset(withEmail: email!, completion: { (error) in
                if error != nil {
                    let alert = UIAlertController(title: "Внимание!", message: "Произошла ошибка: \(error!.localizedDescription)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    
                    return
                }//end of if
                //Successfully logged in our user
                print("Successfully reset user passord")
            })//end of Auth.auth().sendPasswordReset
        }//end of sendAction
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        resetPasswordAlert.addAction(cancelAction)
        resetPasswordAlert.addAction(sendAction)
        
        self.present(resetPasswordAlert, animated: true, completion: nil)
        
    }//end of method
    
    // MARK: - Create for sendResetPassword button constraints (x,y, widht, height)
    public func setupSendResetPasswordButton() {
        view.addSubview(sendResetPasswordButton)
        sendResetPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendResetPasswordButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 150).isActive = true
        sendResetPasswordButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        sendResetPasswordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
}// end of class
