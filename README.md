# Countries - Walmart Coding Exercise

## Challenge

1. Fetch a list of countries in JSON format from this URL: https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json

2. Display all the countries in a UITableView ordered by the position they appear in the JSON. In each table cell, show the country's "name", "region", "code" and "capital" in this format:

<pre>
  ---------------------------------------
  |                                     |
  | "name", "region"             "code" |
  |                                     |
  | "capital"                           |
  |                                     |
  ---------------------------------------
</pre>

  For exampple:

<pre>
  ---------------------------------------
  |                                     |
  | United States of America, NA     US |
  |                                     |
  | Washington, D.C.                    |
  |                                     |
  ---------------------------------------
  |                                     |
  | Uruguay, SA                      UY |
  |                                     |
  | Montevideo                          |
  |                                     |
  ---------------------------------------
  </pre>
    
The user should be able to scroll thru the entire list of countries.

3. Use a UISearchController to enable filtering by "name" or "capital" as the user types each character of their search.

The implementation should be robust (i.e., handle errors and edge cases), support Dynamic Type, support iPhone and iPad, and support device rotation.

Limit yourself to 60 minutes. We don't expect you to finish. The goal is to write high-quality code for the portion you choose to implement, not the number of features implemented.


## Implementation

Although the challenge specifically requests using UISearchController, more and more projects are switching to SwiftUI rather than using UIKit and Storyboards.

I have chosen to show that I am keeping up with new features and the latest technologies for iOS by writing this challenge using SwiftUI equivalents of UIKit structures.

NOTE: By default, the search field does not display in portrait mode for most iOS devices.  To make the search view appear, simply pull down on the list using a "refresh" motion, and then the search field will appear.  Then, you may enter the search text.  I don't know if this is a SwiftUI issue, or would also occur with a UISearchController.

On device, when a software keyboard appears, you may "unshift" the first character to enter a lowercase character as your first letter of the search string.  Otherwise the default keyboard configuration always capitalizes the first letter, for example, when you use a real keyboard.  This is a device-wide user setting, and overrides any programmatic settings.  It may be changed by going to Settings -> General -> Keyboards and disabling Auto-Capitalization.


## The project

### countries.json

This file contains the data received from the specified URL: https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json

It was decided to keep the data local, and not grab the file from the network.  If grabbing it from the network is required, then the following code would be used.

<code>

    enum ReadDataError: Error {
        case badResponseCode
    }

    @MainActor
    public func countryData() async throws -> Data? {
        do {
            let url = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
            request.httpMethod = "GET"
        
            let (data, resp) = try await URLSession.shared.data(for: request)
            if (resp as? HTTPURLResponse)?.statusCode == 200 {
                return data
            }
            else {
                throw ReadDataError.badResponseCode
            }
        }
        catch {
            return nil
        }
    }
    
</code>

instead of using...

<code>

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
    
</code>


### Country.swift

This module contains all the appropriate structures needed to decode the given Country data

Comments identify additions for functionality or protocol adherence required for the structures.


### Loader.swift

This module contains the code to grab and decode the JSON data into an array of Country items to be displayed in the list.

We could just return the result of the decode, but to keep internal data separate from data read from elsewhere, we explicitly copy each County entry to the source of truth used to display the list of countries.


### ContentView.swift

This module is the main SwiftUI view, in the "default" name for simplicity.  It loads the data upin initialization for the Loader instance, and displays it in a list that is searchable in the same construct as UISearchController but native to SwiftUI.

Using the modifier `.navigationViewStyle(.stack)` insures that we use the full screen instead of a potential split-screen view on some devices or iPads.

After the implementation was done, a perceived "improvement" was to add `'lowercased()` to both the searchText and the country name and capital to do a case-insensitive search.  This allows for finding "Lon" in "London" as well as "lon" in something like "Miquelon".


### CountryView.swift

This module contains the view for each list element, making it much easier to left and right justify the fields as shown in the description with only a few lines of code.

An improvement to this view might be to change the font size of the specific fields such as making the country, region and code a larger font than the capital city to make the fields stand out in the list view.

For example, `.font(.system(size: 18))` or `.font(.system(size: 15))`.  A custom font, or using the pre-determined text types such as `.title` or `.body` and font weight such as `.bold` can also be specified if desired.


## Time

I probalby spent about 90 minutes on this, including some testing to get the decode working correctly, and finding a solution to a split-screen view for the NavigationView.

Actual coding time, not counting research was closer to 45 minutes.

And, of course, it took me about a half-hour or more to write up this README document :-)


