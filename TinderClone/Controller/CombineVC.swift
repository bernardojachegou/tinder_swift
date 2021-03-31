//
//  CombineVC.swift
//  TinderClone
//
//  Created by Michel Bernardo on 30/03/21.
//

import UIKit

enum Action {
  case deslike
  case like
}

class CombineVC: UIViewController {
  
  var profileButton: UIButton = .iconMenu(named: "icone-perfil")
  var chatButton: UIButton = .iconMenu(named: "icone-chat")
  var logoButton: UIButton = .iconMenu(named: "icone-logo")
  
  var deslikeButton: UIButton = .iconFooter(named: "icone-deslike")
  var superlikeButton: UIButton = .iconFooter(named: "icone-superlike")
  var likeButton: UIButton = .iconFooter(named: "icone-like")
  
  var users: [User] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.isHidden = true
    view.backgroundColor = UIColor.systemGroupedBackground
    
    self.addHeader()
    self.addFooter()
    self.searchUsers()
  }
  
  func searchUsers() {
    self.users = UserService.shared.searchUsers()
    self.addCards()
  }
  
}

extension CombineVC {
  func addHeader() {
    
    let window = UIApplication.shared.windows.first { $0.isKeyWindow }
    let top: CGFloat = window?.safeAreaInsets.top ?? 44
    
    let stackView = UIStackView(arrangedSubviews: [profileButton, logoButton, chatButton])
    stackView.distribution = .equalCentering
    
    view.addSubview(stackView)
    stackView.fullfill(
      top: view.topAnchor,
      leading: view.leadingAnchor,
      trailing: view.trailingAnchor,
      bottom: nil,
      padding: .init(top: top, left: 16, bottom: 0, right: 16)
    )
  }
  
  func addFooter() {
    let stackView = UIStackView(arrangedSubviews: [UIView(), deslikeButton, superlikeButton, likeButton, UIView()])
    stackView.distribution = .equalCentering
    
    view.addSubview(stackView)
    stackView.fullfill(
      top: nil,
      leading: view.leadingAnchor,
      trailing: view.trailingAnchor,
      bottom: view.bottomAnchor,
      padding: .init(top: 0, left: 16, bottom: 32, right: 16)
    )
  }
}

// multiple cards;
extension CombineVC {
  func addCards() {
    
    for user in users {
      let card = CombineCardView()
      card.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 32, height: view.bounds.height * 0.7)
      
      card.center = view.center
      card.user = user
      card.tag = user.id
      
      let gesture = UIPanGestureRecognizer()
      gesture.addTarget(self, action: #selector(handlerCard))
      
      card.addGestureRecognizer(gesture)
      
      view.insertSubview(card, at: 0)
    }
  }
  
  func removeCard(card: UIView) {
    card.removeFromSuperview()
    
    self.users = self.users.filter({ (user) -> Bool in
      return user.id != card.tag
    })
  }
  
}

// move the card;
extension CombineVC {
  @objc func handlerCard (_ gesture: UIPanGestureRecognizer) {
    if let card = gesture.view as? CombineCardView {
      let point = gesture.translation(in: view)
      
      card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
      
      let rotationAngle = point.x / view.bounds.width * 0.5
      
      if point.x > 0 {
        card.likeImageView.alpha = rotationAngle * 5
        card.deslikeImageView.alpha = 0
      } else {
        card.deslikeImageView.alpha = rotationAngle * 5 * -1
        card.likeImageView.alpha = 0
      }
      
      card.transform = CGAffineTransform(rotationAngle: rotationAngle)
      
      if gesture.state == .ended {
        
        if card.center.x > self.view.bounds.width + 30 {
          self.cardAnimation(rotationAngle: rotationAngle, action: .like)
          return
        }
        
        if card.center.x < -30 {
          self.cardAnimation(rotationAngle: rotationAngle, action: .deslike)
          return
        }
        
        UIView.animate(withDuration: 0.3) {
          card.center = self.view.center
          card.transform = .identity
          
          card.likeImageView.alpha = 0
          card.deslikeImageView.alpha = 0
          
        }
      }
    }
  }
  
  func cardAnimation(rotationAngle: CGFloat, action: Action) {
    if let user = self.users.first {
      for view in self.view.subviews {
        if view.tag == user.id {
          if let card = view as? CombineCardView {
            
            let center: CGPoint
            
            switch action {
            case .deslike:
              center = CGPoint(x: card.center.x - self.view.bounds.width, y: card.center.y + 50)
            case .like:
              center = CGPoint(x: card.center.x + self.view.bounds.width, y: card.center.y + 50)
            }
            
//            UIView.animate(withDuration: 0.2) {
//              card.center = center
//              card.transform = CGAffineTransform(rotationAngle: rotationAngle)
//            }
            
            UIView.animate(withDuration: 0.2) {
              card.center = center
              card.transform = CGAffineTransform(rotationAngle: rotationAngle)
            } completion: { (in) in
              self.removeCard(card: card)
            }

            
          }
        }
      }
    }
  }
}
