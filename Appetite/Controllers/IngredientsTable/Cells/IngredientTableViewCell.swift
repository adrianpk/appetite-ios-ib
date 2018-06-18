//
//  IngredientTableViewCell.swift
//  Appetite
//
//  Created by Adrian on 11/30/16.
//  Copyright © 2016 Kuguar. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

  @IBOutlet weak var quantity: UILabel!
  @IBOutlet weak var unit: UILabel!
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var isOptional: UILabel!
  var delegate: TableViewCellDelegate?
  var elementId: String?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  @IBAction  func touchUpInsides() {
    if let delegate = self.delegate {
      delegate.touchUpInside(id: self.elementId!)
    }
  }
  
}
