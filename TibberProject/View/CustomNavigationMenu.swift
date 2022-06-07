//
//  CustomNavigationMenu.swift
//  TibberProject
//
//  Created by Amir Nilsson on 2022-06-04.
//

// We will use this view as a container for our other views, its like a custom navbar

import SwiftUI

struct CustomNavigationMenu<Custom:View>: View {
    
    let content:Custom
    let title:String
    @Environment(\.presentationMode) private var presentationMode
    
    init(title:String,@ViewBuilder content : () -> Custom){
        self.content = content()
        self.title = title
    }
    
    var body: some View {
        VStack {
            ZStack {
                Color.theme.blue.edgesIgnoringSafeArea(.top)
                    .frame(height:UIScreen.main.bounds.height/11)
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack(spacing:30) {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width:25,height:25)
                            
                            Text(title)
                        }.foregroundColor(.white)
                }
                    
                    Spacer()
                }
                .padding()
            }
            
            content
            
            Spacer()
        }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

struct CustomNavigationMenu_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationMenu(title:"Test") {
            Text("Hello World")
        }
    }
}
