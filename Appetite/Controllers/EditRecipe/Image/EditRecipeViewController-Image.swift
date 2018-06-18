//
//  EditRecipeViewController-Image.swift
//  Appetite
//
//  Created by Adrian on 11/18/16.
//  Copyright © 2016 Kuguar. All rights reserved.
//

import UIKit

extension EditRecipeViewController {

  func setupImageRelatedViews() {
    //self.hideImageStack()
    self.hideDeleteImageButton()
  }
  
  func hideImageStack() {
    self.imageStackView.isHidden = true
  }
  
  func hideDeleteImageButton() {
    self.deleteImageButton.isHidden = true
  }

}
