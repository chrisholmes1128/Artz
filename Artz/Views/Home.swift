//
//  ContentView.swift
//  Artz
//
//  Created by Chris holmes on 3/8/20.
//  Copyright © 2020 Chris holmes. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

struct HomeView: View {
    @State var enableSettingsView: Bool = false
    @State var enableAddPhoto = false
    @State var show: Bool = false
    @State var image: Image?
    @State var sourceNumber: Int = 0

    
    @EnvironmentObject var session: StoreSession
    
    init(){
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var categories:[String:[ArtPiece]]{
        .init(
            grouping: artPieceData,
            by: {$0.category.rawValue}
        )
    }
    
    var body: some View {
        
        NavigationView{
            
            TabView{
                ZStack(){
                    HStack(){
                        List(categories.keys.sorted(), id: \String.self) { key in
                            ArtPieceRow(categoryName: "\(key)", artPieces: self.categories[key]!)
                                .frame(width:300)
                                .padding(.top)
                            
                        }
                    }.padding(20)
                    
                    
                    VStack {
                        Spacer()
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.enableAddPhoto.toggle()
                                })
                                {
                                    Text("+")
                                        .font(.system(.largeTitle))
                                        .frame(width: 58, height: 50)
                                        .foregroundColor(Color.white)
                                        .padding(.bottom, 7)
                                        .background(Color.blue)
                                        .clipShape(Circle())
                                    
                                }.padding(.bottom, 10)
                                .padding(.trailing, 10)
                                
                            }
                        }
                        .actionSheet(isPresented: $enableAddPhoto, content: { ()-> ActionSheet in ActionSheet(title: Text("Choose an Image"), message: Text("Select an image from gallery or use camera"), buttons: [
                                ActionSheet.Button.default(Text("Camera"), action: {
                                    self.sourceNumber = 0
                                    self.show.toggle()
                                }),
                                ActionSheet.Button.default(Text("My Gallery"), action: {
                                    self.sourceNumber = 1
                                    self.show.toggle()
                                }),
                                ActionSheet.Button.cancel()
                            ])
                        })
                        if show {
                            ImagePicker(isVisibile: $show, image: $image, sourceNumber: $sourceNumber)
                        }
                    }
                    .tabItem{
                            VStack{
                                Image("home")
                                Text("Home")
                            }
                    }
                
                userProfileView()
                    
                    .tabItem{
                            VStack{
                                Image("user")
                                Text("Gallery")
                            }
                    }
                Text("Add friends")
                    .tabItem{
                            VStack{
                                Image("friends")
                                Text("Friends")
                            }
                    }
                Text("Chat")
                    .tabItem{
                    
                    
                        VStack{
                            Image("message")
                            Text("Chat")
                            
                        }
                    }

            }
            .navigationBarTitle("Artz")
            .navigationBarItems(trailing:
            Button(action: {
                    self.enableSettingsView.toggle()
                })  {
                    Image("SettingsButton")
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                        .padding(.top)
            }.sheet(isPresented: $enableSettingsView){SettingsView().environmentObject(StoreSession())}
            ).padding(.bottom, 10)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(StoreSession())
    }
}
