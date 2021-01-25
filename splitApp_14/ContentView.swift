//
//  ContentView.swift
//  splitApp_14
//
//  Created by emm on 23/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}



//////////   Home   \\\\\\

struct Home: View {
    
    // Total Amount ...
    @State var bill: CGFloat = 750
    @State var payers = [
        Payer( image: "animoji2", name: "Andy", bgColor: Color("animojiColor2")),
        Payer( image: "animoji1", name: "Cody", bgColor: Color("animojiColor1")),
        Payer( image: "animoji3", name: "Steve", bgColor: Color("animojiColor3"))
    ]
    
    // Temp Offset...
//    @State var offset: CGFloat = 0
    @State var pay = false
    
    
    var body: some View {
        
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack{
                
                HStack {
                    Button(action: {}, label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(Color("card"))
                            .padding()
                            .background(Color.black.opacity(0.25))
                            .cornerRadius(15)
                    })
                    
                    Spacer()
                }
                .padding()
                
                // bill card view...
                VStack(spacing: 15) {
                    Button(action: {}, label: {
                        Text("Recipt")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color("bg"))
                            .cornerRadius(12)
                    })
                    
                    // Dotted Lines...
                    
                    Line()
                        .stroke(Color.black, style: StrokeStyle(lineWidth: 1, lineCap: .butt, lineJoin: .miter, dash: [10]))
                        .frame(height: 1)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8, content: {
                            Text("Title")
                                .font(.caption)
                            Text("Team Dinner")
                                .font(.title2)
                                .fontWeight(.heavy)
                        })
                        .foregroundColor(Color("bg"))
                        .frame(maxWidth: .infinity)
                        
                        
                        VStack(alignment: .leading, spacing: 8, content: {
                            Text("Total Bill")
                                .font(.caption)
                            Text("$\(Int(bill))")
                                .font(.title2)
                                .fontWeight(.heavy)
                        })
                        .foregroundColor(Color("bg"))
                        .frame(maxWidth: .infinity)
                        .padding(.top, 10)
                        
                    }
                    
                    
                    // Memoji View...
                    
                    VStack {
                        HStack(spacing: -15) {
                            ForEach(payers) { payer in
                                Image(payer.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .padding(2)
                                    .background(payer.bgColor)
                                    .clipShape(Circle())
                            }
                        }
                        
                        Text("Spliting With")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("bg"))
                    .cornerRadius(25)
                    
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("card").clipShape(BillShape()).cornerRadius(25))
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                ForEach(payers.indices) {index in
                    PriceView(payer: $payers[index], totalAmount: bill)
                }
                
                
                Spacer(minLength: 25)
                
                // Pay Button...
                HStack {
                    HStack(spacing: 0) {
                        ForEach(1...6, id: \.self) { index in
                            Image(systemName: "chevron.right")
                                .font(.system(size: 20, weight: .heavy))
                                .foregroundColor(Color.white.opacity(Double(index) * 0.06))
                        }
                    }
                    .padding(.leading, 45)
                    
                    Spacer()
                    
                    Button(action: {pay.toggle()}, label: {
                        Text("Confirm Split")
                            .fontWeight(.bold)
                            .foregroundColor(Color("card"))
                            .padding(.horizontal, 25)
                            .padding(.vertical)
                            .background(Color("bg"))
                            .clipShape(Capsule())
                    })
                }
                .padding()
                .background(Color.black.opacity(0.25))
                .clipShape(Capsule())
                .padding(.horizontal)
            }
        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))

        // Alert View...
        .alert(isPresented: $pay, content: {
            Alert(title: Text("Alert"), message: Text("Confirm To Split Pay"), primaryButton: .default(Text("Pay"), action: {
                // Do Some code Here...
            }), secondaryButton: .destructive(Text("Cancel"), action:  {
                // do some code here ....
            }))
        })
    }
}

// Price split view...
struct PriceView: View {
    @Binding var payer: Payer
    var totalAmount: CGFloat
    
    var body: some View {
        VStack(spacing: 15) {
            
            
            // Custon Slider...
            HStack {
                Text(payer.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text(getPrice())
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
            }
          
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center),
                   content: {
                    Capsule()
                        .fill(Color.primary.opacity(0.25))
                        .frame(height: 30)
                    
                    Capsule()
                        .fill(payer.bgColor)
                        .frame(width: payer.offset + 20, height: 30)
                    
                    // Dots...
                    
                    HStack(spacing: (UIScreen.main.bounds.width - 100) / 12) {
                        ForEach(0..<12, id: \.self) {index in
                            Circle()
                                .fill(Color.white)
                                .frame(width: index % 4 == 0 ? 7 : 4, height: index % 4 == 0 ? 7 : 4)
                        }
                    }
                    .padding(.leading)
                    
                    
                   // Button Sliders...
                    Image(payer.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding(4)
                        .background(payer.bgColor)
                        .clipShape(Circle())
//                    Circle()
//
//                        .fill(payer.bgColor)
//                        .frame(width: 35, height: 35)
//                        .background(Circle().stroke(Color.white, lineWidth: 5))
                        .offset(x: payer.offset)
                        .gesture(DragGesture().onChanged({ (value) in
                            // Padding Horizontal...
                            
                            //Padding Horizontal = 30
                            // Circle radius = 20
                            // Total 50
                            if value.location.x >= 20 && value.location.x <= UIScreen.main.bounds.width - 50 {
                                // Circle radius = 20
                                payer.offset = value.location.x - 20
                            }
                        }))
                   })
        }
        .padding()
    }
    
    
    // Calculating Price...
    func getPrice()-> String {
        let percent = payer.offset / (UIScreen.main.bounds.width - 70)
        let amount = percent * (totalAmount / 3)
        return String(format: "%.2f", amount)
    }
}

// Line Shape...

struct Line: Shape {
    func path(in rect: CGRect)-> Path {
        return Path{path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
        }
    }
}

// Custom Bill Card Shape...
struct BillShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            path.move(to: CGPoint(x: 0, y: 80))
            path.addArc(center: CGPoint(x: 0, y: 80), radius: 20, startAngle: .init(degrees: -90), endAngle: .init(degrees: 90), clockwise: false)
            
            path.move(to: CGPoint(x: rect.width, y: 80))
            path.addArc(center: CGPoint(x: rect.width, y: 80), radius: 20, startAngle: .init(degrees: 90), endAngle: .init(degrees: -90), clockwise: false)
        }
    }
}


// SAmple Model and data ...

struct Payer: Identifiable {
    var id = UUID().uuidString
    var image: String
    var name: String
    var bgColor: Color
    
    // Offset For Custom Progress View...
    var offset: CGFloat = 0
}

var payers = [
    Payer( image: "animoji2", name: "Andy", bgColor: Color("animojiColor2")),
    Payer( image: "animoji1", name: "Cody", bgColor: Color("animojiColor1")),
    Payer( image: "animoji2", name: "Steve", bgColor: Color("animojiColor3"))
]
