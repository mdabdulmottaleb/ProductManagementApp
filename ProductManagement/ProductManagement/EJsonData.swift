
import SwiftUI

struct WelcomeElement: Codable {
    
        var product_name: String
        var brand_name: String
        var price: Int
        var address: Address
        var discription: String
        var date: String
        var time: String
        var image: String
    
}
struct Address: Codable {
  
    var state: String
    var city: String
}
