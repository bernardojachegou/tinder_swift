//
//  CombineCardView.swift
//  TinderClone
//
//  Created by Michel Bernardo on 30/03/21.
//

import UIKit

class CombineCardView: UIView {
  
  var user: User? {
    didSet {
      if let user = user {
        photoImageView.image = UIImage(named: user.photo)
        nameLabel.text = user.name
        ageLabel.text = String(user.age)
        phraseLabel.text = user.phrase
      }
    }
  }
  
  let photoImageView: UIImageView = .photoImageView()
  
  let nameLabel: UILabel = .textBoldLabel(32, textColor: .white)
  let ageLabel: UILabel = .textLabel(28, textColor: .white)
  let phraseLabel: UILabel = .textLabel(18, textColor: .white, numberOfLines: 2)
  
  let deslikeImageView: UIImageView = .iconCard(named: "card-deslike")
  let likeImageView: UIImageView = .iconCard(named: "card-like")
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    layer.borderWidth = 0.3
    layer.borderColor = UIColor.red.cgColor
    layer.cornerRadius = 8
    clipsToBounds = true
    
    nameLabel.addShadowEffect()
    ageLabel.addShadowEffect()
    phraseLabel.addShadowEffect()
    
    addSubview(photoImageView)
    
    addSubview(deslikeImageView)
    deslikeImageView.fullfill(
      top: topAnchor,
      leading: nil,
      trailing: trailingAnchor,
      bottom: nil,
      padding: .init(top: 20, left: 0, bottom: 0, right: 20)
    )
    
    addSubview(likeImageView)
    likeImageView.fullfill(
      top: topAnchor,
      leading: leadingAnchor,
      trailing: nil,
      bottom: nil,
      padding: .init(top: 20, left: 20, bottom: 0, right: 0))
    
    photoImageView.fillSuperview()
    
    let nameAndAgeStackView = UIStackView(arrangedSubviews: [nameLabel, ageLabel, UIView()])
    nameAndAgeStackView.spacing = 12
    
    let stackView = UIStackView(arrangedSubviews: [nameAndAgeStackView, phraseLabel])
    stackView.distribution = .fillEqually
    stackView.axis = .vertical
    
    addSubview(stackView)
    stackView.fullfill(
      top: nil,
      leading: leadingAnchor,
      trailing: trailingAnchor,
      bottom: bottomAnchor,
      padding: .init(top: 0, left: 16, bottom: 16, right: 16)
    )
    
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
}
