//
//  Fonts.swift
//  DiagnalTest
//
//  Created by Roster Buster on 26/02/24.
//

import Foundation
import UIKit

struct Fonts {

    enum Name: String {
        case helveticaLight = "Helvetica-Light"
        case zapfino = "Zapfino"
    }

    static func font(_ name: Name, size: CGFloat) -> UIFont {
        UIFont(name: name.rawValue, size: size)!
    }
}
