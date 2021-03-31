//
//  CombineVC.swift
//  TinderClone
//
//  Created by Michel Bernardo on 30/03/21.
//

import UIKit

class CombineVC: UIViewController {
  
  var users: [User] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.systemGroupedBackground
    
    self.searchUsers()
  }
  
  func searchUsers() {
    self.users = UserService.shared.searchUsers()
    self.addCards()
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
}

// move the card;
extension CombineVC {
  @objc func handlerCard (_ gesture: UIPanGestureRecognizer) {
    if let card = gesture.view {
      let point = gesture.translation(in: view)
      
      card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
      
      let rotationAngle = point.x / view.bounds.width * 0.5
      
      card.transform = CGAffineTransform(rotationAngle: rotationAngle)
      
      if gesture.state == .ended {
        UIView.animate(withDuration: 0.3) {
          card.center = self.view.center
          card.transform = .identity
        }
      }
    }
  }
}
