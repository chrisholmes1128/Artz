//
//  Data.swift
//  Artz
//
//  Created by Chris holmes on 3/8/20.
//  Copyright © 2020 Chris holmes. All rights reserved.
//

import Foundation
let artPieceData:[ArtPiece] = load("works.json")

func load<T: Decodable>(_ filename:String, as type:T.Type = T.self) -> T{
    let data:Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else{
            fatalError("Couldn't retrieve \(filename) in bundle")
    }
    
    do {
        data = try Data(contentsOf: file)
    }
    catch{
        fatalError("Couldn't retrieve \(filename) in bundle => \(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    catch{
        fatalError("Couldn't retrieve \(filename) as \(T.self) => \(error)")
    }
}
