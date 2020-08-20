//
//  UserProfileView.swift
//  Artz
//
//  Created by Chris holmes on 7/6/20.
//  Copyright © 2020 Chris holmes. All rights reserved.
//

import Foundation
import SwiftUI

struct userProfileView: View{
    @EnvironmentObject var session: StoreSession
    var userImages = [UIImage]()
    
    var body: some View{
        ZStack{
            Color(.white)
            .edgesIgnoringSafeArea(.all)
            VStack{
                
                Image("Piece1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .cornerRadius(20)
                    .padding(.bottom)
                
                Text("Ben Hood")
                    .font(.headline)
                
                
                Text("@vvithinsanity")
                    .font(.subheadline)
                
                Spacer()
                
                Button(action: {self.session.signOut()}){
                    Text("Sign Out")
                        .frame(minWidth: 0, maxWidth: 200, maxHeight: 60)
                        .font(.system(.headline))
                        .background(Color(.red))
                        .foregroundColor(.white)
                        .cornerRadius(5)
                    
                }.padding(.bottom, 20)
                
            }
        }
    }
}

