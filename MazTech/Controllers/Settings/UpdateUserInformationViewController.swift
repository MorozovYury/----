//
//  UpdateUserInformationViewController.swift
//  MazTech
//
//  Created by Yury Morozov on 09.12.2018.
//  Copyright © 2018 Yury Morozov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class UpdateUserInformationViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        
        myScrollView.delegate = self
        
        setupContainers()
        setupTextFieldsDelegateAndNotifications()
        dismissKeyboardWhenTouchOutside()
        fetchUserProfileInformation()
    }
    
    // MARK: - Fetch User Profile Information
    public func fetchUserProfileInformation(){
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        Database.database().reference().child("listOfUsers").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let user = UserProfileInformation(dictionary: dictionary)
                self.setupAllElenets(user)
                print("Success fetch user data: \(user)")
            }
            
        }, withCancel: nil)
        
        
    }// end of fetchUserProfileInformation
    
    // MARK: - Setup All Elements
    public func setupAllElenets(_ user: UserProfileInformation) {
        let name = fullNameTextField
        name.text = user.fullName
        
        let job = jobPositionTextField
        job.text = user.jobPosition
        
        let company = companyNameTextField
        company.text = user.companyName
        
        let city = cityTextField
        city.text = user.city
        
        if let profileImageUrl = user.profileImageUrl {
            profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
        
        
    }// end of setupAllElenets
    
    // MARK: Create a Scrollview
    private let myScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isPagingEnabled = true
        scroll.indicatorStyle = .white
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
        text.placeholder = "Mazda Motor Rus"
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
    lazy var updateUserProfileInformationButton: UIButton = {
        
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Обновить информацию", for: .normal  )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleUpdateUserProfInfoButton), for: .touchUpInside)
        
        button.alpha = 0.5
        button.isEnabled = false
        
        return button
    }()
    
    // MARK: - setUpdateProfileInformationButton
    func setUpdateProfileInformationButton(enabled:Bool) {
        if enabled {
            updateUserProfileInformationButton.alpha = 1.0
            updateUserProfileInformationButton.isEnabled = true
        } else {
            updateUserProfileInformationButton.alpha = 0.5
            updateUserProfileInformationButton.isEnabled = false
        }
    }
    
    // MARK: - textFieldChanged adding
    @objc func textFieldChanged(_ target:UITextField) {
        let name = fullNameTextField.text
        let city = cityTextField.text
        let job = jobPositionTextField.text
        let company = companyNameTextField.text
        let formFilled = name != nil && name != "" && city != nil && city != "" && job != nil && job != "" && company != nil && company != ""
        setUpdateProfileInformationButton(enabled: formFilled)
    }
    
    // MARK: - updateUserProfileInformationButton method
    @objc func handleUpdateUserProfInfoButton() {
        
        setUpdateProfileInformationButton(enabled:false)
        
        guard let name = fullNameTextField.text, let city = cityTextField.text, let job = jobPositionTextField.text, let company = companyNameTextField.text else {
            print("Form is not valid")
            return
        }
        
        let usersReference = Database.database().reference().child("listOfUsers").child((Auth.auth().currentUser?.uid)!)
        
        
        // MARK: - Update and download new image
        let imageName = Auth.auth().currentUser?.uid
        let storageRef = Storage.storage().reference().child("profile_avatars").child("\(imageName ?? "avatar").jpg")
        
        storageRef.delete { error in
            if let error = error {
                // Uh-oh, an error occurred!
                print("SMTH goes wrond \(error.localizedDescription)")
            } else {
                print("Successfully old avatar was deleted")
            }
        }
        
        
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
                        let values = ["fullName": name, "profileImageUrl": profileImageUrl, "city": city, "companyName": company, "jobPosition": job]
                        
                        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                            
                            if err != nil {
                                let updateChildValuesAlert = UIAlertController(title: "Внимание!", message: "Произошла ошибка с сохранением профиля: \(err!.localizedDescription)", preferredStyle: .alert)
                                let tryAgainAction = UIAlertAction(title: "Попробовать снова", style: .default, handler: nil)
                                updateChildValuesAlert.addAction(tryAgainAction)
                                self.present(updateChildValuesAlert, animated: true, completion: nil)
                                
                                return
                            } else {
                                print("Success of update profile info")
                                let updatedAlert = UIAlertController(title: "Информация пользователя успешно обновлена", message: nil, preferredStyle: .alert)
                                let tryAgainAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                    self.dismiss(animated: true, completion: nil)
                                })
                                updatedAlert.addAction(tryAgainAction)
                                self.present(updatedAlert, animated: true)
                            }
                        })
                    }
                })
            })
        }
        
    }// end of handleUpdateUserProfInfoButton
    
    //MARK: - Add TextFields delegate and notifications
    fileprivate func setupTextFieldsDelegateAndNotifications(){
        fullNameTextField.delegate = self
        jobPositionTextField.delegate = self
        companyNameTextField.delegate = self
        cityTextField.delegate = self
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) { (nc) in
            
            self.view.frame.origin.y = -120
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide , object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = 0.0
        }
    }
    
    // MARK: - Add Labels, containers and TextFields into view and create constarints
    fileprivate func setupContainers() {
        
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
        
        // MARK: - Back to LoginVC button
        view.addSubview(backToSettingsVcButton)
        backToSettingsVcButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        backToSettingsVcButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        backToSettingsVcButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 28).isActive = true
        backToSettingsVcButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        
        // MARK: - signIn button
        view.addSubview(updateUserProfileInformationButton)
        updateUserProfileInformationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        updateUserProfileInformationButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24)  .isActive = true
        updateUserProfileInformationButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        updateUserProfileInformationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -28).isActive = true
        
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
