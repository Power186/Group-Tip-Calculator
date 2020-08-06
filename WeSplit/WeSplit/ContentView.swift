//
//  ContentView.swift
//  WeSplit
//
//  Created by Scott on 8/6/20.
//  Copyright © 2020 Scott. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UISegmentedControl.appearance().backgroundColor = .systemTeal
    }
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        
        let totalAmount = orderAmount + tipValue
        
        return totalAmount
    }
    
    var body: some View {
        
        NavigationView {
                
            Form {
                Section {
                    HStack {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Button("Submit") {
                         UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }.padding(4).border(Color.blue, width: 2).cornerRadius(5)
                    }
                    
                    Picker("Number of people:", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .foregroundColor(.black)
                }
                
                Section(header: Text("Tip amount")) {
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }.font(.title).foregroundColor(Color.white)
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")").foregroundColor(Color.black)
                }.font(.title).foregroundColor(.white)
                
                Section(header: Text("Total amount")) {
                    Text("\(totalAmount, specifier: "%.2f")").foregroundColor(Color.black)
                }.font(.title).foregroundColor(.white)
                
                }
            .navigationBarTitle("WeSplit")
            .background(Image("money")).opacity(0.7)
            .foregroundColor(.black)
            .font(Font.title.weight(.thin))
            
        }
        .accentColor(.primary)
        .environment(\.colorScheme, .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
