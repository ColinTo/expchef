//
//  RadarSwiftUIView.swift
//  expchef
//
//  Created by Colin To on 2022-04-05.
//

import SwiftUI

enum RayCase: String, CaseIterable {
    case Knife = "Knife Skills"
    case Baking = "Baking"
    case Frying = "Frying"
    case Boiling = "Boiling"
    case Dry = "Dry Preparations"
    case Misc = "Misc"
}

// This scales accordingly
let dimensions = [
    Ray(maxValue:10, rayCase: .Knife),
    Ray(maxValue:10, rayCase: .Baking),
    Ray(maxValue:10, rayCase: .Frying),
    Ray(maxValue:10, rayCase: .Boiling),
    Ray(maxValue:10, rayCase: .Dry),
    Ray(maxValue:10, rayCase: .Misc)
]

// Mock Data
let chartData = [
    DataPoint(Knife: 10, Baking: 3, Frying: 7, Boiling: 4, Dry: 1, Misc:7, graphColor:Color.blue)
]

struct DataPoint:Identifiable{
    var id = UUID()
    var entrys:[RayEntry]
    var graphColor:Color
    
    init(Knife:Double, Baking:Double, Frying:Double, Boiling:Double, Dry:Double, Misc:Double, graphColor:Color){
        self.entrys = [
            RayEntry(rayCase: .Knife, value: Knife),
            RayEntry(rayCase: .Baking, value: Baking),
            RayEntry(rayCase: .Frying, value: Frying),
            RayEntry(rayCase: .Boiling, value: Boiling),
            RayEntry(rayCase: .Dry, value: Dry),
            RayEntry(rayCase: .Misc, value: Misc),
        ]
        self.graphColor = Color.blue
    }
}

struct Ray: Identifiable{
    var id = UUID()
    var name: String
    var maxValue:Double
    var rayCase:RayCase
    init(maxValue:Double, rayCase:RayCase){
        self.rayCase = rayCase
        self.name = rayCase.rawValue
        self.maxValue = maxValue
    }
}

struct RayEntry{
    var rayCase: RayCase
    var value: Double
}

func deg2rad(_ number: CGFloat) -> CGFloat {
    return number * .pi / 180
}

func radAngle_fromFraction(numerator:Int, denominator: Int) -> CGFloat {
    return deg2rad(360 * (CGFloat(numerator)/CGFloat(denominator)))
}

func degAngle_fromFraction(numerator:Int, denominator: Int) -> CGFloat {
    return 360 * (CGFloat(numerator)/CGFloat(denominator))
}

struct RadarSwiftUIView: View {
    
    var MainColor:Color
    var SubtleColor:Color
    var center:CGPoint
    var labelWidth:CGFloat = 70
    var width: CGFloat
    var height:CGFloat
    var quantity_incrementDividers:Int
    var dimensions:[Ray]
    var chartData:[DataPoint]
    
    init(width:CGFloat, height:CGFloat, MainColor:Color, SubtleColor:Color,
         quantity_incrementDividers:Int, dimensions:[Ray], data:[DataPoint]){
        // Width is the size
        self.width = width
        self.height = height
        self.center = CGPoint(x: width/2, y: width/2)
        self.MainColor = MainColor
        self.SubtleColor = SubtleColor
        self.quantity_incrementDividers = quantity_incrementDividers
        self.dimensions = dimensions
        self.chartData = data
        self.frame(maxWidth: width/2, maxHeight: height/2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    
    @State var showLabels = false
    
    var body: some View{
        
        ZStack{
            // Create Main Spokes
            Path { path in
                for i in 0..<self.dimensions.count {
                    let angle = radAngle_fromFraction(numerator: i, denominator: self.dimensions.count)
                    let x = (self.width - (50 + self.labelWidth))/2 * cos(angle)
                    let y = (self.width - (50 + self.labelWidth))/2 * sin(angle)
                    path.move(to: center) // Lifting up pencil, moving it somewhere else, then redrawing
                    path.addLine(to: CGPoint(x: center.x + x, y: center.y + y))
                }
            }
            
            .stroke(self.MainColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            
            // Label - ForEach returns view. For does not
            ForEach(0..<self.dimensions.count){i in
                Text(self.dimensions[i].rayCase.rawValue)
                    .font(.system(size: 10))
                    .foregroundColor(self.SubtleColor)
                    .frame(width:self.labelWidth, height:10)
                    // Flip text after it reaches a certain angle
                    .rotationEffect(.degrees((
                                        degAngle_fromFraction(numerator: i, denominator: self.dimensions.count) > 90 &&
                                        degAngle_fromFraction(numerator: i, denominator: self.dimensions.count) < 270) ? 180 :0))
                    .background(Color.clear)
                    .offset(x: (self.width - (50))/2)
                    // Sets the text rotation to Line with spoke lines
                    .rotationEffect(.radians(Double(radAngle_fromFraction(numerator: i, denominator: self.dimensions.count))))
            }
            // Create Outer Border
            Path { path in
                for i in (0..<self.dimensions.count + 1){
                    let angle = radAngle_fromFraction(numerator: i, denominator: self.dimensions.count)
                    let x = (self.width - (50 + self.labelWidth))/2 * cos(angle)
                    let y = (self.width - (50 + self.labelWidth))/2 * sin(angle)
                    if i == 0 {
                        path.move(to: CGPoint(x: center.x + x, y: center.y + y))
                    }
                    else {
                        path.addLine(to: CGPoint(x: center.x + x, y: center.y + y))
                    }
                }
            }
            .stroke(self.MainColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            // Create incremental Dividers
            ForEach(0..<self.quantity_incrementDividers){j in
                Path { path in
                    for i in (0..<self.dimensions.count + 1) {
                        let angle = radAngle_fromFraction(numerator: i, denominator: self.dimensions.count)
                        let size = ((self.width - (50 + self.labelWidth))/2) * (CGFloat(j + 1)/CGFloat(self.quantity_incrementDividers + 1))
                        let x = size * cos(angle)
                        let y = size * sin(angle)
                        print(size)
                        print(self.width - (50 + self.labelWidth))
                        print("\(x) -- \(y)")
                        if i == 0 {
                            path.move(to: CGPoint(x: self.center.x + x, y: self.center.y + y))
                        }
                        else{
                            path.addLine(to: CGPoint(x: self.center.x + x, y: self.center.y + y))
                        }
                    }
                }
                .stroke(self.SubtleColor, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
            }
            
            // Data Polygons
            ForEach(0..<self.chartData.count){j in
//            ForEach(0..<self.data.count){j in
                // Create Path
                let path = Path { path in
                    for i in (0..<self.dimensions.count + 1){
                        let thisDimension = self.dimensions[i == self.dimensions.count ? 0 : i]
                        let maxValue = thisDimension.maxValue
                        let dataPointValue:Double = {
                            for DataPointRay in self.chartData[j].entrys{
                                if thisDimension.rayCase == DataPointRay.rayCase{
                                    return DataPointRay.value
                                }
                            }
                            return 0
                        }()
                        let angle = radAngle_fromFraction(numerator: i == self.dimensions.count ? 0 : i, denominator: self.dimensions.count)
                        let size = ((self.width - (50 + self.labelWidth))/2) * (CGFloat(dataPointValue)/CGFloat(maxValue))
                        let x = size * cos(angle)
                        let y = size * sin(angle)
                        print(size)
                        print(self.width - (50 + self.labelWidth))
                        print("\(x) -- \(y)")
                        if i == 0{
                            path.move(to: CGPoint(x: self.center.x + x, y: self.center.y + y))
                        }
                        else{
                            path.addLine(to: CGPoint(x: self.center.x + x, y: self.center.y + y))
                        }
                        //Stroke and Fill
//                        return AnyView{
//                            ZStack{
//                                path
//                                    .stroke(self.data[j].color, style: StrokeStyle(lineWidth:1.5, lineCap:.round, lineJoin: .round))
//                                path
//                                    .foregroundColor(self.data[j].color).opacity(0.2)
//                            }
//                        }
                    }
                }
//                return AnyView{
//                    ZStack{
                        path
                            .stroke(self.chartData[j].graphColor, style: StrokeStyle(lineWidth:1.5, lineCap:.round, lineJoin: .round))
                        path
                            .foregroundColor(self.chartData[j].graphColor).opacity(0.2)
//                    }
//                }
//                .stroke(self.SubtleColor, style: StrokeStyle(lineWidth:1.5, lineCap:.round, lineJoin: .round))
//                .foregroundColor(self.SubtleColor).opacity(0.2)
            }
//            Color.black.edgesIgnoringSafeArea(.all)
//            VStack{
//                Text("Skill Chart").font(.system(size:30, weight: .semibold))
//                RadarChartSwiftUIView(width: 370)
//                self.MainColor: Color.init(white: 0.8)
//                self.(width:370, MainColor: Color.init(white: 0.8),
//                               SubtleColor: Color.init(white: 0.6),
//                               )
//            }
        }
        .frame(width:width, height:width)
//        Text("Hello, World")
    }
//    var body: some View {
//        Text("Custom View in VC")
//            .padding()
//            .foregroundColor(.blue)
//            .position(x: 100, y: 50)
//            .frame(width: 200, height: 100)
////            .position(y: 50)
//            .background(Color.yellow)
//    }
}

// For Live Data
//struct RadarSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        RadarSwiftUIView()
//    }
//}
