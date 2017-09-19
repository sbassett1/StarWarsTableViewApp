//
//  SWCharacter.swift
//  StarWarsIndexApp
//
//  Created by Mac on 9/12/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation
import UIKit

class SWCharacter{
    var name:String
    var birthYear:String
    var height:String?
    var mass:String?
    var hairColor:String?
    var skinColor:String?
    var eyeColor:String?
    var gender:String?
    var homeworld:String?
    init?(dict:[String:Any]){
        guard let name = dict["name"] as? String else {return nil}
        guard let birthYear = dict["birth_year"] as? String else {return nil}
        guard let height = dict["height"] as? String else {return nil}
        guard let mass = dict["mass"] as? String else {return nil}
        guard let hairColor = dict["hair_color"] as? String else {return nil}
        guard let skinColor = dict["skin_color"] as? String else {return nil}
        guard let eyeColor = dict["eye_color"] as? String else {return nil}
        guard let gender = dict["gender"] as? String else {return nil}
        guard let homeworld = dict["homeworld"] as? String else {return nil}
        self.name = name
        self.birthYear = birthYear
        self.height = height
        self.mass = mass
        self.hairColor = hairColor
        self.skinColor = skinColor
        self.eyeColor = eyeColor
        self.gender = gender
        self.homeworld = homeworld
    }
}

class HomeworldModel{
    var name:String?
    var rotation:String?
    var orbital:String?
    var diameter:String?
    var climate:String?
    var gravity:String?
    var terrain:String?
    var surface:String?
    var population:String?
    init?(dict:[String:Any]){
        guard let name = dict["name"] as? String else {return nil}
        guard let rotation = dict["rotation_period"] as? String else {return nil}
        guard let orbital = dict["orbital_period"] as? String else {return nil}
        guard let diameter = dict["diameter"] as? String else {return nil}
        guard let climate = dict["climate"] as? String else {return nil}
        guard let gravity = dict["gravity"] as? String else {return nil}
        guard let terrain = dict["terrain"] as? String else {return nil}
        guard let surface = dict["surface"] as? String else {return nil}
        guard let population = dict["population"] as? String else {return nil}
        self.name = name
        self.rotation = rotation
        self.orbital = orbital
        self.diameter = diameter
        self.climate = climate
        self.gravity = gravity
        self.terrain = terrain
        self.surface = surface
        self.population = population
    }
}




















