//
//  Character.swift
//  Networking
//
//  Created by Anikin Ilya on 22.09.2022.
//

import Foundation

struct Location: Decodable {
    let name: String?
}

struct Character: Decodable {
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let location: Location?
    let image: String?
}
