import SwiftUI

var Locations: [Estab] = [Estab(nome_razao_social: "", nome_fantasia: "", endereco_estabelecimento: "", numero_estabelecimento: "", bairro_estabelecimento: "", latitude_estabelecimento_decimo_grau: 1.1, longitude_estabelecimento_decimo_grau: 2.2, descricao_turno_atendimento: "")]

struct Posto: Hashable {
    let nome: String
}

struct Horario: Hashable {
    let hora: String
}

var arrayHora = [
    Horario(hora: "07:00"),
    Horario(hora: "07:30"),
    Horario(hora: "08:00"),
    Horario(hora: "08:30"),
    Horario(hora: "09:00"),
    Horario(hora: "09:30"),
    Horario(hora: "10:00"),
    Horario(hora: "10:30"),
    Horario(hora: "11:00"),
    Horario(hora: "11:30"),
    Horario(hora: "13:30"),
    Horario(hora: "14:00"),
    Horario(hora: "14:30"),
    Horario(hora: "15:00")
]

struct InserirConsultaView : View {
    @State private var alerta1 = false
    @State private var alerta2 = false
    @State var dt: String = ""
    @State var cel: String = ""
    @State var cartao: String = ""
    @State var hr = Horario(hora: "13:00")
    @StateObject var viewModel = ViewModel()
    @StateObject var vm = MapaViewModel()
    @State var locationAUX = Estab(nome_razao_social: "", nome_fantasia: "", endereco_estabelecimento: "", numero_estabelecimento: "", bairro_estabelecimento: "", latitude_estabelecimento_decimo_grau: 0.0, longitude_estabelecimento_decimo_grau: 0.0, descricao_turno_atendimento: "")
    
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
                Picker("", selection: $locationAUX) {
                    ForEach(vm.arrayestabelecimento, id: \.self) { index2 in
                        Text(index2.nome_fantasia)
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
                    if(!cartao.isEmpty && !cel.isEmpty && !dt.isEmpty)
                    {
                        let consulta = Consultas(nome: cartao, hora: hr.hora, Posto: locationAUX.nome_fantasia, data: dt,
                                                 lat: locationAUX.latitude_estabelecimento_decimo_grau, long: locationAUX.longitude_estabelecimento_decimo_grau)
                        viewModel.post(consulta)
                        alerta2 = true
                        dt = ""
                        cel = ""
                        cartao = ""

                    }
                    else{
                        alerta1 = true
                    }
                }.alert("Preencha todos os campos", isPresented: $alerta1) {
                    Button("OK", role: .cancel) { }
                    
                }
                .alert("Consulta solicitada", isPresented: $alerta2) {
                    Button("OK", role: .cancel) { }
                    
                }
                .foregroundColor(.white)
                .bold()
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                Spacer()
            }
            .padding()
            .onAppear(){vm.fetch()}
        }
    }
}
#Preview {
    InserirConsultaView()
}
