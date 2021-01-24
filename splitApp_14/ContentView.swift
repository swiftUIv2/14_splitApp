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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//////////   Home   \\\\\\

struct Home: View {
    
    // Total Amount ...
    @State var bill = 750
    @State var payers = [
        Payer( image: "animoji2", name: "Andy", bgColor: Color("animojiColor2")),
        Payer( image: "animoji1", name: "Cody", bgColor: Color("animojiColor1")),
        Payer( image: "animoji3", name: "Steve", bgColor: Color("animojiColor3"))
    ]
    
    
    var body: some View {
        
        
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
                        Text("$\(bill)")
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
            .background(Color("card"))
            .cornerRadius(25)
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
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
