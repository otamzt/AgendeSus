//
//  ViewModel.swift
//  TelaHome
//
//  Created by Turma02-10 on 28/02/25.
//

import Foundation
//import FeedKit
 
class ViewModel: NSObject, ObservableObject, XMLParserDelegate {
    @Published var newsItems: [NewsItem] = []
 
    private var currentElement = ""
    private var currentLink: String = ""
    private var currentImageURL: String = ""
    private var isItem = false
 
    func fetchNews() {
        guard let url = URL(string: "https://agenciabrasil.ebc.com.br/rss/saude/feed.xml") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
            }
        }
        task.resume()
    }

    
    // XMLParserDelegate methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "item" {
            isItem = true
            currentLink = ""
            currentImageURL = ""
        }
    }
 
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if isItem {
            switch currentElement {
            case "link":
                currentLink += string
            case "imagem-destaque":
                currentImageURL += string
            default:
                break
            }
        }
    }
 
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let newsItem = NewsItem(link: currentLink, imageURL: currentImageURL)
            newsItems.append(newsItem)
            isItem = false
        }
    }
}
