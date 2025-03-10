import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State var nome: String = ""
    @State var end: String = ""
    @State var cpf: String = ""

    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack {
                    Image(systemName: "bell.badge.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                        .font(.title)
                    Spacer()
                    Image(systemName: "person.circle.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                        .font(.title)
                }
                .padding()

                Text("Dados Pessoais")
                    .font(.title)
                    .fontWeight(.bold)
                Divider()
                
                VStack {
                    TextField("Nome", text: $nome)
                        .font(.title2)
                    Divider()
                    TextField("Cpf", text: $cpf)
                        .font(.title2)
                    Divider()
                    TextField("Endereço", text: $end)
                        .font(.title2)
                }
                .shadow(radius: 8)
                .padding()
                Divider()

                VStack {
                    HStack{
                        Text("Consultas")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(.bottom)
                    ForEach(viewModel.listConsultas, id: \.self) { consulta in
                        VStack {
                            HStack{
                                Text(consulta.Posto)
                                    .font(.title2).bold()
                                    Text(consulta.data)
                                    Text(consulta.hora)
                            }
                            .padding(.horizontal)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                            HStack{
                            Button("Cancelar") {
                                if let index = viewModel.listConsultas.firstIndex(of: consulta) {
                                    viewModel.remove(at: IndexSet(integer: index))
                                }
                            }
                            .foregroundColor(.white)
                            .bold()
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
                            Button("Localização") {
                                // Ação para localização
                            }
                            .foregroundColor(.white)
                            .bold()
                            .buttonStyle(.borderedProminent)
                            .tint(.blue)
                            }
                        }
                    }
                }
                .padding()
                Spacer()
                
            }
        }
        .onAppear {
            viewModel.fetch()
        } 
           
           
    }
}

#Preview {
    ContentView()
}
