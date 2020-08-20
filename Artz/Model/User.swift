//
//  File.swift
//  Artz
//
//  Created by Chris holmes on 5/27/20.
//  Copyright © 2020 Chris holmes. All rights reserved.
//

import Foundation
import SwiftUI

struct UserView: View {
    var user: User
    
    var body: some View {
        VStack{
            Image("Piece1")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height:100, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding([.leading, .trailing])
            
        }
    }
}
