//
//  AuthUIView.swift
//  Artz
//
//  Created by Chris holmes on 3/10/20.
//  Copyright © 2020 Chris holmes. All rights reserved.
//

import SwiftUI
import FirebaseStorage

struct signInView: View{
    @EnvironmentObject var session: StoreSession
    @State var email: String = ""
    @State var uname: String = ""
    @State var password: String = ""
    @State var error: String = ""
    
    func signIn(){
        session.signIn(email: email, password: password){(result, error) in
            if let error = error{
                self.error = error.localizedDescription
            }
            else{
                self.email = ""
                self.password = ""
            }
            
        }
    }
    
    var body: some View{
        
        VStack{
            Text("Welcome to Artz!")
                .font(.system(size: 30, weight: .heavy))
                .foregroundColor(Color(.systemTeal))
            
            Text("Sign in to continue")
                .font(.body)
                .foregroundColor(.gray)
            VStack(spacing: 30){
                
                TextField("Email Address", text: $email)
                    .padding(10)
                    .font(.subheadline)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.systemBlue), lineWidth: 1))
                    
                SecureField("Password", text: $password)
                    .padding(10)
                    .font(.subheadline)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.systemBlue), lineWidth: 1))
                    
            }.padding(.vertical, 50)
            .padding(20)
            
            Spacer()
            
            Button(action:{
                self.signIn()
            }){
                Spacer()
                Text("Sign In")
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 60)
                    .font(.system(.headline))
                    .background(Color(.systemTeal))
                    .foregroundColor(.white)
                    .cornerRadius(5)
                Spacer()
            }
            
            if (error != ""){
                Text(error)
                    .font(.subheadline)
                    .font(.system(size: 12))
            }
            
            Spacer()
            
            NavigationLink(destination: signUpView()){
                HStack{
                    Text("New user?")
                        .font(.subheadline)
                        .foregroundColor(Color(.gray))
                    Text("Create an account")
                        .font(.subheadline)
                        
                }
            }
            
        }
    }
}


struct signUpView: View {
    @EnvironmentObject var session: StoreSession
    @State var UIError = false
    @State var email: String = ""
    @State var displayName: String = ""
    @State var password: String = ""
    @State var passwordConfirm: String = ""
    @State var error: String = ""
    
    func signUp(){
        session.signUp(email: email, password: password){(result, error) in
            if let error = error{
                self.error = error.localizedDescription
            }
            else{
                self.email = ""
                self.displayName = ""
                self.password = ""
            }
            
        }
    }
    
    @State var show = false
    
    var body: some View{
        
        VStack(alignment: .leading){
            
            Text("Create an Account")
                .font(.largeTitle)
                .foregroundColor(.gray)
            
            Text("Start your Collection today")
                .font(.caption)
                .font(.system(size: 30))
                .foregroundColor(Color(.systemTeal))
                .bold()
             
            VStack(spacing: 30){
                
                Button(action:{
                    self.show.toggle()
                }){
                    Text("Upload Profile Picture")
                }.sheet(isPresented: $show){
                    imagePicker(show: self.$show)
                }
                    
                TextField("Email Address", text: $email)
                    .padding(10)
                    .font(.subheadline)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.systemBlue), lineWidth: 1))
                TextField("Username", text: $displayName)
                    .padding(10)
                    .font(.subheadline)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.systemBlue), lineWidth: 1))
                        
                SecureField("Password", text: $password)
                    .padding(10)
                    .font(.subheadline)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.systemBlue), lineWidth: 1))
                
                SecureField("Confirm password", text: $passwordConfirm)
                    .padding(10)
                    .font(.subheadline)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.systemBlue), lineWidth: 1))
                        
            }.padding(.vertical, 50)
            .padding(.trailing, 30)
            
            
            
            Spacer()
            
            Button(action:{
                if (self.password != self.passwordConfirm){
                    self.UIError.toggle()
                }
                else{
                    self.signUp()
                }
            }){
                VStack{
                    if UIError{
                        Text("Passwords do not match")
                        .font(.subheadline)
                        .font(.system(size: 12))
                        .foregroundColor(Color(.systemRed))
                        .padding()
                    }
                    Spacer()
                    
                    Text("Create Account")
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 60)
                        .font(.system(.headline))
                        .background(Color(.systemTeal))
                        .foregroundColor(.white)
                        .cornerRadius(5)
                    
                    Spacer()
                }
            }.padding(.trailing, 30)
            
            if(error != ""){
                Text(error)
                    .font(.subheadline)
                    .font(.system(size: 12))
            }
        }
        .padding(.top, 5)
        .padding(.leading, 25)
        
    }
}

//Image Picker to save to Firebase
struct imagePicker : UIViewControllerRepresentable{
    
    func makeCoordinator() -> imagePicker.Coordinator {
        return imagePicker.Coordinator(parent1: self)
    }
    
    @Binding var show : Bool
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<imagePicker>) -> imagePicker.UIViewControllerType {
        let image = UIImagePickerController()
        image.sourceType = .photoLibrary
        image.delegate = context.coordinator
        return image
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<imagePicker>) {
        
    }
    
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent : imagePicker!
        
        init(parent1: imagePicker){
            parent = parent1
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.show.toggle()
            
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let image = info[.originalImage] as! UIImage
            let storage = Storage.storage()
        storage.reference().child("temp").putData(image.jpegData(compressionQuality: 0.35)!, metadata: nil){
                (_, err) in
                if err != nil{
                    print((err?.localizedDescription)!)
                    return
                }
                print("Successful Upload")
            }
            parent.show.toggle()
            
        }
    }
}

struct AuthUIView: View {
    var body: some View {
        NavigationView{
            signInView()
        }
    }
}

struct AuthUIView_Previews: PreviewProvider {
    static var previews: some View {
        AuthUIView()
    }
}
