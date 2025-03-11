//
//  WebView.swift
//  TelaHome
//
//  Created by Turma02-10 on 28/02/25.
//

import SwiftUI
import WebKit
import Foundation

struct WebView: UIViewRepresentable {
    // 1
    @Binding var news : NewsItem

    
    // 2
    func makeUIView(context: Context) -> WKWebView {

        return WKWebView()
    }
    
    // 3
    func updateUIView(_ webView: WKWebView, context: Context) {
        var urlString = news.link

        // A expressão regular vai encontrar a URL e remover qualquer parte extra
        let pattern = "https://agenciabrasil\\.ebc\\.com\\.br/[^\n]+"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])

        // Encontrar o intervalo da correspondência na string original
        let range = NSRange(location: 0, length: urlString.utf16.count)

        if let match = regex.firstMatch(in: urlString, options: [], range: range) {
            // Limpar a URL mantendo a parte válida
            let cleanedString = (urlString as NSString).substring(with: match.range).replacingOccurrences(of: "%0A%20%20%20%20", with: "")
            
            urlString = cleanedString
        }
        
        let request = URLRequest(url: URL(string: urlString)!)
       
        
        webView.load(request)
    }
}
