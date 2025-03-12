//
//  HomeView.swift
//  Projeto
//
//  Created by Turma02-20 on 11/03/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = ViewModelHome()
        @State private var isPresentWebView = false
        
        @State var aux = NewsItem(link: "http://google.com", imageURL: "")
    
        
    var body: some View {
        NavigationStack{
            VStack {
                HStack{
                    Image(systemName: "bell.badge.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                        .font(.title)
                    Spacer()
                    NavigationLink(destination: ContentView()){
                        Image(systemName: "person.circle.fill")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                            .font(.title)
                    }
                    
                    
                }
                HStack{
                    NavigationLink(destination: InserirConsultaView()){
                        Text("Agendar").padding(12.0).foregroundColor(.white).bold().background(.blue).font(.title2).cornerRadius(8.0)
                    }

                }
                Spacer()
                VStack{
                    HStack{
                        Text("Como Funciona?").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "1.circle.fill")
                        Text("Clique em agendar.").fontWeight(.medium)
                        Spacer()
                    }.padding().background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 15.0))
                    HStack{
                        Image(systemName: "2.circle.fill")
                        Text("Selecione a data e unidade de atendimento.").fontWeight(.medium)
                        Spacer()
                    }.padding().background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 15.0))
                    HStack{
                        Image(systemName: "3.circle.fill")
                        Text("Confirme seus dados.").fontWeight(.medium)
                        Spacer()
                    }.padding().background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 15.0))
                    HStack{
                        Image(systemName: "4.circle.fill")
                        Text("Agora é só confirmar.").fontWeight(.medium)
                        Spacer()
                    }.padding().background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 15.0))
                }
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader{ proxy in
                        HStack {
                            ForEach(viewModel.newsItems, id: \.self) { item in
                                
                                
                                VStack {
                                    AsyncImage(url: URL(string: (item.imageURL))) { image in
                                        image
                                            .resizable()
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                aux = item
                                                isPresentWebView = true
                                                
                                                
                                            }
                                        
                                        
                                        
                                    } placeholder: {
                                        ProgressView()
                                    }.frame(width: 340, height: 170)
                                    
                                }.sheet(isPresented: $isPresentWebView, content:{
                                    WebView(news: $aux)
                                } )
                                
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchNews()
                }
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
