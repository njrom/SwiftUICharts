//
//  PieChart.swift
//  Shared
//
//  Created by Nick Romano on 5/16/21.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
public struct PieChart: View {
    
    private var slices = [PieSlice]()
    
    private func calculateSlices(from inputValues: [(color: Color, value: Double)]) -> [PieSlice] {
        // 1
        let sumOfAllValues = inputValues.reduce(0) { $0 + $1.value }
        guard sumOfAllValues > 0 else {
            return []
        }
        let degreeForOneValue = 360.0 / sumOfAllValues
        // 2
        var slices = [PieSlice]()
        var currentStartAngle = -90.0
        inputValues.forEach { inputValue in
            let endAngle = degreeForOneValue * inputValue.value +
                           currentStartAngle
            slices.append(
                     PieSlice(
                         start: Angle(degrees: currentStartAngle),
                         end: Angle(degrees: endAngle),
                         color: inputValue.color
                     )
            )
            currentStartAngle = endAngle
        }
        return slices
    }
    
    init(_ values: [(Color, Double)]) {
        slices = calculateSlices(from: values)
    }
    
    public var body: some View {
        GeometryReader { reader in
            let halfWidth = (reader.size.width / 2)
            let halfHeight = (reader.size.height / 2)
            let radius = min(halfWidth, halfHeight)
            let center = CGPoint(x: halfWidth, y: halfHeight)
            ZStack(alignment: .center) {
                ForEach(slices, id: \.self) { slice in
                    Path { path in
                        path.move(to: center)
                        path.addArc(center: center,
                                    radius: radius,
                                    startAngle: slice.start,
                                    endAngle: slice.end,
                                    clockwise: false
                        )
                    }
                    .fill(slice.color)
                }
            }
        }
    }
    
    
    
}

@available(iOS 13.0, macOS 10.15, *)
private struct PieSlice : Hashable {
    var start: Angle
    var end: Angle
    var color: Color
}

@available(iOS 13.0, macOS 10.15, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PieChart([(.red, 20),(.blue, 30), (.green, 10), (.orange, 40)])
    }
}

