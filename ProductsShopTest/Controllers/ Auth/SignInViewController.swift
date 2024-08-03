//
//  SignInViewController.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 22.07.2024.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {
    
    private let signInLabel = LabelType(type: .signIn)
    private let emailLabel = LabelType(type: .email)
    private let passwordLabel = LabelType(type: .password)
    private var errorLabel = UILabel()
    private var errorImage = UIImageView()
    private let logoImage = UIImageView()
    
    private let emailTextField = TextFieldtype(type: .email)
    private let passwordTextField = TextFieldtype(type: .password)
    
    private let signInButton = UIButton()
    private let newUserButton = UIButton()
    private let reminderButton = UIButton()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

private extension SignInViewController {
    
    func setupUI() {
        setupNavbarItem()
        setupButton()
        textFieldDelegete()
        setupEroorImage()
        setupErrorLabel()
        addSubviews()
        makeConstraints()
    }
    
    func setupNavbarItem() {
        self.navigationItem.title = ""
    }
    
    func setupButton() {
        signInButton.backgroundColor = .green
        signInButton.layer.cornerRadius = 25
        signInButton.setTitle("Войти", for: .normal)
        signInButton.setTitleColor(.black, for: .normal)
        signInButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        
        newUserButton.setTitle("Регистрация", for: .normal)
        newUserButton.setTitleColor(.black, for: .normal)
        newUserButton.addTarget(self, action: #selector(newUserButtonTapped), for: .touchUpInside)
        
        reminderButton.setTitle("Забыли пароль?", for: .normal)
        reminderButton.setTitleColor(.gray, for: .normal)
        reminderButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .light)
        reminderButton.addTarget(self, action: #selector(reminderButtonTapped), for: .touchUpInside)
    }
    
    func textFieldDelegete() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func setupEroorImage() {
        logoImage.image = UIImage(named: "clothes")
        logoImage.contentMode = .scaleToFill
        logoImage.layer.cornerRadius = 20
        logoImage.clipsToBounds = true
        
        errorImage.contentMode = .scaleToFill
    }
    
    func setupErrorLabel() {
        errorLabel.text = ""
        errorLabel.textColor = .red
        errorLabel.font = .systemFont(ofSize: 14)
        errorLabel.textAlignment = .center
    }
    
    func addSubviews() {
        [signInLabel, logoImage, emailLabel, emailTextField, passwordLabel, passwordTextField, newUserButton, reminderButton, errorLabel, errorImage, signInButton].forEach {
            view.addSubview($0)
        }
    }
    
    func makeConstraints() {
        signInLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(signInLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.size.equalTo(200)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(400)
            make.left.equalToSuperview().inset(25)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(40)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(25)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(40)
        }

        signInButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(150)
            make.left.equalToSuperview().inset(45)
            make.width.equalTo(304)
            make.height.equalTo(52)
        }
        
        newUserButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
        }
        
        reminderButton.snp.makeConstraints { make in
            make.top.equalTo(newUserButton.snp.bottom).offset(-5)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
        }
        
        errorImage.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(27)
            make.size.equalTo(20)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.left.equalTo(errorImage.snp.right).offset(5)
        }
    }
    
    @objc func signInButtonTapped() {
        animateButton(signInButton)
        
        let mail = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        if !Validator.isValidEmail(for: mail) || !Validator.isPasswordValid(for: password) {
            emailTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            
            errorImage.image = UIImage(named: "error")
            errorLabel.text  = "Неверный Email или пароль"
            return
        }
    }
    
    @objc func newUserButtonTapped() {
        animateButton(newUserButton)
        
        let signUpViewController = SignUpViewController()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    @objc func reminderButtonTapped() {
        animateButton(reminderButton)
    }
}
//MARK: UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.text = ""
        errorImage.image = nil
        
        if textField == emailTextField {
            emailTextField.layer.borderColor = UIColor.green.cgColor
            passwordTextField.layer.borderColor = UIColor.black.cgColor
        } else {
            emailTextField.layer.borderColor = UIColor.black.cgColor
            passwordTextField.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.black.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        errorLabel.text = ""
        errorImage.image = nil
        
        if textField == emailTextField {
            emailTextField.layer.borderColor = UIColor.green.cgColor
            passwordTextField.layer.borderColor = UIColor.black.cgColor
        } else {
            emailTextField.layer.borderColor = UIColor.black.cgColor
            passwordTextField.layer.borderColor = UIColor.green.cgColor
        }
        return true
    }
}
