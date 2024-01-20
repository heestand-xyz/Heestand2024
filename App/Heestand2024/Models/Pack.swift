//
//  Pack.swift
//  Heestand2024
//
//  Created by Heestand, Anton Norman | Anton | GSSD on 2024-01-18.
//

import Foundation

struct Pack: Encodable, Identifiable {
    var id: String { "pack" }
    let size: CGSize
    struct Button: Encodable {
        let detail: Detail
        let frame: CGRect
        let cornerRadius: CGFloat
    }
    let buttons: [Button]
}
