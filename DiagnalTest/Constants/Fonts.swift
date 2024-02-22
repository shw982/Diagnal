//
//  Fonts.swift
//  DiagnalTest
//
//  Created by Roster Buster on 18/02/24.
//

import Foundation
import UIKit

struct Fonts {

    enum Name: String {
        case openSans = "OpenSans"
        case openSansSemibold = "OpenSans-Semibold"
        case helveticaLight = "Helvetica-Light"
    }

    static func font(_ name: Name, size: CGFloat) -> UIFont {
        UIFont(name: name.rawValue, size: size)!
    }
}
