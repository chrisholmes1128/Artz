//
//  ArtPieceItem.swift
//  Artz
//
//  Created by Chris holmes on 3/8/20.
//  Copyright © 2020 Chris holmes. All rights reserved.
//

import SwiftUI

struct ArtPieceItem: View {
    var artPiece: ArtPiece
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15.0){
            
            Image(artPiece.imageName)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width:300, height:300)
                .cornerRadius(10)
            
            VStack(alignment: .leading){
                Text(artPiece.name)
                .font(.headline)
                Text(artPiece.owner)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
            .padding(5.0)
            
        }
    }
}

struct ArtPieceItem_Previews: PreviewProvider {
    static var previews: some View {
        ArtPieceItem(artPiece: artPieceData[0])
    }
}

