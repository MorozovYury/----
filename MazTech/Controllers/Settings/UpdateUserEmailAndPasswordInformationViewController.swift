//
//  UpdateUserEmailAndPasswordInformationViewController.swift
//  MazTech
//
//  Created by Yury Morozov on 12.12.2018.
//  Copyright © 2018 Yury Morozov. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UpdateUserEmailAndPasswordInformationViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myScrollView.delegate = self
        
        setupConstraintsForAllElements()
        setupTextFieldsDelegateAndNotifications()
        dismissKeyboardWhenTouchOutside()
        fetchEmailProfileInformation()
    }
    
    // MARK: - Fetch Email Profile Information
    public func fetchEmailProfileInformation(){
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        Database.database().reference().child("listOfUsers").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let user = UserProfileInformation(dictionary: dictionary)
                self.setupAllElenets(user)
                print("Success fetch email data: \(user)")
            }
            
        }, withCancel: nil)
        
        
    }// end of fetchUserProfileInformation
    
    // MARK: - Setup All Elements
    public func setupAllElenets(_ user: UserProfileInformation) {
        let email = emailTextField
        email.text = user.email
        
    }// end of setupAllElenets
    
    // MARK: Create a Scrollview
    private let myScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isPagingEnabled = true
        scroll.indicatorStyle = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    // MARK: Label for Container with email and password
    private let emailAndPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Обновление данных"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Container with email and update button
    public let inputsEmailWithUpdateButtonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    // MARK: - email TextField, Separator
    public var emailTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "petrov@romaska.ru"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.white
        text.clearButtonMode = .whileEditing
        text.keyboardType = .emailAddress
        text.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        return text
    }()
    
    // MARK: - Container with email and update button
    public let inputsPasswordWithUpdateButtonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    // MARK: - Passord TextField, Separator
    public var passwordTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Пароль"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.white
        text.clearButtonMode = .whileEditing
        text.isSecureTextEntry = true
        text.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        return text
    }()
    
    // MARK: - Back to SettVC Button creating
    lazy var backToSettingsVcButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setImage(UIImage(named: "icon-back button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backToSettVCButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - backToLoginVcButton action
    @objc func backToSettVCButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Update User Profile Information Button creating
    lazy var updateUserEmailButton: UIButton = {
        
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Обновить эл.почту", for: .normal  )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleUpdateUserEmailButton), for: .touchUpInside)
        
        button.alpha = 0.5
        button.isEnabled = false
        
        return button
    }()
    
    // MARK: - updateUserPasswordButton creating
    lazy var updateUserPasswordButton: UIButton = {
        
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Обновить пароль", for: .normal  )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleUpdateUserPasswordButton), for: .touchUpInside)
        
        button.alpha = 0.5
        button.isEnabled = false
        
        return button
    }()
    
    
    func setUpdateUserEmailButton(enabled:Bool) {
        if enabled {
            updateUserEmailButton.alpha = 1.0
            updateUserEmailButton.isEnabled = true
        } else {
            updateUserEmailButton.alpha = 0.5
            updateUserEmailButton.isEnabled = false
        }
    }
    
    func setUpdateUserPasswordButton(enabled:Bool) {
        if enabled {
            updateUserPasswordButton.alpha = 1.0
            updateUserPasswordButton.isEnabled = true
        } else {
            updateUserPasswordButton.alpha = 0.5
            updateUserPasswordButton.isEnabled = false
        }
    }
    
    // MARK: - Chech email text field
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    // MARK: - textFieldChanged adding
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailTextField.text
        let password = passwordTextField.text
        let emailFormFilled = email != nil && email != ""
        setUpdateUserEmailButton(enabled: emailFormFilled)
        let passwordFormFilled = password != nil && password != ""
        setUpdateUserPasswordButton(enabled: passwordFormFilled)
    }
    
    // MARK: - updateUserProfileInformationButton method
    @objc func handleUpdateUserEmailButton() {
        
        setUpdateUserEmailButton(enabled:false)
        
        guard let email = emailTextField.text else {
            print("Form is not valid")
            return
        }
        
        if validateEmail(enteredEmail: email) {
            let emailAlert = UIAlertController(title: "Внимание!", message: "Введите корректно Ваш эл.адресс", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            emailAlert.addAction(okAction)
            self.present(emailAlert, animated: true) {
                self.setUpdateUserEmailButton(enabled: false)
                self.updateUserEmailButton.setTitle("Обновить эл.полчту", for: .normal)
            }
        }
        
        let usersReference = Database.database().reference().child("listOfUsers").child((Auth.auth().currentUser?.uid)!)
        
        if let updatedEmail = emailTextField.text {
            Auth.auth().currentUser?.updateEmail(to: email, completion: { (error) in
                if error == nil {
                    usersReference.updateChildValues(["email" : updatedEmail], withCompletionBlock: { (error, reference) in
                        let updateEmailAlert = UIAlertController(title: "Внимание!", message: "Произошла ошибка при обновлении эл.адреса: \(error!.localizedDescription)", preferredStyle: .alert)
                        let tryAgainAction = UIAlertAction(title: "Попробовать снова", style: .default, handler: nil)
                        updateEmailAlert.addAction(tryAgainAction)
                        self.present(updateEmailAlert, animated: true, completion: {
                            self.setUpdateUserEmailButton(enabled: false)
                            self.updateUserEmailButton.setTitle("Обновить эл.полчту", for: .normal)
                        })
                        
                    })
                } else {
                    print("Success of update email")
                    let updatedEmailAlert = UIAlertController(title: "Почта успешно обновлена", message: nil, preferredStyle: .alert)
                    let tryAgainAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    updatedEmailAlert.addAction(tryAgainAction)
                    self.present(updatedEmailAlert, animated: true)
                }
            })// end of Auth
        } //end of IF updatedEmail
        
    }// end of handleUpdateUserProfInfoButton
    
    // MARK: - handleUpdateUserPasswordButton
    @objc func handleUpdateUserPasswordButton(){
        
        setUpdateUserPasswordButton(enabled:false)
        
        guard let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        Auth.auth().currentUser?.updatePassword(to: password, completion: { (error) in
            if error == nil {
                let updatedPasswordAlert = UIAlertController(title: "Внимание!", message: "Произошла ошибка при обновлении пароля: \(error!.localizedDescription)", preferredStyle: .alert)
                let tryAgainAction = UIAlertAction(title: "Попробовать снова", style: .default, handler: nil)
                updatedPasswordAlert.addAction(tryAgainAction)
                self.present(updatedPasswordAlert, animated: true, completion: {
                    self.setUpdateUserPasswordButton(enabled: false)
                    self.updateUserPasswordButton.setTitle("Обновить пароль", for: .normal)
                })
            } else {
                print("Success of update password")
                let updatedPassAlert = UIAlertController(title: "Пароль успешно обновлен", message: nil, preferredStyle: .alert)
                let tryAgainAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.dismiss(animated: true, completion: nil)
                })
                updatedPassAlert.addAction(tryAgainAction)
                self.present(updatedPassAlert, animated: true)
            }
        })
        
        
    }// end of method handleUpdateUserPasswordButton
    
    //MARK: - Add TextFields delegate and notifications
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
    
    // MARK: - Add Labels, containers and TextFields into view and create constarints
    fileprivate func setupConstraintsForAllElements() {
        
        // MARK: - constarints for myScrollView
        view.addSubview(myScrollView)
        
        myScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        myScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        myScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        // MARK: constarints for profileLabel
        myScrollView.addSubview(emailAndPasswordLabel)
        
        emailAndPasswordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
        emailAndPasswordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        emailAndPasswordLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 12).isActive = true
        
        // MARK: - constarints for inputsEmailWithUpdateButtonContainerView
        myScrollView.addSubview(inputsEmailWithUpdateButtonContainerView)
        
        inputsEmailWithUpdateButtonContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsEmailWithUpdateButtonContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        inputsEmailWithUpdateButtonContainerView.topAnchor.constraint(equalTo: emailAndPasswordLabel.bottomAnchor, constant: 10).isActive = true
        inputsEmailWithUpdateButtonContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        // MARK: - emailTextField and separator constraints
        inputsEmailWithUpdateButtonContainerView.addSubview(emailTextField)
        
        emailTextField.heightAnchor.constraint(equalTo: inputsEmailWithUpdateButtonContainerView.heightAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputsEmailWithUpdateButtonContainerView.topAnchor).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: inputsEmailWithUpdateButtonContainerView.leftAnchor, constant: 8).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: inputsEmailWithUpdateButtonContainerView.rightAnchor, constant: -16).isActive = true
        
        // MARK: - updateUserEmailButton constraints
        myScrollView.addSubview(updateUserEmailButton)
        
        updateUserEmailButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        updateUserEmailButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        updateUserEmailButton.topAnchor.constraint(equalTo: inputsEmailWithUpdateButtonContainerView.bottomAnchor, constant: 10).isActive = true
        updateUserEmailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // MARK: - constarints for inputsPasswordWithUpdateButtonContainerView
        myScrollView.addSubview(inputsPasswordWithUpdateButtonContainerView)
        
        inputsPasswordWithUpdateButtonContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsPasswordWithUpdateButtonContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        inputsPasswordWithUpdateButtonContainerView.topAnchor.constraint(equalTo: updateUserEmailButton.bottomAnchor, constant: 10).isActive = true
        inputsPasswordWithUpdateButtonContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        // MARK: - passwordTextField constraints
        
        inputsPasswordWithUpdateButtonContainerView.addSubview(passwordTextField)
        
        passwordTextField.heightAnchor.constraint(equalTo: inputsPasswordWithUpdateButtonContainerView.heightAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: inputsPasswordWithUpdateButtonContainerView.topAnchor).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: inputsPasswordWithUpdateButtonContainerView.leftAnchor, constant: 8).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: inputsPasswordWithUpdateButtonContainerView.rightAnchor, constant: -16).isActive = true
        
        // MARK: - updateUserPasswordButton constraints
        myScrollView.addSubview(updateUserPasswordButton)
        
        updateUserPasswordButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        updateUserPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        updateUserPasswordButton.topAnchor.constraint(equalTo: inputsPasswordWithUpdateButtonContainerView.bottomAnchor, constant: 10).isActive = true
        updateUserPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // MARK: - Setup constraints and add buttobs to view for back an
        view.addSubview(backToSettingsVcButton)
        
        // MARK: - Back to LoginVC button
        backToSettingsVcButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        backToSettingsVcButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        backToSettingsVcButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 28).isActive = true
        backToSettingsVcButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        
    }//end of method
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
            return true
        } else {
            textField.resignFirstResponder()
            return true
        }
    }// end of method
    
    // MARK: - dismissKeyboardWhenTouchOutside
    private func dismissKeyboardWhenTouchOutside() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToView)))
    }
    @objc func tapToView() {
        //Dismiss keyboard
        view.endEditing(true)
    }
    
    // MARK - Status Bar change color
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
}// end of class
