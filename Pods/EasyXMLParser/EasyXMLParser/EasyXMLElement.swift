//
//  EasyXMLElement.swift
//  EasyXMLParser
//
//  Created by Fabien on 10/02/2017.
//  Copyright © 2017 Esgi. All rights reserved.
//

import Foundation


/*
 *  EasyXMLElement est un objet représentant un élément XML
 *  Il a donc : une valeur (value) 
 *  Des élements enfant ou un élément parent
 *  Et un nom
 *
 *  La valeur de l'EasyXMLElement peut être casté de plusieurs manières (float, int, bool et double)
 *  Il peut être parcouru comme un Dictionary
 *
 *  Et dispose de plusieurs méthodes permettant d'obtenir des informations à son sujet :
 *
 *     Méthode pour Récupérer des enfants :
 *         - getNamedChildren           => récupération des enfants ayant un nom précis
 *         - getAllChildren             => récupération de tout les enfants
 *         - getSiblingWithSameName     => récupérations des frères ayant le même nom
 *
 *     Méthodes compter les enfants
 *         - countNamedChildren         => récupération du nombre d'enfant ayant un nom précis
 *         - countAllChildren           => récupération du nombre d'enfants
 *         - countSiblingWithSameName   => récupération du nombre de frères ayant le même nom
 *
 *     Méthode pour utilitaire :
 *         - filter                     => créer une liste d'EasyXMLELement correspondant à un filtre fournis
 *         - addEnfant                  => permet d'ajouter un enfant
 *         - isValid                    => permet de savoir si l'EasyXMLElement est valide
 *
 *     Méthode pour le debug :
 *         - description                => retour d'une description de l'EasyXMLElement en cours (description limitée)
 *         - fullDescription            => retour d'une description complète de l'l'EasyXMLElement en cours
 */
public class EasyXMLElement : NSObject{
    
    private var enfants:[EasyXMLElement] = [EasyXMLElement]()   // les sous éléments de l'élément
    public var parent:EasyXMLElement?                           // le parent de l'élement
    public var value:String=""                                  // la valeur de l'élément
    public var name:String                                      // le nom de l'élément
    
    //permet d'accéder à value sous un autre format
    public var intValue:Int { get{ return Int(self.value) ?? 0 } }
    public var doubleValue:Double { get{ return Double(self.value) ?? 0 } }
    public var floatValue:Float { get{ return Float(self.value) ?? 0 } }
    public var boolValue:Bool { get{ return ((self.value == "True") || (self.intValue == 1) || (self.value == "true") || (self.value == "Yes") || (self.value == "yes")) } }
    
    //name par défaut d'un élément (si cette valeur est maintenu l'élément est incorrect)
    static public let noName:String = ""
    
    init(name: String) {
        self.name = name
    }
    
    
    /*
     *  Cette méthode permet de parcourir un EasyXMLElement Comme une collection.
     *  Il permet de récupérer le premier enfant ayant le même nom que nous (ou un element vide le cas échéant).
     *  Etant donné que le subscript n'est pas avoir de thrown on retourne un élément sans nom ("donc invalide")
     *     si on ne trouve pas d'enfant.
     */
    public subscript(key: String) -> EasyXMLElement {
        get {
            let dernierEnfant = EasyXMLElement(name: EasyXMLElement.noName)

            for enfant in enfants {
                if (enfant.name == key) {
                    return enfant
                }
            }
            
            return dernierEnfant
        }
    }


    /*
     *  Permet de récupérer les enfants avec un nom précis
     */
    public func getNamedChildren(name:String) -> [EasyXMLElement] {
        var listeFiltre = [EasyXMLElement]()
        
        for enfant in enfants {
            if (name == enfant.name) {
                listeFiltre.append(enfant)
            }
        }
        return listeFiltre
    }
    
    /*
     *  Permet de récupérer la liste de tout les enfants de l'élément en cours
     */
    public func getAllChildren() -> [EasyXMLElement] {
        return self.enfants
    }
    
    
    
    /*
     *  Permet de connaitre la liste des d'éléments du même nom que nous de notre parent
     *  (permet de récupérer la liste des"frères" ayant le même nom)
     */
    public func getSiblingWithSameName() -> [EasyXMLElement] {
        if let papa = self.parent {
            return papa.getNamedChildren(name: self.name)
        }
        return [EasyXMLElement]()
    }
    
    
    /*
     * Cette méthode permet de connaitre le nombre d'élément du même nom que nous de notre parent
     * (permet de connaitre le nombre de "frères" ayant le même nom)
     */
    public func countSiblingWithSameName() -> Int {
        if let papa = self.parent {
            return papa.getNamedChildren(name: self.name).count
        }
        return 0
    }
    
    /*
     *  Permet de récupérer les enfants avec un nom précis
     */
    public func countNamedChildren(name:String) -> Int {
        var nbEnfant = 0
        
        for enfant in enfants {
            if (name == enfant.name) {
                nbEnfant+=1
            }
        }
        return nbEnfant
    }
    
    /*
     * Cette méthode permet de connaitre le nombre d'enfant de l'élément en cours
     */
    public func countAllChildren() -> Int {
        return self.enfants.count
    }
    

    
    /*
     *  Permet de récupérer une liste d'élément correspondant à un filtre fournis par l'utilisateur
     *  Le filtre est un Dictionary représenté de la manière suivante :
     *
     *  ["utilisateur" : [ "nom": "",
     *                     "mail": ""]]
     */
    public func filter(filtre: [String:Any]) -> [EasyXMLElement] {
        //Création d'un array d'EasyXMLElement
        var tempoEnfantFiltre = [EasyXMLElement]()

        //si le nom de l'élément en cours est une des clé du filtre, on s'ajoute dans tempoEnfantFiltre
        if let filtreValue = filtre[self.name] {
            //duplication de self et ajout
            let tempoElement = EasyXMLElement(name: self.name)
            tempoElement.value = self.value

            //si la valeur de notre filtre est un Dictionary (donc un sous filtre), on ajoute au tempoElement les enfants "filtré"
            if (filtreValue is Dictionary<String, Any>){
                for enfant in enfants {

                    let tempoEnfantElementList = enfant.filter(filtre: filtreValue as! [String : Any])
                    //boucle à réaliser ici pour setter le parent
                    tempoElement.enfants.append(contentsOf: tempoEnfantElementList)
                }
            }
            tempoEnfantFiltre.append(tempoElement)
        
        }

        //si notre tempoEnfantFiltre est vide on filtre chaque enfant avec le filtre reçu
        if (tempoEnfantFiltre.isEmpty) {
            for enfant in self.enfants {
                
                let tempoEnfantFiltre2 =  enfant.filter(filtre: filtre)
                tempoEnfantFiltre.append(contentsOf: tempoEnfantFiltre2)
            }
        }
        
        //retour de la liste
        return tempoEnfantFiltre;

        
    }

    /*
     *  Cette méthode permet d'ajouter un enfant à l'EasyXMLElement courant
     *  L'enfant ajouté aura pour parent self
     */
    public func addEnfant(element:EasyXMLElement) {
        element.parent = self
        enfants.append(element)
    }
    
    /*
     *  Permet de savoir si l'élément en cours est correct (en gros : est ce qu'il a un nom)
     */
    public func isValid() -> Bool {
        return (self.name != EasyXMLElement.noName)
    }

    /*
     *  Description du EasyXMLElement
     */
    override public var description: String{
        return "Je suis \(self.name) j'ai : \(self.enfants.count) enfant(s), ma valeur est : \"\(value)\""
    }
    
    
    /*
     *  Description Complète du EasyXMLElement
     *  Cette méthode permet d'obtenir une description longue de l'élément en cours avec une description de ses enfants
     */
    public func fullDescription() -> String {
        
        var tempoRetour = "Je suis \(self.name), ma valeur est : \"\(value)\", j'ai : \(self.enfants.count) enfant(s) : \n"
        
        for enfant in enfants {
            //on détermine la taille de value
            let sizeValue = enfant.value.distance(from: enfant.value.startIndex, to: enfant.value.endIndex)
            
            //on crée une chaine temporaire qui n dépasse pas les 80 caractères (histoire d'être lisible)
            let tempoEnfantShortValue = enfant.value.substring(to: enfant.value.index( enfant.value.startIndex, offsetBy: ((sizeValue  > 60) ? 60 : sizeValue)))
            
            //ajout du nom de l'enfant
            tempoRetour.append("  \(enfant.name) : \n")
            
            //ajout de la valeur de l'enfant
            if (enfant.value.characters.count > tempoEnfantShortValue.characters.count) {
                tempoRetour.append("    valeur : \"\(tempoEnfantShortValue)\" ...\n")
            } else {
                tempoRetour.append("    valeur : \"\(enfant.value )\"\n")
            }
            
            //nombre d'enfants de l'enfant
            tempoRetour.append("    nombre d'enfants : \(enfant.enfants.count) \n")
        }
        
        return tempoRetour
    }
}
