//
//  Loader.swift
//  Countries
//
//  Created by carl on 8/11/22.
//

import Foundation

class Loader : ObservableObject {
    @Published var countryList: [Country] = []

    init() {
        let data = countryData()
        decode(data)
    }

    public func countryData() -> Data? {
        do {
            let json = Bundle.main.url(forResource: "countries" as String?, withExtension: "json")
            let data = try Data(contentsOf: json!)
            return data
        }
        catch {
            print(error)
        }
        return nil
    }

    public func decode(_ data: Data?) {
        countryList = []
        guard let data = data else { return }
        do {
            // decode entire result
            let response = try JSONDecoder().decode([Country].self, from: data)

            if response.count > 0 {
                // for each returned country, add to list
                for country in response {
                    countryList.append(country)
                }
            }
        }
        catch {
            print(error)
        }
    }


}
