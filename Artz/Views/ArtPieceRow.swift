//
//  ArtPieceRow.swift
//  Artz
//
//  Created by Chris holmes on 3/8/20.
//  Copyright © 2020 Chris holmes. All rights reserved.
//

import SwiftUI

struct ArtPieceRow: View {
    
    var categoryName: String
    var artPieces: [ArtPiece]
    
    var body: some View {
        
        VStack(){
            
            Text(self.categoryName)
                .font(.title)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top){
                    ForEach(artPieces, id: \.name) { artPiece in
                        NavigationLink(destination: ArtPieceDetail(artPiece: artPiece))
                        {
                            ArtPieceItem(artPiece: artPiece)
                        }
                        
                    }
                }
            }
            
        }
    }
}

struct ArtPieceRow_Previews: PreviewProvider {
    static var previews: some View {
        ArtPieceRow(categoryName: "DRAWING", artPieces: artPieceData)
    }
}
