//
//  LoginViewController.swift
//  LoginApp
//
//  Created by 장일규 on 2022/02/04.
//

import Foundation
import UIKit
import Firebase

final class LoginViewController: UIViewController {
    
    private var centerYConstraints: NSLayoutConstraint?
    
    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "즐거운 코딩 생활"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "로그인"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let idTextField: InsetTextField = {
        let textField = InsetTextField()
        textField.insetX = 16
        textField.placeholder = "아이디"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true
        return textField
    }()
    
    private let passwordTextField: InsetTextField = {
        let textField = InsetTextField()
        textField.insetX = 16
        textField.placeholder = "비밀번호"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true
        return textField
    }()
    
    private let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    @objc func viewDidTap(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private let emailLoginButton: UIButton = {
        let emailLoginButton = UIButton()
        emailLoginButton.setTitle("이메일/비밀번호로 계속하기", for: .normal)
        emailLoginButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        emailLoginButton.setTitleColor(UIColor.white, for: .normal)
        emailLoginButton.backgroundColor = .black
        emailLoginButton.layer.cornerRadius = 20
        emailLoginButton.clipsToBounds = true
        emailLoginButton.addTarget(self, action: #selector(emailLoginTapped), for: .touchUpInside)

        return emailLoginButton
    }()
    
    private let googleLoginButton: UIButton = {
        let googleLoginButton = UIButton()
        googleLoginButton.setTitle("구글로 계속하기", for: .normal)
        googleLoginButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        googleLoginButton.setTitleColor(UIColor.white, for: .normal)
        googleLoginButton.backgroundColor = .black
        googleLoginButton.layer.cornerRadius = 20
        googleLoginButton.clipsToBounds = true
        
        return googleLoginButton
    }()
    
    
    private let appleLoginButton: UIButton = {
        let appleLoginButton = UIButton()
        appleLoginButton.setTitle("Apple로 계속하기", for: .normal)
        appleLoginButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        appleLoginButton.setTitleColor(UIColor.white, for: .normal)
        appleLoginButton.backgroundColor = .black
        appleLoginButton.layer.cornerRadius = 20
        appleLoginButton.clipsToBounds = true
        
        return appleLoginButton
    }()
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setup()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }

    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
              else { return }
        
        let keyboardHeight = keyboardFrame.height
        
        UIView.animate(withDuration: duration) {
            self.centerYConstraints?.constant = -(keyboardHeight - 100.0)
            self.view.layoutIfNeeded()
        }

        print(duration)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
              else { return }
    
        UIView.animate(withDuration: duration) {
            self.centerYConstraints?.constant = 0
            self.view.layoutIfNeeded()
        }

        print(duration)
    }
    
    func setup() {
        addSubViews()
        setConstraints()
    }
    
    func addSubViews() {
        view.addSubview(container)
        container.addArrangedSubview(titleImageView)
        container.addArrangedSubview(descriptionLabel)
        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(idTextField)
        container.addArrangedSubview(passwordTextField)
        container.addArrangedSubview(emailLoginButton)
        container.addArrangedSubview(googleLoginButton)
        container.addArrangedSubview(appleLoginButton)
    }
    
    func setConstraints() {
        containerConstraints()
        titleImageViewConstratins()
        idTextFieldConstraints()
        passwordTextFieldConstraints()
        emailLoginButtonConstraints()
        googleLoginButtonConstraints()
        appleLoginButtonConstraints()
    }
    
    @objc func emailLoginTapped() {
        let email = idTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        print(email)
        print(password)
        
        // 신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            print(self)
            self.showResultViewController()
        }

        
    }
    
    private func showResultViewController() {
        let showResultViewController = ShowResultViewController()
        self.navigationController?.pushViewController(showResultViewController, animated: true)
    }
    
    func containerConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        let constraint =  container.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        constraint.isActive = true
        self.centerYConstraints = constraint
        container.setCustomSpacing(20, after: titleImageView)
        container.setCustomSpacing(40, after: titleLabel)
        container.setCustomSpacing(30, after: passwordTextField)
        container.setCustomSpacing(15, after: emailLoginButton)
        container.setCustomSpacing(15, after: googleLoginButton)
    }
    
    func titleImageViewConstratins() {
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        titleImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func idTextFieldConstraints() {
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        idTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        idTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        idTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func passwordTextFieldConstraints() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func emailLoginButtonConstraints() {
        emailLoginButton.translatesAutoresizingMaskIntoConstraints = false
        emailLoginButton.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        emailLoginButton.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        emailLoginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func googleLoginButtonConstraints() {
        googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        googleLoginButton.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        googleLoginButton.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        googleLoginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func appleLoginButtonConstraints() {
        appleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        appleLoginButton.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        appleLoginButton.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        appleLoginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
