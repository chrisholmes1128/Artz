//
//  ArtPieceDetail.swift
//  Artz
//
//  Created by Chris holmes on 3/9/20.
//  Copyright © 2020 Chris holmes. All rights reserved.
//

import SwiftUI

struct ArtPieceDetail: View {
    
    var artPiece: ArtPiece
    
    var body: some View {
        List{
            ZStack(alignment: .bottom){
                Image(artPiece.imageName)
                .resizable()
                    .aspectRatio(contentMode: .fit)
                Rectangle()
                    .frame(height: 80)
                    .opacity(0.6)
                    .blur(radius: 10)
                
                HStack{
                    VStack(alignment: .leading, spacing: 10){
                        Text(artPiece.name)
                            .foregroundColor(.white)
                            .bold()
                            .font(.largeTitle)
                    }
                    .padding(.leading)
                    .padding(.bottom)
                    Spacer()
                    
                }
            }.listRowInsets(EdgeInsets())
    
            VStack(alignment: .leading){
                Text(artPiece.owner)
                    .bold()
                    .foregroundColor(.black)
                HStack{
                    Text("\(artPiece.state),")
                    .foregroundColor(.gray)
                    .font(.body)
                    .lineLimit(nil)
                    
                    Text(artPiece.city)
                    .foregroundColor(.gray)
                    .font(.body)
                    .lineLimit(nil)
                    
                }
                
                Text(artPiece.description)
                    .foregroundColor(.gray)
                    .font(.body)
                    .lineLimit(nil)
                    .lineSpacing(4)
                .padding(.bottom)
                
                Spacer()
            
            }.padding(.bottom)
            .padding(.top)
            
           Button(action: {
                
           }){
               Text("Purchase")
           }
            
        }.edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
        
    }
}

struct ArtPieceDetail_Previews: PreviewProvider {
    static var previews: some View {
        ArtPieceDetail(artPiece: artPieceData[3])
    }
}
