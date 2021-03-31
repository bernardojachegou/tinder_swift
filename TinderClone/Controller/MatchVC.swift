//
//  MatchVC.swift
//  TinderClone
//
//  Created by Michel Bernardo on 31/03/21.
//

import UIKit

class MatchVC: UIViewController {
  
  let photoImageView: UIImageView = .photoImageView(named: "pessoa-1")
  let likeImageView: UIImageView = .photoImageView(named: "icone-like")
  let messageLabel: UILabel = .textBoldLabel(18, textColor: .white, numberOfLines: 1)
  
  let messageText: UITextField = {
    let textField = UITextField()
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    textField.placeholder = "Say hi to ..." // Add person's name
    textField.backgroundColor = .white
    textField.layer.cornerRadius = 8
    textField.textColor = .darkText
    textField.returnKeyType = .go
    
    textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
    textField.leftViewMode = .always
    
    textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 0))
    textField.rightViewMode = .always
    
    return textField
  }()
  
  let sendMessageButton: UIButton = {
    let button = UIButton()
    
    button.setTitle("Send", for: .normal)
    button.setTitleColor(UIColor(red: 62/255, green: 163/255, blue: 255/255, alpha: 1), for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 16)
    
    return button
  }()
  
  let backButton: UIButton = {
    let button = UIButton()
    
    button.setTitle("back", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 16)
    
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(photoImageView)
    photoImageView.fillSuperview()
    
    let gradient = CAGradientLayer()
    gradient.frame = view.frame
    gradient.colors = [UIColor.red.cgColor, UIColor.black.cgColor]
    
    photoImageView.layer.addSublayer(gradient)
    
    messageLabel.text = "Robert liked you!"
    messageLabel.textAlignment = .center
    
    likeImageView.translatesAutoresizingMaskIntoConstraints = false
    likeImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    likeImageView.contentMode = .scaleAspectFit
    
    messageText.addSubview(sendMessageButton)
    sendMessageButton.fullfill(top: messageText.topAnchor, leading: nil, trailing: messageText.trailingAnchor, bottom: messageText.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16))
    
    let stackView = UIStackView(arrangedSubviews: [likeImageView, messageLabel, messageText, backButton])
    stackView.axis = .vertical
    stackView.spacing = 16
    
    view.addSubview(stackView)
    stackView.fullfill(
      top: nil,
      leading: view.leadingAnchor,
      trailing: view.trailingAnchor,
      bottom: view.bottomAnchor,
      padding: .init(top: 0, left: 32, bottom: 46, right: 32)
    
    )
  }
}
