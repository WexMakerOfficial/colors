//
//  RSSXMLParser.swift
//  Exemple_RSS
//
//  Created by Fabien on 17/12/2016.
//  Copyright © 2016 PetitGrigri. All rights reserved.
//

import UIKit

/*
 *  EasyXMLPareser Delegate
 *
 *  Ce dernier est appelé par un XMLParser initialisé dans le EasyXMLParser
 */
public class EasyXMLParserDelegate: NSObject, XMLParserDelegate {
    
    var items = EasyXMLElement(name: "root")    //va contenir la collection correspodant au xml
    
    var elementEnCours:EasyXMLElement           //l'élément en cours

    var tempoRead:String = ""                   //une variable contenant la valeur d'un élément en cours de lecture

    
    /*
     *  Constructeur, il permettra uniquement d'initialiser elementEnCours avec items (l'EasyXMLElement)
     */
    override init() {
        elementEnCours = items
    }
    
    /*
     *  Cette méthode est appellée lorsqu'elle rencontre un nouvel élément XML.
     *  Dans tout les cas on mémorisera l'élément en cours de "lecture"
     */
     public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){

        //On mémoriser pour utiliser l'élément en cours comme parrent
        let tempoELementEnCours = elementEnCours

        let nouveauElement = EasyXMLElement(name: elementName)
        tempoELementEnCours.addEnfant(element: nouveauElement)
        elementEnCours = nouveauElement
        
    }


    /*
     *  Cette méthode est appellée lorsqu'elle rencontre la fin d'un élément XML
     *  Elle permet de vider la mémorisation de l'élément en cours et de ne pas le remplir avec des données fausses
     */
     public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        
        //nettoyage de tempoRead (suppression des tabulations et retours à la ligne)
        tempoRead = String(tempoRead.characters.filter { !"\n\t\r".characters.contains($0) })
        tempoRead = tempoRead.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        //modification de la valeur de la valeur de l'élément en cours (qu'on vient de terminer de lire)
        elementEnCours.value = tempoRead

        //on indique maintenant que l'élément en cours est le parent de l'élément en cours
        elementEnCours = elementEnCours.parent!
        
        //réinitialisation de tempoRead (qui servira pour lire les prochains éléments XML)
        self.tempoRead = ""

    }

    
    /*
     *  Cette méthode est appellée lorsqu'elle lit le contenu d'une balise XML
     *  Juste avant, le parser didStartElement aura été appellé
     */
    public func parser(_ parser: XMLParser, foundCharacters string: String){
        //print("foundCharacters : \(string)")
        
        self.tempoRead.append(string)
    }
    
    
    /*
     *  Cette méthode est appellée lorsqu'elle lit le contenu d'une balise XML avec des données CDATA
     *  Juste avant, le parser didStartElement aura été appellé
     */
    public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data){
        
        
        if let tempo = String.init(data: CDATABlock, encoding: .utf8) {
            //print("foundCDATA \(tempo)")
            self.tempoRead.append(tempo)
        } else {
            //print("foundCDATA VIDE")
        }
    }
}
