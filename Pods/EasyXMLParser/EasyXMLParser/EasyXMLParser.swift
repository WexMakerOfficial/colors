//
//  EasyXMLParser.swift
//  EasyXMLParser
//
//  Created by Fabien on 06/02/2017.
//  Copyright © 2017 com.4amoc1.groupe10. All rights reserved.
//

import UIKit

/*
 *  EasyXMLParser est un objet qui permet d'analyser un donnée XML
 *
 *  Il dispose de deux constructeurs pouvant recevoir soit un Data d'un contenu XML soit une URL d'un contenu XML
 *
 *  La méthode parse permet d'analyser le flux XML via le EasyXMLParserDelegate et de retourner un EasyXMLElement
 *  (plus d'information dans EasyXMLParserDelegate et EasyXMLElement)
 */
public class EasyXMLParser : NSObject {
    
    
    private let parserXML: XMLParser                                        //la donnée à parser avec le constructeur withData
    private let delegate:EasyXMLParserDelegate = EasyXMLParserDelegate()    //le delegate qui sera utilisé avec notre parseur
    private var resultat:EasyXMLElement?
    

    /*
     * Constructeur de l'objet version DATA
     */
    public  init(withData: Data) {
        self.parserXML = XMLParser(data: withData)
    }
    
    
    /*
     * Constructeur de l'objet version URL
     */
    public  init(withUrl: URL) {
        if let parser = XMLParser(contentsOf: withUrl) {
            self.parserXML = parser
        } else {
            self.parserXML = XMLParser()
        }
    }
    
    
    /*
     * Méthode qui va setter le delegate de notre parser
     * Le parser analysera ensuite notre contenu XML. Le résultat du parser sera stockée dans resultat
     */
    public func parse() -> EasyXMLElement {

        parserXML.delegate = delegate
        parserXML.parse()
        resultat = delegate.items
        
        return resultat!
    }

}
