//
//  ViewController.swift
//  appleLogin
//
//  Created by 민트팟 on 2021/05/11.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {

    @IBOutlet weak var loginStackView: UIStackView!
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self	.view.window!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginView()
        // Do any additional setup after loading the view.
    }

    func setupLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.loginStackView.addSubview(authorizationButton)
        
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        authorizationButton.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor).isActive = true
        authorizationButton.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor).isActive = true
        authorizationButton.topAnchor.constraint(equalTo: loginStackView.topAnchor).isActive = true
        authorizationButton.bottomAnchor.constraint(equalTo: loginStackView.bottomAnchor).isActive = true
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let request = appleIDProvider.createRequest()
      // fullName, email 밖에 얻어 올수 없음
      request.requestedScopes = [.fullName, .email]
            
      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
      authorizationController.delegate = self
      authorizationController.presentationContextProvider = self
      authorizationController.performRequests()
    }
    
    // delegate - handle 실패시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
    }
    
    // delegate - handle 성공시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print(authorization)
        print(type(of: authorization))
    }
}

