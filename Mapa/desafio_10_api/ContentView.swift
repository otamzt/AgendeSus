import SwiftUI
import MapKit


//
//struct ContentView: View {
//    @StateObject var vm = ViewModel()
//
//    var body: some View {
//
//        VStack  {
//            ForEach(vm.arrayestabelecimento, id: \.self) {est in
//
//                Text(est.nome_fantasia)
//                Text(est.bairro_estabelecimento)
//
//
//            }
//
//        }   .onAppear() {
//            vm.fetch()
//        }
//        .padding()
//    }
//}
//#Preview {
//    ContentView()
//}
//
//
//
//struct Location: Decodable, Hashable {
////    let id = UUID()
//    let nome_fantasia: String
//    let foto: String
//    let descricao: String
//    let latitude: Double
//    let longitude: Double
//}
//
var locations: [Estab] = [Estab(nome_razao_social: "", nome_fantasia: "", endereco_estabelecimento: "", numero_estabelecimento: "", bairro_estabelecimento: "", latitude_estabelecimento_decimo_grau: 0.0, longitude_estabelecimento_decimo_grau: 0.0, descricao_turno_atendimento: "")]

struct ContentView: View {
    @State private var selectedLocation : String = ""
    @State  var position = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -18.602113814217, longitude: -47.4305082547683),
        span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
    ))
    @StateObject var vm = ViewModel()
    
    @State var locationAUX = Estab(nome_razao_social: "", nome_fantasia: "", endereco_estabelecimento: "", numero_estabelecimento: "", bairro_estabelecimento: "", latitude_estabelecimento_decimo_grau: 0.0, longitude_estabelecimento_decimo_grau: 0.0, descricao_turno_atendimento: "")
    
    var body: some View {
        NavigationStack {
            VStack {
                //                // Picker no topo
                Picker("Selecione a cidade", selection: $locationAUX) {
                    ForEach(vm.arrayestabelecimento, id: \.self) { index2 in
                        Text(index2.nome_fantasia)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .onChange(of:locationAUX ){
                    position = MapCameraPosition.region(MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: locationAUX.latitude_estabelecimento_decimo_grau, longitude: locationAUX.longitude_estabelecimento_decimo_grau),
                        span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                    ))
                }
                // Mapa com pinos e fundo no Annotation
                Map(position: $position) {
                    ForEach(vm.arrayestabelecimento, id: \.self) { index in
                        Annotation("",coordinate: CLLocationCoordinate2D(latitude: index.latitude_estabelecimento_decimo_grau, longitude: index.longitude_estabelecimento_decimo_grau)) {
                            NavigationLink(destination: LocationDetailView(location: index)) {
                                VStack(spacing: 5) {
                                    Image(systemName: "mappin.circle.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(.red)
                                    
                                    // Fundo personalizado para o nome da cidade
                                    
                                    Text(index.nome_fantasia)
                                        .font(.caption)
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding(6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.black.opacity(0.7))
                                        )
                                }
                            }
                        }
                    }
                }
                .ignoresSafeArea()
            }
            //            .onChange(of: selectedLocation) { newIndex in
            //                let newLocation = locations[newIndex]
            //                position.center = CLLocationCoordinate2D(latitude: newLocation.latitude, longitude: newLocation.longitude)
            //            }
        }.onAppear(){vm.fetch()}
    }
}

struct LocationDetailView: View {
    @State var location: Estab
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.white)
            
            
            VStack {
                HStack {
                    Text("Localização:")
                        .font(.title)   
                        .padding(.top, 75)
                    Spacer()
                }
                
                .padding()
                .bold()
                
                    HStack {
                        Spacer()
                            Text(location.bairro_estabelecimento)
                            .foregroundStyle(.white)
                            .bold()
                            Text(location.endereco_estabelecimento)
                            .foregroundStyle(.white)
                            .bold()
                            Text(location.numero_estabelecimento)
                            .foregroundStyle(.white)
                            .bold()
                        Spacer()
                        
                    }.padding().background(.blue)
                    .clipShape (RoundedRectangle (cornerRadius: 15.0)).padding(.horizontal)
                
                HStack {
                    
                    Text("Horário de atendimento:")
                        .font(.title)
                    Spacer()
                }
                
                .padding()
                .bold()
                HStack {
                    Spacer()
                    Text(location.descricao_turno_atendimento)
                        .foregroundStyle(.white)
                        .bold()
                    Spacer()
                }
                .padding().background(.blue)
                .clipShape (RoundedRectangle (cornerRadius: 15.0
                                             )).padding(.horizontal)
                Spacer()
                
            }
            .navigationTitle(location.nome_fantasia)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}

