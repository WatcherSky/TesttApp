//
//  Section.swift
//  TestApp
//
//  Created by Владимир on 26.06.2022.
//

import Foundation
import UIKit

enum Section: Int {
    case menu
    case grid
    case table
}


enum SectionItems {
    static let menuCount = 1
    static let gridCount = 1
}

enum SectionHeight {
    static let menuHeight: CGFloat = 110
    static let gridHeight: CGFloat = 160
    static let tableHeight: CGFloat = 290
}
 
