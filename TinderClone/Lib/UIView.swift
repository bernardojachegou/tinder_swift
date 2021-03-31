//
//  UIView.swift
//  TinderClone
//
//  Created by Michel Bernardo on 30/03/21.
//

import UIKit

extension UIView {
  func fullfill(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
    translatesAutoresizingMaskIntoConstraints = false;
    
    if let top = top {
      topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true;
    }
    
    if let leading = leading {
      leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true;
    }
    
    if let trailing = trailing {
      trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true;
    }
    
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true;
    }
    
    if size.width != 0 {
      widthAnchor.constraint(equalToConstant: size.width).isActive = true;
    }
    
    if size.height != 0 {
      heightAnchor.constraint(equalToConstant: size.height).isActive = true;
    }
  }
  
  func fillSuperview(padding: UIEdgeInsets = .zero) {
    fullfill(
      top: superview?.topAnchor,
      leading: superview?.leadingAnchor,
      trailing: superview?.trailingAnchor,
      bottom: superview?.bottomAnchor,
      padding: padding
    )
  }
  
  func centerSuperview(size: CGSize = .zero) {
    translatesAutoresizingMaskIntoConstraints = false
    
    if let superviewCenterX = superview?.centerXAnchor {
      centerXAnchor.constraint(equalTo: superviewCenterX).isActive = true
    }
    
    if let superviewCenterY = superview?.centerYAnchor {
      centerYAnchor.constraint(equalTo: superviewCenterY).isActive = true;
    }
    
    if size.width != 0 {
      widthAnchor.constraint(equalToConstant: size.width).isActive = true;
    }
    
    if size.height != 0 {
      heightAnchor.constraint(equalToConstant: size.height).isActive = true;
    }
  }
  
  func size(size: CGSize = .zero) {
    translatesAutoresizingMaskIntoConstraints = false
    
    if size.width != 0 {
      widthAnchor.constraint(equalToConstant: size.width).isActive = true;
    }
    
    if size.height != 0 {
      heightAnchor.constraint(equalToConstant: size.height).isActive = true;
    }
  }
  
}
