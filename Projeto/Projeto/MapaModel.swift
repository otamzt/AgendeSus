import Foundation


struct Estab : Decodable, Hashable{
    
    var nome_razao_social: String
    var nome_fantasia: String
    var endereco_estabelecimento: String
    var numero_estabelecimento: String
    var bairro_estabelecimento: String
    var numero_telefone_estabelecimento: String?
    var latitude_estabelecimento_decimo_grau:  Double
    var longitude_estabelecimento_decimo_grau: Double
    var descricao_turno_atendimento: String
    
    
}
struct estabelecimento : Decodable, Hashable{
    
    var estabelecimentos : [Estab]
}
