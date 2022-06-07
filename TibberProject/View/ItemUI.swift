//
//  ItemUI.swift
//  TibberProject
//
//  Created by Amir Nilsson on 2022-06-04.
//

import SwiftUI

struct ItemUI : View {
    
    let url :URL?
    let title:String
    let descr:String
    
    
    var body: some View {
        HStack(spacing:20) {
            AsyncImage(url: url) { img in
                img.resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(maxWidth: 70, maxHeight: 70)
            } placeholder: {
                ProgressView()
            }
            

            VStack(alignment:.leading,spacing:15) {
                Text(title)
                    .fontWeight(.bold)
                    .font(.title)
                Text(descr)
                    .font(.body)
            }
            
            Spacer()
        }.padding()
            
    }
}

struct ItemUI_Previews: PreviewProvider {
    static var previews: some View {
        ItemUI(url: URL(string: "https://tibber-app-gateway.imgix.net/images/powerup/tile/ngenic.png"),
               title: "Ngenic",
               descr: "Ngenic is a smart thermostat to control your water based heating")
           
    }
}

