//
//  ContentView.swift
//  TibberProject
//
//  Created by Amir Nilsson on 2022-06-04.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm:TiberVM = TiberVM()
    
    var body: some View {
        
        VStack(spacing:0) {
            headerColor
            
            if let data = vm.dataset {
                List {
                    //acitve powerupsection
                    Section("Active power-ups") {
                        ForEach(data.data.assignmentData.filter({ asd in
                            asd.connected
                        })) { item in
                            NavigationLink {
                                CustomNavigationMenu(title: item.title) {
                                    DetailPage(url: URL(string: item.imageURL),
                                               title: item.title, descr: item.assignmentDatumDescription,
                                               longDescr: item.longDescription)
                                }
                            } label: {
                                ItemUI(url: URL(string: item.imageURL),
                                       title: item.title,
                                       descr: item.assignmentDatumDescription)
                                
                            }
                        }
                    }
                    
                    //available powerupsection
                    Section("Available power-ups") {
                        ForEach(data.data.assignmentData.filter({ asd in
                            !asd.connected
                        })) { item in
                            
                            NavigationLink {
                                CustomNavigationMenu(title: item.title) {
                                    DetailPage(url: URL(string: item.imageURL),
                                               title: item.title, descr: item.assignmentDatumDescription,
                                               longDescr: item.longDescription)
                                }
                            } label: {
                                ItemUI(url: URL(string: item.imageURL),
                                       title: item.title,
                                       descr: item.assignmentDatumDescription)
                            }
                    }
                }
            }
                .listStyle(.insetGrouped)
                .navigationBarHidden(true)
            } else {
                VStack {
                    ProgressView()
                    Text("Loading data...")
                }.navigationBarHidden(true)
            }
            
            Spacer()
        }.alert(isPresented: $vm.errorUp) {
            Alert(title: Text("Warning"), message: Text(vm.errorHandler.description))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension ContentView {
    private var headerColor:some View {
        Color.theme.blue.edgesIgnoringSafeArea(.top)
            .frame(height:UIScreen.main.bounds.height/11)
            .overlay(
                HStack {
                    Text("Power-ups")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                    Spacer()
                }
                    .padding()
            )
    }
}
