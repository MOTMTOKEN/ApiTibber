//
//  DetailView.swift
//  TibberProject
//
//  Created by Amir Nilsson on 2022-06-04.
//

import SwiftUI


struct DetailPage: View {
    let url:URL?
    let title:String
    let descr:String
    let longDescr:String
    
    @State private var clicked:Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing:10) {
                topItem
                
                Rectangle()
                    .fill(Color.theme.gray)
                    .frame(height:geo.size.height/3.5)
                    .padding()
                    .overlay(
                        VStack(spacing:30) {
                            Button {
                                clicked.toggle()
                            } label: {
                                Capsule()
                                    .fill(clicked ? Color.theme.gray : Color.theme.blue)
                                    .frame(width:geo.size.width/1.2 ,height:geo.size.height/15)
                                    .background(
                                        Capsule()
                                            .stroke(clicked ? .red : Color.theme.gray,lineWidth: 5)
                                    )
                                    .overlay(
                                        Text(!clicked ? "Connect to Tibber" : "Disconnect from Tibber")
                                            .foregroundColor(!clicked ? .white : .red)
                                    )
                            }
                            
                            Button {
                                
                            } label: {
                                Capsule()
                                    .fill(.white)
                                    .frame(width:geo.size.width/1.2 ,height:geo.size.height/15)
                                    .overlay(
                                        Text("Buy at the Tibber store")
                                            .foregroundColor(.black)
                                            
                                    )
                            }
                            
                            
                            
                            
                        }
                    )
                    
                ScrollView {
                    VStack(alignment:.leading,spacing: 20) {
                        Text("More about \(title)")
                            .fontWeight(.bold)
                        Text(longDescr)
                    }
                }.padding(.horizontal,20)
            }
        }
    }
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailPage(url: nil, title: "Title",descr:"descr", longDescr: "Long descr")
    }
}


extension DetailPage {
    private var topItem:some View {
        HStack(spacing:20) {
            AsyncImage(url: url) { img in
                img.resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(maxWidth: 120, maxHeight: 120)
            } placeholder: {
                ProgressView()
        }
            VStack(alignment:.leading,spacing: 10){
                Text(title)
                    .fontWeight(.bold)
                    .font(.title2)
                Text(descr)
                    .font(.body)
                    .foregroundColor(.gray)
            }
        }.padding()
    }
}
