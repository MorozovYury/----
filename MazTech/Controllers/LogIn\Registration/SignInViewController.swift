//
//  SignInViewController.swift
//  MazTech
//
//  Created by Yury Morozov on 11.10.2018.
//  Copyright © 2018 Yury Morozov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class SignInViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    weak var listOfChatsVC = ListOfChatsTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        
        myScrollView.delegate = self
        
        setupAllContainersWithTextFieldAndProfileImageWithButton()
        setupButtons()
        setupTextFieldsDelegateAndNotifications()
        dismissKeyboardWhenTouchOutside()
    }
    
    // MARK: Create a Scrollview
    private let myScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isPagingEnabled = true
        scroll.indicatorStyle = .white
        //scroll.backgroundColor = UIColor.red
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    // MARK: Label for Container with profile text fileds
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Информация о пользователе"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Container with profile text fileds
    public let inputsProfileContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    // MARK: - fullName TextField, Separator
    public var fullNameTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Петров Иван"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.white
        text.clearButtonMode = .whileEditing
        text.autocapitalizationType = .words
        text.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        return text
    }()
    
    public let sepatatorForFullNameTextField: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.black
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    // MARK: - jobPosition TextField, Separator
    public var jobPositionTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Менеджер по продажам"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.white
        text.clearButtonMode = .whileEditing
        text.autocapitalizationType = .words
        text.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        return text
    }()
    
    public let sepatatorForJobPositionTextField: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.black
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    // MARK: - companyName TextField, Separator
    public var companyNameTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "ООО Ромашка"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.white
        text.clearButtonMode = .whileEditing
        text.autocapitalizationType = .words
        text.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        return text
    }()
    
    public let sepatatorForCompanyNameTextField: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.black
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    // MARK: - city TextField
    public var cityTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Москва"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.white
        text.clearButtonMode = .whileEditing
        text.autocapitalizationType = .words
        text.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        return text
    }()
    
    // MARK: - profileImageView
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon avatar")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    @objc func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: - profileImageView getting access to iPhone photo library, and select the photo you want
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originaImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originaImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Label for Container with email and password
    private let emailAndPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Эл.почта и пароль"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Container with email and password
    public let inputsEmailAndPasswordContainerView: UIView = {
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
        text.placeholder = "petrov@romashka.ru"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.white
        text.clearButtonMode = .whileEditing
        text.keyboardType = .emailAddress
        text.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        return text
    }()
    
    public let sepatatorForEmailTextField: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.black
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
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
    
    // MARK: - Back to LoginVC Button creating
    lazy var backToLoginVcButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setImage(UIImage(named: "icon-back button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backToLoginVCButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - backToLoginVcButton action
    @objc func backToLoginVCButton() {
        let login = LogInViewController()
        self.present(login, animated: true, completion: nil)
    }
    
    
    
    // MARK: - SignIn Button creating
    lazy var signInNewUserButton: UIButton = {
        
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Зарегистрироваться", for: .normal  )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(createNewAccountButton), for: .touchUpInside)
        
        button.alpha = 0.5
        button.isEnabled = false
        
        return button
    }()
    
    
    func setSignInButton(enabled:Bool) {
        if enabled {
            signInNewUserButton.alpha = 1.0
            signInNewUserButton.isEnabled = true
        } else {
            signInNewUserButton.alpha = 0.5
            signInNewUserButton.isEnabled = false
        }
    }
    
    // MARK: - textFieldChanged adding
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailTextField.text
        let password = passwordTextField.text
        let name = fullNameTextField.text
        let city = cityTextField.text
        let job = jobPositionTextField.text
        let company = companyNameTextField.text
        let formFilled = email != nil && email != "" && password != nil && password != "" && name != nil && name != "" && city != nil && city != "" && job != nil && job != "" && company != nil && company != ""
        setSignInButton(enabled: formFilled)
    }
    
    // MARK: - CreateNewAccountButton adding
    @objc func createNewAccountButton() {
        
        setSignInButton(enabled:false)
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = fullNameTextField.text, let city = cityTextField.text, let job = jobPositionTextField.text, let company = companyNameTextField.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result: AuthDataResult?, error) in
            if error != nil {
                let signInAlert = UIAlertController(title: "Внимание!", message: "Произошла ошибка при регистрации нового пользователя: \(error!.localizedDescription)", preferredStyle: .alert)
                let tryAgainAction = UIAlertAction(title: "Попробовать снова", style: .default, handler: nil)
                signInAlert.addAction(tryAgainAction)
                self.present(signInAlert, animated: true, completion: {
                    self.setSignInButton(enabled: false)
                    self.signInNewUserButton.setTitle("Зарегистрироваться", for: .normal)
                })
                return
            }
            //Successfully sign in our user
            print("Successfully sign in our user")
            
            // MARK: - Send email verification
            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                if error != nil {
                    let signInAlert = UIAlertController(title: "Внимание!", message: "Произошла ошибка при отправке подтверждения на эл.почту: \(error!.localizedDescription)", preferredStyle: .alert)
                    let tryAgainAction = UIAlertAction(title: "Попробовать снова", style: .default, handler: nil)
                    signInAlert.addAction(tryAgainAction)
                    self.present(signInAlert, animated: true, completion: nil)
                    return
                }
            })// end of sendEmailVerification
            
            guard let uid = result?.user.uid else {
                return
            }
            
            let imageName = Auth.auth().currentUser?.uid
            let storageRef = Storage.storage().reference().child("profile_avatars").child("\(imageName ?? "avatar").jpg")
            
            if let profileImage = self.profileImageView.image, let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) {
                
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        let saveAvatarIntoStorageAlert = UIAlertController(title: "Внимание!", message: "Произошла ошибка с сохранением профиля: \(error!.localizedDescription)", preferredStyle: .alert)
                        let tryAgainAction = UIAlertAction(title: "Попробовать снова", style: .default, handler: nil)
                        saveAvatarIntoStorageAlert.addAction(tryAgainAction)
                        self.present(saveAvatarIntoStorageAlert, animated: true, completion: nil)
                        return
                    }
                    
                    //Successfully save image
                    print("Successfully save image")
                    
                    storageRef.downloadURL(completion: { (url, error) in
                        if error != nil {
                            print(error!.localizedDescription)
                            let downloadProfileInfoAlert = UIAlertController(title: "Внимание!", message: "Произошла ошибка с загрузкой профиля: \(error!.localizedDescription)", preferredStyle: .alert)
                            let tryAgainAction = UIAlertAction(title: "Попробовать снова", style: .default, handler: nil)
                            downloadProfileInfoAlert.addAction(tryAgainAction)
                            self.present(downloadProfileInfoAlert, animated: true, completion: nil)
                            return
                        }
                        
                        if let profileImageUrl = url?.absoluteString {
                            
                            let values = ["fullName": name, "email": email, "profileImageUrl": profileImageUrl, "city": city, "companyName": company, "jobPosition": job]
                            
                            self.registerUserIntoDatabaseWithUID(uid, values: values as [String : AnyObject])
                        }
                    })
                })
            }
        }
    }
    
    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        let ref = Database.database().reference()
        let usersReference = ref.child("listOfUsers").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                let updateChildValuesAlert = UIAlertController(title: "Внимание!", message: "Произошла ошибка с сохранением профиля: \(err!.localizedDescription)", preferredStyle: .alert)
                let tryAgainAction = UIAlertAction(title: "Попробовать снова", style: .default, handler: nil)
                updateChildValuesAlert.addAction(tryAgainAction)
                self.present(updateChildValuesAlert, animated: true, completion: nil)
                
                return
            }
            
            let user = UserProfileInformation(dictionary: values)
            self.listOfChatsVC?.setupNavBarWithUser(user)
            
            let scheduleVC = EventScheduleViewController()
            let chatVC = ListOfChatsTableViewController()
            let settVC = SettingsViewController()
            let contactVC = OrganizorsContactsViewController()
            
            //MARK: - create nav controll
            let firstNavContr = UINavigationController(rootViewController: scheduleVC)
            let secondNavContr = UINavigationController(rootViewController: chatVC)
            let thrirdNavContr = UINavigationController(rootViewController: settVC)
            let forthNavContr = UINavigationController(rootViewController: contactVC)
            
            // MARK: - create tabBar controll
            let tabBarVC = UITabBarController()
            tabBarVC.setViewControllers([firstNavContr, secondNavContr,forthNavContr, thrirdNavContr], animated: true)
            tabBarVC.tabBar.backgroundColor = UIColor.black
            tabBarVC.tabBar.barStyle = .black
            tabBarVC.tabBar.tintColor = .white
            scheduleVC.tabBarItem = UITabBarItem(title: "Расписание", image: UIImage(named: "icon-schedule"), tag: 0)
            chatVC.tabBarItem = UITabBarItem(title: "Чат", image: UIImage(named: "icon-chat"), tag: 1)
            contactVC.tabBarItem = UITabBarItem(title: "Организаторы", image: UIImage(named: "icon-contacts"), tag: 2)
            settVC.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(named: "icon-settings"), tag: 3)
            
            tabBarVC.selectedViewController = secondNavContr
            
            self.present(tabBarVC, animated: true, completion: nil)
        })
    }
    
    //MARK: - Add TextFields delegate and notifications
    fileprivate func setupTextFieldsDelegateAndNotifications(){
        fullNameTextField.delegate = self
        jobPositionTextField.delegate = self
        companyNameTextField.delegate = self
        cityTextField.delegate = self
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
    fileprivate func setupAllContainersWithTextFieldAndProfileImageWithButton() {
        
        // MARK: - constarints for myScrollView
        view.addSubview(myScrollView)
        
        myScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        myScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        myScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        // MARK: - constarints for imageProfileImageView
        myScrollView.addSubview(profileImageView)
        
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 64)  .isActive = true
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 38).isActive = true
        
        // MARK: constarints for profileLabel
        myScrollView.addSubview(profileLabel)
        
        profileLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30).isActive = true
        profileLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        profileLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 12).isActive = true
        
        // MARK: constarints for profileLabel
        myScrollView.addSubview(inputsProfileContainerView)
        
        inputsProfileContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsProfileContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        inputsProfileContainerView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 10).isActive = true
        inputsProfileContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        // MARK: - fullNameTextField and separator constraints
        inputsProfileContainerView.addSubview(fullNameTextField)
        inputsProfileContainerView.addSubview(sepatatorForFullNameTextField)
        
        fullNameTextField.heightAnchor.constraint(equalTo: inputsProfileContainerView.heightAnchor, multiplier: 1/4).isActive = true
        fullNameTextField.topAnchor.constraint(equalTo: inputsProfileContainerView.topAnchor).isActive = true
        fullNameTextField.leftAnchor.constraint(equalTo: inputsProfileContainerView.leftAnchor, constant: 8).isActive = true
        fullNameTextField.rightAnchor.constraint(equalTo: inputsProfileContainerView.rightAnchor, constant: -16).isActive = true
        
        sepatatorForFullNameTextField.widthAnchor.constraint(equalTo: inputsProfileContainerView.widthAnchor).isActive = true
        sepatatorForFullNameTextField.heightAnchor.constraint(equalToConstant: 1).isActive = true
        sepatatorForFullNameTextField.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor).isActive = true
        sepatatorForFullNameTextField.leftAnchor.constraint(equalTo: inputsProfileContainerView.leftAnchor).isActive = true
        
        // MARK: - jobTextField and separator constraints
        inputsProfileContainerView.addSubview(jobPositionTextField)
        inputsProfileContainerView.addSubview(sepatatorForJobPositionTextField)
        
        jobPositionTextField.heightAnchor.constraint(equalTo: inputsProfileContainerView.heightAnchor, multiplier: 1/4).isActive = true
        jobPositionTextField.topAnchor.constraint(equalTo: sepatatorForFullNameTextField.bottomAnchor).isActive = true
        jobPositionTextField.leftAnchor.constraint(equalTo: inputsProfileContainerView.leftAnchor, constant: 8).isActive = true
        jobPositionTextField.rightAnchor.constraint(equalTo: inputsProfileContainerView.rightAnchor, constant: -16).isActive = true
        
        sepatatorForJobPositionTextField.widthAnchor.constraint(equalTo: inputsProfileContainerView.widthAnchor).isActive = true
        sepatatorForJobPositionTextField.heightAnchor.constraint(equalToConstant: 1).isActive = true
        sepatatorForJobPositionTextField.topAnchor.constraint(equalTo: jobPositionTextField.bottomAnchor).isActive = true
        sepatatorForJobPositionTextField.leftAnchor.constraint(equalTo: inputsProfileContainerView.leftAnchor).isActive = true
        
        // MARK: - companyTextField and image and separator constraints
        inputsProfileContainerView.addSubview(companyNameTextField)
        inputsProfileContainerView.addSubview(sepatatorForCompanyNameTextField)
        
        companyNameTextField.heightAnchor.constraint(equalTo: inputsProfileContainerView.heightAnchor, multiplier: 1/4).isActive = true
        companyNameTextField.topAnchor.constraint(equalTo: sepatatorForJobPositionTextField.bottomAnchor).isActive = true
        companyNameTextField.leftAnchor.constraint(equalTo: inputsProfileContainerView.leftAnchor, constant: 8).isActive = true
        companyNameTextField.rightAnchor.constraint(equalTo: inputsProfileContainerView.rightAnchor, constant: -16).isActive = true
        
        sepatatorForCompanyNameTextField.widthAnchor.constraint(equalTo: inputsProfileContainerView.widthAnchor).isActive = true
        sepatatorForCompanyNameTextField.heightAnchor.constraint(equalToConstant: 1).isActive = true
        sepatatorForCompanyNameTextField.topAnchor.constraint(equalTo: companyNameTextField.bottomAnchor).isActive = true
        sepatatorForCompanyNameTextField.leftAnchor.constraint(equalTo: inputsProfileContainerView.leftAnchor).isActive = true
        
        // MARK: - cityTextField and image and separator constraints
        inputsProfileContainerView.addSubview(cityTextField)
        
        cityTextField.heightAnchor.constraint(equalTo: inputsProfileContainerView.heightAnchor, multiplier: 1/4).isActive = true
        cityTextField.topAnchor.constraint(equalTo: sepatatorForCompanyNameTextField.bottomAnchor).isActive = true
        cityTextField.leftAnchor.constraint(equalTo: inputsProfileContainerView.leftAnchor, constant: 8).isActive = true
        cityTextField.rightAnchor.constraint(equalTo: inputsProfileContainerView.rightAnchor, constant: -16).isActive = true
        
        // MARK: constarints for profileLabel
        myScrollView.addSubview(emailAndPasswordLabel)
        emailAndPasswordLabel.topAnchor.constraint(equalTo: inputsProfileContainerView.bottomAnchor, constant: 10).isActive = true
        emailAndPasswordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        emailAndPasswordLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 12).isActive = true
        
        // MARK: - constarints for inputsEmailAndPasswordContainerView
        myScrollView.addSubview(inputsEmailAndPasswordContainerView)
        inputsEmailAndPasswordContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsEmailAndPasswordContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        inputsEmailAndPasswordContainerView.topAnchor.constraint(equalTo: emailAndPasswordLabel.bottomAnchor, constant: 10).isActive = true
        inputsEmailAndPasswordContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        // MARK: - emailTextField and separator constraints
        inputsEmailAndPasswordContainerView.addSubview(emailTextField)
        inputsEmailAndPasswordContainerView.addSubview(sepatatorForEmailTextField)
        
        emailTextField.heightAnchor.constraint(equalTo: inputsEmailAndPasswordContainerView.heightAnchor, multiplier: 1/2).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputsEmailAndPasswordContainerView.topAnchor).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: inputsEmailAndPasswordContainerView.leftAnchor, constant: 8).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: inputsEmailAndPasswordContainerView.rightAnchor, constant: -16).isActive = true
        
        sepatatorForEmailTextField.widthAnchor.constraint(equalTo: inputsEmailAndPasswordContainerView.widthAnchor).isActive = true
        sepatatorForEmailTextField.heightAnchor.constraint(equalToConstant: 1).isActive = true
        sepatatorForEmailTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        sepatatorForEmailTextField.leftAnchor.constraint(equalTo: inputsEmailAndPasswordContainerView.leftAnchor).isActive = true
        
        // MARK: - passwordTextField constraints
        inputsEmailAndPasswordContainerView.addSubview(passwordTextField)
        
        passwordTextField.heightAnchor.constraint(equalTo: inputsEmailAndPasswordContainerView.heightAnchor, multiplier: 1/2).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: sepatatorForEmailTextField.bottomAnchor).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: inputsEmailAndPasswordContainerView.leftAnchor, constant: 8).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: inputsEmailAndPasswordContainerView.rightAnchor, constant: -16).isActive = true
        
    }//end of method
    
    // MARK: - Setup constraints and add buttobs to view for back and
    fileprivate func setupButtons() {
        view.addSubview(backToLoginVcButton)
        view.addSubview(signInNewUserButton)
        
        // MARK: - Back to LoginVC button
        backToLoginVcButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        backToLoginVcButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        backToLoginVcButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 28).isActive = true
        backToLoginVcButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        
        // MARK: - signIn button
        signInNewUserButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInNewUserButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24)  .isActive = true
        signInNewUserButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signInNewUserButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -28).isActive = true
        
    }//end of method
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fullNameTextField {
            jobPositionTextField.becomeFirstResponder()
            return true
        }
        if textField == jobPositionTextField {
            companyNameTextField.becomeFirstResponder()
            return true
        }
        if textField == companyNameTextField {
            cityTextField.becomeFirstResponder()
            return true
        }
        if textField == cityTextField {
            emailTextField.becomeFirstResponder()
            return true
        }
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
