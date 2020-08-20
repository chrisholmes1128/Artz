//
//  StoreSession.swift
//  Artz
//
//  Created by Chris holmes on 3/10/20.
//  Copyright © 2020 Chris holmes. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

class StoreSession: ObservableObject {
    var didChange = PassthroughSubject<StoreSession, Never>()
    @Published var session: User? {didSet {self.didChange.send(self)}}
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen(){
        handle = Auth.auth().addStateDidChangeListener({(auth, user) in
            if let user = user{
                self.session = User(uid: user.uid, displayName: user.displayName, email: user.email)
            } else{
                self.session = nil
            }
        })
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.session = nil
        }
        catch{
            print("Could not sign out.")
        }
    }
    
    func unbind(){
        if let handle = handle{
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit{
        unbind()
    }
}

struct User{
    var uid: String
    var email: String?
    var displayName: String?
    
    init(uid: String, displayName: String?, email: String?){
        self.uid = uid
        self.displayName = displayName
        self.email = email
    }
}
