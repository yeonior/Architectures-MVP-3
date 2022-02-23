//
//  Comment.swift
//  Architecture-MVP-3
//
//  Created by Ruslan on 11.02.2022.
//

import Foundation

struct Comment: Decodable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
