//
//  User.swift
//  VK Client
//
//  Created by Артём Калинин on 12.03.2021.
//

import UIKit

class User: Equatable {
    var name: String
    var profileImage: UIImage
    var photos: [UIImage]
    
    init(name: String, profileImage: UIImage, photos: [UIImage]) {
        self.name = name
        self.profileImage = profileImage
        self.photos = photos
    }
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name && lhs.profileImage == rhs.profileImage && lhs.photos == rhs.photos
    }
}

extension User {
    
    static func getData() -> [User] {
        let friend1 = User(name: "Артём Калинин", profileImage: UIImage(named: "Артём")!, photos: [UIImage(named: "1.1")!,
                                                                                                  UIImage(named: "1.2")!,
                                                                                                  UIImage(named: "1.3")!,
                                                                                                  UIImage(named: "1.4")!,
                                                                                                  UIImage(named: "1.5")!,
                                                                                                  UIImage(named: "1.6")!
        ])
        let friend2 = User(name: "Михаил Матюшкин", profileImage: UIImage(named: "Михаил М")!, photos: [UIImage(named: "2.1")!,
                                                                                                    UIImage(named: "2.2")!,
                                                                                                    UIImage(named: "2.3")!,
                                                                                                    UIImage(named: "2.4")!,
                                                                                                    UIImage(named: "2.5")!,
                                                                                                    UIImage(named: "2.6")!])
        let friend3 = User(name: "Кирилл Корнющенков", profileImage: UIImage(named: "Кирилл")!, photos: [UIImage(named: "3.1")!,
                                                                                                        UIImage(named: "3.2")!,
                                                                                                        UIImage(named: "3.3")!,
                                                                                                        UIImage(named: "3.4")!,
                                                                                                        UIImage(named: "3.5")!,
                                                                                                        UIImage(named: "3.6")!])
        let friend4 = User(name: "Сергей Волченков", profileImage: UIImage(named: "Сергей")!, photos: [UIImage(named: "4.1")!,
                                                                                                  UIImage(named: "4.1")!,
                                                                                                  UIImage(named: "4.2")!,
                                                                                                  UIImage(named: "4.3")!,
                                                                                                  UIImage(named: "4.4")!,
                                                                                                  UIImage(named: "4.5")!,
                                                                                                  UIImage(named: "4.6")!])
        let friend5 = User(name: "Богдан Титров", profileImage: UIImage(named: "Богдан")!, photos: [UIImage(named: "5.1")!,
                                                                                                    UIImage(named: "5.2")!,
                                                                                                    UIImage(named: "5.3")!,
                                                                                                    UIImage(named: "5.4")!,
                                                                                                    UIImage(named: "5.5")!,
                                                                                                    UIImage(named: "5.6")!])
        let friend6 = User(name: "Никита Кузнецов", profileImage: UIImage(named: "Никита")!, photos: [UIImage(named: "6.1")!,
                                                                                                    UIImage(named: "6.2")!,
                                                                                                    UIImage(named: "6.3")!,
                                                                                                    UIImage(named: "6.4")!,
                                                                                                    UIImage(named: "6.5")!,
                                                                                                    UIImage(named: "6.6")!])
        let friend7 = User(name: "Олег Малинин", profileImage: UIImage(named: "Олег")!, photos: [UIImage(named: "7.1")!,
                                                                                                UIImage(named: "7.2")!,
                                                                                                UIImage(named: "7.3")!,
                                                                                                UIImage(named: "7.4")!,
                                                                                                UIImage(named: "7.5")!,
                                                                                                UIImage(named: "7.6")!])
        let friend8 = User(name: "Дмитрий Чернявский", profileImage: UIImage(named: "Дмитрий Ч")!, photos: [UIImage(named: "8.1")!,
                                                                                                        UIImage(named: "8.2")!,
                                                                                                        UIImage(named: "8.3")!,
                                                                                                        UIImage(named: "8.4")!,
                                                                                                        UIImage(named: "8.5")!,
                                                                                                        UIImage(named: "8.6")!])
        let friend9 = User(name: "Дмитрий Федюков", profileImage: UIImage(named: "Дмитрий Ф")!, photos: [UIImage(named: "9.1")!,
                                                                                                        UIImage(named: "9.2")!,
                                                                                                        UIImage(named: "9.3")!,
                                                                                                        UIImage(named: "9.4")!,
                                                                                                        UIImage(named: "9.5")!,
                                                                                                        UIImage(named: "9.6")!])
        let friend10 = User(name: "Милана Попова", profileImage: UIImage(named: "Милана")!, photos: [UIImage(named: "10.1")!,
                                                                                                    UIImage(named: "10.2")!,
                                                                                                    UIImage(named: "10.3")!,
                                                                                                    UIImage(named: "10.4")!,
                                                                                                    UIImage(named: "10.5")!,
                                                                                                    UIImage(named: "10.6")!])
        let friend11 = User(name: "Михаил Еремеев", profileImage: UIImage(named: "Михаил Е")!, photos: [UIImage(named: "11.1")!,
                                                                                                    UIImage(named: "11.2")!,
                                                                                                    UIImage(named: "11.3")!,
                                                                                                    UIImage(named: "11.4")!,
                                                                                                    UIImage(named: "11.5")!,
                                                                                                    UIImage(named: "11.6")!])
        let friend12 = User(name: "Игорь Димитров", profileImage: UIImage(named: "Игорь")!, photos: [UIImage(named: "12.1")!,
                                                                                                    UIImage(named: "12.2")!,
                                                                                                    UIImage(named: "12.3")!,
                                                                                                    UIImage(named: "12.4")!,
                                                                                                    UIImage(named: "12.5")!,
                                                                                                    UIImage(named: "12.6")!])
        let friend13 = User(name: "Роман Баранецкий", profileImage: UIImage(named: "Роман")!, photos: [UIImage(named: "13.1")!,
                                                                                                    UIImage(named: "13.2")!,
                                                                                                    UIImage(named: "13.3")!,
                                                                                                    UIImage(named: "13.4")!,
                                                                                                    UIImage(named: "13.5")!,
                                                                                                    UIImage(named: "13.6")!])
        let friend14 = User(name: "Максим Мовчан", profileImage: UIImage(named: "Максим")!, photos: [UIImage(named: "14.1")!,
                                                                                                    UIImage(named: "14.2")!,
                                                                                                    UIImage(named: "14.3")!,
                                                                                                    UIImage(named: "14.4")!,
                                                                                                    UIImage(named: "14.5")!,
                                                                                                    UIImage(named: "14.6")!])
        let friend15 = User(name: "Антон Яровой", profileImage: UIImage(named: "Антон")!, photos: [UIImage(named: "15.1")!,
                                                                                                    UIImage(named: "15.2")!,
                                                                                                    UIImage(named: "15.3")!,
                                                                                                    UIImage(named: "15.4")!,
                                                                                                    UIImage(named: "15.5")!,
                                                                                                    UIImage(named: "15.6")!])
        
        return [friend1, friend2, friend3, friend4, friend5, friend6, friend7, friend8, friend9, friend10, friend11, friend12, friend13, friend14, friend15]
    }
}
