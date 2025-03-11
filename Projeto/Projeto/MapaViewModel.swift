import Foundation

class MapaViewModel: ObservableObject {
    @Published var arrayestabelecimento : [Estab] = []
    
    func fetch(){
        let url = "https://apidadosabertos.saude.gov.br/cnes/estabelecimentos?codigo_municipio=314310&limit=20&offset=0"
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!){Data, _, erro in
            do {
                self.arrayestabelecimento = try JSONDecoder().decode(estabelecimento.self, from: Data!).estabelecimentos
                print(self.arrayestabelecimento.count)
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
}

//https:apidadosabertos.saude.gov.br/cnes/estabelecimentos/6510132
