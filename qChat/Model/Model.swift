//
//  Model.swift
//  qChat
//
//  Created by Highest on 25.09.2024.
//
import UIKit
import Foundation

enum AuthResponse {
    case succes, noVerify, error
}

struct Slides {
    var text: String
    var img: UIImage
}

struct LoginField{
    var email: String
    var password: String
}

struct ResponseCode{
    var code: Int
}

struct CurentUser {
    var id: String
    var email: String
}
