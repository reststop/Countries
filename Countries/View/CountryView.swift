//
//  CountryView.swift
//  Countries
//
//  Created by carl on 8/11/22.
//

import SwiftUI

struct CountryView: View {
    var country: Country

    var body: some View {
        VStack {
            HStack {
                Text("\(country.name), \(country.region)")
                Spacer()
                Text(country.code)
            }
            HStack {
                Text(country.capital)
                Spacer()
            }
        }
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(country: Country("Name", "Region", "CD", "Capital"))
    }
}
