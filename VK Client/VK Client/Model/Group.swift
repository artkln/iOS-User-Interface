//
//  Group.swift
//  VK Client
//
//  Created by Артём Калинин on 12.03.2021.
//

import UIKit

class Group: Equatable {
    var name: String
    var image: UIImage
    
    init(name: String = "", image: UIImage = UIImage()) {
        self.name = name
        self.image = image
    }
    
    static func ==(lhs: Group, rhs: Group) -> Bool {
        return lhs.name == rhs.name && lhs.image == rhs.image
    }
}

extension Group {
    static func getData() -> [Group] {
        return [Group(name: "MovieBlog", image: UIImage(named: "MovieBlog")!),
                Group(name: "Marvel/DC", image: UIImage(named: "MarvelDC")!),
                Group(name: "NR", image: UIImage(named: "NR")!),
                Group(name: "Лентач", image: UIImage(named: "Лентач")!),
                Group(name: "StarWars", image: UIImage(named: "Star Wars")!),
                Group(name: "Reddit", image: UIImage(named: "Reddit")!),
                Group(name: "9GAG", image: UIImage(named: "9GAG")!),
                Group(name: "NASA", image: UIImage(named: "NASA")!),
                Group(name: "Хабр", image: UIImage(named: "Хабр")!),
                Group(name: "Медуза", image: UIImage(named: "Медуза")!),
                Group(name: "N + 1", image: UIImage(named: "N + 1")!),
                Group(name: "Animal Memes", image: UIImage(named: "Animal Memes")!)]
    }
}
