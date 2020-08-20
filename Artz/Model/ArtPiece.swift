//
//  ArtPiece.swift
//  Artz
//
//  Created by Chris holmes on 3/8/20.
//  Copyright © 2020 Chris holmes. All rights reserved.
//

import Foundation
import SwiftUI

struct ArtPiece: Hashable, Codable, Identifiable {
    
    var id: Int
    var name: String
    var imageName: String
    var category: Category
    var owner: String
    var description: String
    var state: String
    var city: String
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case drawing = "DRAWING"
        case improvised = "IMPROVISED"
        case painting = "PAINTING"
        
    }
    
}
