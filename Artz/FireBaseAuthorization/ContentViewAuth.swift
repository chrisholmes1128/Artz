//
//  ContentViewAuth.swift
//  Artz
//
//  Created by Chris holmes on 3/10/20.
//  Copyright © 2020 Chris holmes. All rights reserved.
//

import SwiftUI

struct ContentViewAuth: View {
    @EnvironmentObject var session: StoreSession
    
    func getUser() {
        session.listen()
    }
    var body: some View {
        Group{
            if (session.session != nil){
                HomeView().environmentObject(StoreSession())
            }
            else{
                AuthUIView()
            }
        }.onAppear(perform: getUser)
    }
}

struct ContentViewAuth_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewAuth().environmentObject(StoreSession())
    }
}
