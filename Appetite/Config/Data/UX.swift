//
//  UX
//  Appetite
//
//  Created by Adrian on 12/1/16.
//  Copyright © 2016 Kuguar. All rights reserved.
//

import UIKit

class UX {

  enum Palette {
    case cellBackground
    case cellFont
    case cellBackgroundHighlighted
    case cellFontHighlighted
    case cellBackgroundDeemphasized
    case cellFontDeemphasized
    
    
    fileprivate static let value: [Palette: UIColor] = [
      cellBackground: UIColor(hexa: 0xFFFFFF),
      cellFont: UIColor(hexa: 0x000000),
      cellBackgroundHighlighted: UIColor(hexa: 0xBBF853),
      cellFontHighlighted: UIColor(hexa: 0xFF221B),
      cellBackgroundDeemphasized: UIColor(hexa: 0xEBEBEB),
      cellFontDeemphasized: UIColor(hexa: 0x797979),
    ]
    
    var uicolor: UIColor {
      return Palette.value[self]!;
    }
    
    var cgcolor: CGColor {
      return Palette.value[self]!.cgColor;
    }
    
  }

}
