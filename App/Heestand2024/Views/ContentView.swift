//
//  ContentView.swift
//  Heestand2024
//
//  Created by Heestand, Anton Norman | Anton | GSSD on 2024-01-17.
//

import SwiftUI

struct ContentView: View {
    
    let isMobile: Bool
    
    @State private var size: CGSize = .zero
    @State private var ornamentSize: CGSize = .zero

    struct Area {
        var detail: Detail
        let cornerRadius: CGFloat
        var offset: CGPoint
        var frame: CGRect
        var finalFrame: CGRect {
            CGRect(x: offset.x + frame.minX,
                   y: offset.y + frame.minY,
                   width: frame.width,
                   height: frame.height)
        }
        static let empty = Area(detail: .empty, cornerRadius: 0.0, offset: .zero, frame: .zero)
    }
    @State private var areas: [Area] = []
    func area(url: String) -> Binding<Area> {
        Binding<Area> {
            areas.first(where: { $0.detail.url == url }) ?? {
                var area: Area = .empty
                area.detail.url = url
                return area
            }()
        } set: { newArea, _ in
            if let index = areas.firstIndex(where: { $0.detail.url == url }) {
                areas[index] = newArea
            } else {
                areas.append(newArea)
            }
        }
    }
    
    @State private var showGrid: Bool = false
    @State private var savePack: Pack?
    
    var body: some View {
        ZStack {
            if isMobile {
                mainMobileBody
            } else {
                mainBody
            }
            if showGrid {
                gridBody
            }
        }
        .coordinateSpace(name: "main")
        .read(size: $size)
        .sheet(item: $savePack) { pack in
            SaveView(pack: pack)
        }
        .onTapGesture(count: 2) {
            savePack = Pack(size: size, buttons: areas.map({ area in
                Pack.Button(detail: area.detail,
                            frame: area.finalFrame,
                            cornerRadius: area.cornerRadius)
            }))
        }
        .onTapGesture {
            showGrid.toggle()
        }
    }
    
    private var mainBody: some View {
        NavigationSplitView {
            
            ScrollView {
                
                VStack(spacing: 16) {
                    
                    aboutBody
                    
                    linksBody
                    
                    technologiesBody

                    sloganBody
                }
                .padding(16)
            }
            .navigationTitle("Anton Heestand")
        } detail: {
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    appsBody
                    
                    packagesBody
                }
                .padding(16)
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    
                    Text("Apps & Packages")
                        .font(.title)
                }
            }
            .ornament(attachmentAnchor: .scene(.bottom)) {
                ornamentBody
            }
        }
    }
    
    private var mainMobileBody: some View {
        
        VStack(spacing: 0.0) {
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("Anton Heestand")
                        .font(.largeTitle)
                    
                    aboutBody
                    
                    linksBody
                    
                    sloganBody
                }
                .padding(16)
                .padding(.top, 16)
            }
            .background {
                Rectangle()
                    .foregroundStyle(.background)
            }

            ScrollView {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    appsBody
                    
                    packagesBody
                }
                .padding(16)
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    
                    Text("Apps & Packages")
                        .font(.title)
                }
            }
            .ornament(attachmentAnchor: .scene(.bottom)) {
                ornamentBody
            }
        }
    }
    
    private var aboutBody: some View {
        container(title: "About", sidebar: true) {
            Text("Hi, I'm Anton from Stockholm, living in Tokyo. I studied at Hyper Island and now I'm building apps for creators on iOS, macOS and visionOS.")
        }
    }
    
    private var linksBody: some View {
        container(sidebar: true) {
            Grid {
                GridRow {
                    link(title: "Resume",
                         url: "http://heestand.xyz/CV%20Anton%20Heestand.pdf",
                         icon: Image(systemName: "doc.plaintext"))
                    link(title: "Email",
                         url: "mailto:anton.heestand@gmail.com",
                         icon: Image(systemName: "envelope.fill"))
                }
                GridRow {
                    link(title: "LinkedIn",
                         url: "https://www.linkedin.com/in/antonheestand/",
                         icon: Image(systemName: "network"))
                    link(title: "GitHub",
                         url: "https://github.com/heestand-xyz",
                         icon: Image(systemName: "command"))
                }
            }
        }
    }
    
    private var technologiesBody: some View {
        container(title: "Technologies", sidebar: true) {
            Grid {
                GridRow {
                    label {
                        Text("SwiftUI")
                    }
                    label {
                        Text("Metal")
                    }
                }
                GridRow {
                    label {
                        Text("AVKit")
                    }
                    label {
                        Text("RealityKit")
                    }
                }
                GridRow {
                    label {
                        Text("UIKit")
                    }
                    label {
                        Text("AppKit")
                    }
                }
                GridRow {
                    label {
                        Text("Combine")
                    }
                    label {
                        Text("Concurrency")
                    }
                }
            }
        }
    }
    
    private var sloganBody: some View {
        Text("Learning by doing")
            .font(.caption)
            .opacity(0.5)
            .frame(maxWidth: .infinity)
    }
    
    private var appsBody: some View {
        bigContainer {
            Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                GridRow {
                    product(title: "Render",
                            info: "Video composer with layers on a timeline",
                            url: "https://apps.apple.com/us/app/render-video-composer/id6444799341",
                            icon: Image("App Icon/Render"))
                    if !isMobile {
                        product(title: "Circles",
                                info: "Live graphics node editor",
                                url: "https://apps.apple.com/se/app/circles-node-editor/id1582312198",
                                icon: Image("App Icon/Circles"))
                        product(title: "Data OSC",
                                info: "Send device data over WiFi",
                                url: "https://apps.apple.com/app/data-osc/id6447833736",
                                icon: Image("App Icon/Data OSC"))
                    }
                }
                GridRow {
                    if !isMobile {
                        product(title: "HDR Camera",
                                info: "Multi exposure effect camera app",
                                url: "https://apps.apple.com/us/app/hdr-effect-camera/id1580227677",
                                icon: Image("App Icon/HDR Camera"))
                        product(title: "Magnet Crop",
                                info: "Crop screenshots magnetically",
                                url: "https://apps.apple.com/us/app/magnet-crop/id1547800025",
                                icon: Image("App Icon/Magnet Crop"))
                    }
                    product(title: "Jockey OSC",
                            info: "Remote control UI builder",
                            url: "https://apps.apple.com/us/app/jockey-osc/id1553621603",
                            icon: Image("App Icon/Jockey OSC"))
                }
                if !isMobile {
                    GridRow {
                        product(title: "uCal",
                                info: "Infinitely scrollable calendar",
                                url: "https://apps.apple.com/us/app/ucal-calendar/id1615292683",
                                icon: Image("App Icon/uCal"))
                        product(title: "Channel Mix",
                                info: "Mixing color channels with multiple images",
                                url: "https://apps.apple.com/us/app/channel-mix/id1640290579",
                                icon: Image("App Icon/Channel Mix"))
                        product(title: "Clean OSC",
                                info: "Remote control list builder",
                                url: "https://apps.apple.com/us/app/clean-osc-with-files/id1550516814",
                                icon: Image("App Icon/Clean OSC"))
                    }
                }
            }
        }
    }
    
    private var packagesBody: some View {
        bigContainer {
            Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                GridRow {
                    product(title: "Async Graphics",
                            info: "2D & 3D graphics in Swift & Metal",
                            url: "https://github.com/heestand-xyz/AsyncGraphics",
                            icon: Image("Package/AsyncGraphics"))
                    if !isMobile {
                        product(title: "MetalUI",
                                info: "Effects in SwiftUI, powered by Metal",
                                url: "https://github.com/heestand-xyz/MetalUI",
                                icon: Image("Package/MetalUI"))
                    }
                }
            }
        }
    }
    
    private var ornamentBody: some View {
        HStack(spacing: 0.0) {
            ornamentLink(title: "heestand",
                         url: "https://threads.net/@heestand",
                         icon: Image("Social/Threads"))
            Divider()
            ornamentLink(title: "heestand_xyz",
                         url: "https://x.com/heestand_xyz",
                         icon: Image("Social/X"))
        }
        .padding(.horizontal, 8)
        .glassBackgroundEffect()
        .read(size: $ornamentSize)
    }
    
    private var gridBody: some View {
        
        ZStack(alignment: .topLeading) {
            Color.clear
            ForEach(areas, id: \.detail.url) { area in
                Color.clear
                    .border(.red)
                    .frame(width: area.finalFrame.width, 
                           height: area.finalFrame.height)
                    .offset(x: area.finalFrame.minX,
                            y: area.finalFrame.minY)
            }
        }
        .border(.red)
        .frame(width: size.width, height: size.height)
    }
    
    private func container<Content: View>(
        title: String? = nil,
        sidebar: Bool = false,
        cornerRadius: CGFloat? = nil,
        @ViewBuilder _ content: () -> Content
    ) -> some View {
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .font(.headline)
            }
            content()
        }
        .padding()
        .frame(maxWidth: .infinity,
               alignment: .leading)
        .background {
            if sidebar {
                RoundedRectangle(cornerRadius: 16)
                    .opacity(0.15)
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.background)
            }
        }
    }
    
    private func bigContainer<Content: View>(
        @ViewBuilder _ content: () -> Content
    ) -> some View {
        content()
            .frame(maxWidth: .infinity,
                   alignment: .leading)
    }
    
    @ViewBuilder
    private func product(
        title: String,
        info: String,
        url: String,
        icon: Image
    ) -> some View {
        let cornerRadius = 24.0
        HStack(alignment: .top) {
            icon
                .resizable()
                .frame(width: 64, height: 64)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(info)
                    .opacity(0.5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .top)
        .background {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(.background)
        }
        .read(frame: Binding<CGRect>(get: {
            area(url: url).wrappedValue.frame
        }, set: { newFrame in
            area(url: url).wrappedValue.frame = newFrame
        }), in: .named("main"))
        .onAppear {
            let detail = Detail(title: title, url: url, info: info)
            area(url: url).wrappedValue = Area(
               detail: detail,
               cornerRadius: cornerRadius,
               offset: .zero,
               frame: area(url: url).wrappedValue.frame
            )
        }
    }
    
    @ViewBuilder
    private func link(
        title: String,
        url: String,
        icon: Image
    ) -> some View {
        let cornerRadius = 12.0
        HStack {
            icon
            Spacer(minLength: 0.0)
            Text(title)
            Spacer(minLength: 0.0)
        }
        .frame(maxHeight: .infinity)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background {
            RoundedRectangle(cornerRadius: cornerRadius)
                .opacity(0.2)
        }
        .read(frame: Binding<CGRect>(get: {
            area(url: url).wrappedValue.frame
        }, set: { newFrame in
            area(url: url).wrappedValue.frame = newFrame
        }), in: .named("main"))
        .onAppear {
            let detail = Detail(title: title, url: url, info: nil)
            area(url: url).wrappedValue = Area(
                detail: detail,
                cornerRadius: cornerRadius,
                offset: .zero,
                frame: area(url: url).wrappedValue.frame
             )
        }
    }

    @ViewBuilder
    private func ornamentLink(
        title: String,
        url: String,
        icon: Image
    ) -> some View {
        let offset = CGPoint(x: size.width / 2 - ornamentSize.width / 2,
                             y: size.height - ornamentSize.height / 2 + 5)
        let cornerRadius = 20.0
        HStack {
            icon
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
            Text(title)
                .opacity(0.5)
        }
        .padding(16)
        .read(frame: Binding<CGRect>(get: {
            area(url: url).wrappedValue.frame
        }, set: { newFrame in
            area(url: url).wrappedValue.frame = newFrame
        }), in: .named("main"))
        .onChange(of: offset) { _, newOffset in
            area(url: url).wrappedValue.offset = newOffset
        }
        .onAppear {
            let detail = Detail(title: title, url: url, info: nil)
            area(url: url).wrappedValue = Area(
                detail: detail,
                cornerRadius: cornerRadius,
                offset: offset,
                frame: area(url: url).wrappedValue.frame
            )
        }
    }
    
    private func label<Content: View>(
        _ content: () -> Content
    ) -> some View {
        content()
            .opacity(0.75)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
    }
}

#Preview(windowStyle: .automatic) {
    ContentView(isMobile: false)
}
