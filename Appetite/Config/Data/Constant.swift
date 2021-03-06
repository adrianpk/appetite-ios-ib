//
//  Constant.swift
//  Appetite
//
//  Created by Adrian on 11/25/16.
//  Copyright © 2016 Kuguar. All rights reserved.
//

import UIKit

class Constant {

  enum ListData {
    case hours
    case minutes
    case minutes_5
    
    fileprivate static let values: [ListData: [String]] = [
      hours: ["Hours", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "23"],
      minutes: ["Minutes", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"],
      minutes_5: ["Minutes", "0", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"]
    ]
    
    var value: [String] {
      return ListData.values[self]!;
    }
  }

}
