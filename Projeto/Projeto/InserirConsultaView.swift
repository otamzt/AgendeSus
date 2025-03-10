import SwiftUI
struct Posto: Hashable {
    let nome: String
}

var array = [
    Posto(nome: "Vila Nova"),
    Posto(nome: "Centro"),
    Posto(nome: "Lagoinha"),
    Posto(nome: "Santa Rita")
]

struct Horario: Hashable {
    let hora: String
}

var arrayHora = [
    Horario(hora: "13:30"),
    Horario(hora: "14:00"),
    Horario(hora: "14:30"),
    Horario(hora: "15:00")
]
struct InserirConsultaView : View {
    @State var dt: String = ""
    @State var cel: String = ""
    @State var cartao: String = ""
    @State var unidade = Posto(nome: "Vila Nova")
    @State var hr = Horario(hora: "13:00")
    @StateObject var viewModel = ViewModel()
    
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
                Spacer()
                Divider()
                    .padding(.bottom)
                Text("Data Consulta")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title2)
                    .bold()
                TextField("dd/mm/aaaa", text: $dt)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Divider()
                Text("Horário:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title2)
                    .bold()
                Picker("", selection: $hr) {
                    ForEach(arrayHora, id: \.self) { h in
                        Text(h.hora)
                    }
                }
                .background(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                Text("Selecione a unidade:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title2)
                    .bold()
                    .padding(.top)
                Picker("", selection: $unidade) {
                    ForEach(array, id: \.self) { l in
                        Text(l.nome)
                    }
                }
                .background(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                Text("Configure os dados:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title2)
                    .bold()
                    .padding(.top)
                HStack {
                    Text("Telefone:")
                        .font(.title2)
                    TextField("(xx) xxxxx-xxxx", text: $cel)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Text("Nº cartão SUS:")
                        .font(.title2)
                    TextField("xxx xxxx xxxx xxxx", text: $cartao)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Divider()
                    .padding(.top)
                Spacer()
                Button("Confirmar") {
                    let consulta = Consultas(nome: cartao, hora: hr.hora, Posto: unidade.nome, data: dt)
                    viewModel.post(consulta)
                }
                .foregroundColor(.white)
                .bold()
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Detail")
                   .navigationBarBackButtonHidden(false)
                   .toolbar {
                       ToolbarItem(placement: .navigationBarLeading) {
                           Button(action: {
                               // Custom action for back button, if needed
                           }) {
                               Text("Custom Back")  // Your custom back button text
                           }
                       }
                   }
    }
}
#Preview {
    InserirConsultaView()
}
