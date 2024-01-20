//
//  SaveView.swift
//  Heestand2024
//
//  Created by Heestand, Anton Norman | Anton | GSSD on 2024-01-18.
//

import UIKit
import SwiftUI
import UniformTypeIdentifiers

struct SaveView: UIViewControllerRepresentable {
    
    let pack: Pack
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes, .sortedKeys]
        let data = try! encoder.encode(pack)
        let url = Bundle.main.bundleURL.appending(component: "Coordinates.json")
        try! data.write(to: url)
        let picker = UIDocumentPickerViewController(forExporting: [url], asCopy: true)
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
}
