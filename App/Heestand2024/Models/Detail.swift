//
//  Detail.swift
//  Heestand2024
//
//  Created by Heestand, Anton Norman | Anton | GSSD on 2024-01-19.
//

import Foundation

struct Detail: Encodable {
    let title: String
    var url: String
    let info: String?
}

extension Detail {
    static let empty = Detail(title: "", url: "", info: nil)
}
