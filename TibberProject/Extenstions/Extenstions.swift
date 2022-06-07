//
//  Extenstions.swift
//  TibberProject
//
//  Created by Amir Nilsson on 2022-06-04.
//

import Foundation
import SwiftUI

class ColorTheme {
    let blue = Color("colorBlue")
    let gray = Color("colorGray")
}


extension Color {
    static let theme:ColorTheme = ColorTheme()
}
