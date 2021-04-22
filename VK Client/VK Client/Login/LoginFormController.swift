//
//  LoginFormController.swift
//  VK Client
//
//  Created by Артём Калинин on 28.02.2021.
//

import UIKit

class LoginFormController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        loginScrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        loginScrollView?.addGestureRecognizer(panGestureRecognizer)
        
        titleAnimation()
        titlesAnimation()
        fieldsAnimation()
        authButtonAnimation()
        
        let session = Session.instance
        session.token = "38c9d161f7"
        session.userId = 7
        tokenLabel.text = "token: \(session.token)"
        idLabel.text = "id: \(session.userId)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var loginTitleView: UILabel!
    @IBOutlet weak var passwordTitleView: UILabel!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var authButton: UIButton!
    @IBOutlet weak var loadingView: LoadingView!
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    var interactiveAnimator: UIViewPropertyAnimator!
    
    private func titlesAnimation() {
        let offset = abs(self.loginTitleView.frame.midY - self.passwordTitleView.frame.midY)
        
        loginTitleView.transform = CGAffineTransform(translationX: 0, y: offset)
        passwordTitleView.transform = CGAffineTransform(translationX: 0, y: -offset)
        
        UIView.animateKeyframes(withDuration: 0.5,
                                delay: 0.5,
                                options: .calculationModeCubicPaced,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.5,
                                                       animations: {
             self.loginTitleView.transform = CGAffineTransform(translationX: 150, y: 50)
             self.passwordTitleView.transform = CGAffineTransform(translationX: -150, y: -50)
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.5,
                                                       relativeDuration: 0.5,
                                                       animations: {
             self.loginTitleView.transform = .identity
             self.passwordTitleView.transform = .identity
                                    })
        }, completion: nil)
    }
    
    private func titleAnimation() {
        self.titleView.transform = CGAffineTransform(translationX: 0,
                                                     y: -self.view.bounds.height/2)
        
        let animator = UIViewPropertyAnimator(duration: 0.5,
                                              dampingRatio: 0.5,
                                              animations: {
                                                  self.titleView.transform = .identity
        })

        animator.startAnimation(afterDelay: 0.5)
    }
    
    private func fieldsAnimation() {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1

        let scaleAnimation = CASpringAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.stiffness = 150
        scaleAnimation.mass = 2

        let animationsGroup = CAAnimationGroup()
        animationsGroup.duration = 1
        animationsGroup.beginTime = CACurrentMediaTime() + 0.5
        animationsGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animationsGroup.fillMode = CAMediaTimingFillMode.backwards
        animationsGroup.animations = [fadeInAnimation, scaleAnimation]

        self.loginInput.layer.add(animationsGroup, forKey: nil)
        self.passwordInput.layer.add(animationsGroup, forKey: nil)
    }
    
    private func authButtonAnimation() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 0.5
        animation.beginTime = CACurrentMediaTime() + 0.5
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.authButton.layer.add(animation, forKey: nil)
    }
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveAnimator?.startAnimation()
            
            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                         dampingRatio: 0.5,
                                                         animations: {
                self.authButton.transform = CGAffineTransform(translationX: 0,
                                                              y: 150)
            })
            
            interactiveAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: self.view)
            interactiveAnimator.fractionComplete = translation.y / 100
        case .ended:
            interactiveAnimator.stopAnimation(true)
            
            interactiveAnimator.addAnimations {
                self.authButton.transform = .identity
            }
            
            interactiveAnimator.startAnimation()
        default: return
        }
    }
    
    @IBAction func onButtonTapped(_ sender: Any) {
        loadingView.animate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.authAction()
        }
    }
    
    @IBAction func backToLogin(unwindSegue: UIStoryboardSegue) {
        loginInput.text = ""
        passwordInput.text = ""
    }
    
    private func authAction() {
        let login = loginInput.text!
        let password = passwordInput.text!
        
        if login == "admin" && password == "123456" {
            self.performSegue(withIdentifier: "toMain", sender: self)
        } else {
            // Создаем контроллер
            let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
            // Создаем кнопку для UIAlertController
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            // Добавляем кнопку на UIAlertController
            alert.addAction(action)
            // Показываем UIAlertController
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.loginScrollView?.contentInset = contentInsets
        loginScrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        loginScrollView?.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() {
        self.loginScrollView?.endEditing(true)
    }
}

class Session {
    
    static let instance = Session()
    
    private init(){}
    
    var token: String = ""
    var userId: Int = 0
}
