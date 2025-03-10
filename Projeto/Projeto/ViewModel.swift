//
//  ViewModel.swift
//  APISendData
//
//  Created by edilsonalmeida on 27/04/23.
//

import Foundation

struct Consultas : Codable, Hashable{
    var _id : String?
    var _rev : String?
    var nome : String
    var hora : String
    var Posto : String
    var data : String
}


class ViewModel : ObservableObject{
    
    @Published var listConsultas : [Consultas] = []
    
    func fetch(){
        guard let url = URL(string: "http://127.0.0.1:1880/leitura")else {return}
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
            guard let data = data, error == nil else{return}
            
            do {
                let parsed = try JSONDecoder().decode([Consultas].self, from: data)
                
                DispatchQueue.main.async {
                    self?.listConsultas = parsed
                }
            }catch{
                print(error)
            }
        }
        
        task.resume()
    }
    
    func remove(at offsets: IndexSet){
        
        var item : Consultas?
        
        for index in offsets {
            print("Deleted item at index \(index)")
            item = listConsultas[index]
        }
        
        
        
        
        guard let url = URL(string: "http://127.0.0.1:1880/deletar") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do {
            let data = try JSONEncoder().encode(item)
            
            print(item)
            
            request.httpBody = data
        } catch {
            print("Error encoding to JSON: \(error.localizedDescription)")
        }
        
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error deleting resource: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error deleting resource: invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Resource deleted successfully")
            } else {
                print("Error deleting resource: status code \(httpResponse.statusCode)")
            }
        }
        
        task.resume()
        
        listConsultas.remove(atOffsets: offsets)
        
    }
    
    
    func post(_ obj : Consultas){
        
        
        guard let url = URL(string: "http://127.0.0.1:1880/salvar") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Headers must specify that the HTTP request body is JSON-encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(obj)
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            print("Error encoding to JSON: \(error.localizedDescription)")
        }
        
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error to send resource: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error to send resource: invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Resource POST successfully")
            } else {
                print("Error POST resource: status code \(httpResponse.statusCode)")
            }
        }
        
        task.resume()
        
    }
    
    
}

 
