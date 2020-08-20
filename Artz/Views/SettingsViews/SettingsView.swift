//
//  SettingsView.swift
//  Artz
//
//  Created by Chris holmes on 3/24/20.
//  Copyright © 2020 Chris holmes. All rights reserved.
//

import SwiftUI
import Combine
import Firebase

struct SettingsView: View {
    @EnvironmentObject var session: StoreSession
    
    func getUser() {
        session.listen()
    }
    
    func signOut(){
        session.signOut()
    }
    
    var body: some View{

        NavigationView{
            List{
                
                NavigationLink(destination: EditNameView()){
                    Text("Name")
                }
                NavigationLink(destination: PhoneNumberView()){
                    Text("Phone Number")
                }
                NavigationLink(destination: EditEmailView()){
                    Text("Email")
                }
                NavigationLink(destination: ResetPasswordView()){
                    Text("Password")
                }
                NavigationLink(destination: PrivacyView()){
                    Text("Privacy")
                }
                
            }
        }
    }
}
