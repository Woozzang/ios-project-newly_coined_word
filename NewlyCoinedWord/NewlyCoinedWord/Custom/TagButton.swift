//
//  TagButton.swift
//  NewlyCoinedWord
//
//  Created by Woochan Park on 2021/10/04.
//

import UIKit

class TagButton: UIButton {
  
  private let customDefinedWidthPadding: CGFloat = 15
  
  override var intrinsicContentSize: CGSize {
    
    let defaultSize = super.intrinsicContentSize
    
    let width = defaultSize.width + (customDefinedWidthPadding * 2)
    
    let height = defaultSize.height
    
    return CGSize(width: width, height: height)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    self.isHidden = true
    applyRoundDesign(to: self)
  }
  
  private func applyRoundDesign(to view: UIView) {
    
    view.layer.cornerRadius = view.frame.height / 3
    view.layer.borderWidth = 2
    view.layer.borderColor = UIColor.black.cgColor
  }
}
