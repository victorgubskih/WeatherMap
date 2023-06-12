import MapKit
import Foundation


class WeatherAnnotation: NSObject, MKAnnotation, Codable {
    
    enum CodingKeys: String, CodingKey {
        case longitude
        case latitude
        case title
        case subtitle
    }
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let longitude = try values.decode(CLLocationDegrees.self, forKey: .longitude)
        let latitude = try values.decode(CLLocationDegrees.self, forKey: .latitude)
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.title = try values.decodeIfPresent(String.self, forKey: .title)
        self.subtitle = try values.decodeIfPresent(String.self, forKey: .subtitle)
    }
    
    func encode(to encoder: Encoder) throws {
        var contaner = encoder.container(keyedBy: CodingKeys.self)
        
        try contaner.encode(coordinate.longitude, forKey: .longitude)
        try contaner.encode(coordinate.latitude, forKey: .latitude)
        try contaner.encodeIfPresent(title, forKey: .title)
        try contaner.encodeIfPresent(subtitle, forKey: .subtitle)
    }
}


