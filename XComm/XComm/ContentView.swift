//
//  ContentView.swift
//  XComm
//
//  Created by Vivek Chahal on 28/01/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var temperature = 0.0
    
    @State private var degree = ["Celsius", "Fahrenheit", "Kelvin"]
    @State private var degree_default = "Celsius"
    @State private var degree_default1 = "Fahrenheit"
    @State private var conversion = 0.0
    
    func convertTemperature() {
        switch (degree_default, degree_default1) {
        case ("Celsius", "Fahrenheit"):
            conversion = temperature * 9.0 / 5.0 + 32.0
        case ("Celsius", "Kelvin"):
            conversion = temperature + 273.15
        case ("Fahrenheit", "Celsius"):
            conversion = (temperature - 32.0) * 5.0 / 9.0
        case ("Fahrenheit", "Kelvin"):
            conversion = (temperature - 32.0) * 5.0 / 9.0 + 273.15
        case ("Kelvin", "Celsius"):
            conversion = temperature - 273.15
        case ("Kelvin", "Fahrenheit"):
            conversion = (temperature - 273.15) * 9.0 / 5.0 + 32.0
        default:
            conversion = temperature
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack {
                        // picking entered degree
                        Picker("Select Degree", selection: $degree_default){
                            ForEach(degree, id: \.self){
                                Text($0)
                            }
                        }
                        // taking input of temprature
                        TextField("Enter temperature", value: $temperature, format: .number)
                            .keyboardType(.decimalPad)
                            .onChange(of: temperature, perform: { value in
                                convertTemperature()
                            })
                    }
                }
                Section {
                    Text("Change Temperature into: ")
                        .font(.headline)
                    // picking input for the display output degree
                    Picker("Select Degree", selection: $degree_default1){
                        ForEach(degree, id: \.self){
                            Text($0)
                        }
                    }
                    .onChange(of: degree_default1, perform: { value in
                        convertTemperature()
                    })
                }
                //displaying temprature
                Text("Temperature is : \(conversion) \(degree_default1)")
                    .navigationTitle("TEMPERATURE CONVERSION")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
#Preview {
    ContentView()
}
