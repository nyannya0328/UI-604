//
//  AricShape.swift
//  UI-604
//
//  Created by nyannyan0328 on 2022/07/04.
//

import SwiftUI

struct AricShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
            let midWidth = rect.width / 2
            let width = rect.width
            
            path.move(to: .zero)
            
            path.addCurve(to: CGPoint(x: width, y: 0), control1: CGPoint(x: midWidth, y: -80), control2: CGPoint(x: midWidth, y: -80))
            
            
        }
    }
}

struct AricShape_Previews: PreviewProvider {
    static var previews: some View {
        AricShape()
    }
}
