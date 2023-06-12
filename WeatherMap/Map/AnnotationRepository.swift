import Foundation
import MapKit

protocol AnnotationDelegate {
    func didAdd(annotation: MKAnnotation)
    func didDelete(annotation: MKAnnotation)
    func didLoad(annotations: [MKAnnotation])
}

class AnnotationRepository {
    private var annotations: [WeatherAnnotation]
    var delegate: AnnotationDelegate
    
    init(delegate: AnnotationDelegate) {
        self.annotations = []
        self.delegate = delegate
    }
    
    func loadAnnotations() {
        readAnnotations()
        delegate.didLoad(annotations: self.annotations)
    }
    
    func addAnnotation(title: String, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        guard annotations.firstIndex(where: { $0.coordinate.latitude == coordinate.latitude && $0.coordinate.longitude == coordinate.longitude }) == nil else { return }
        let annotation = WeatherAnnotation(coordinate: coordinate)
        annotation.title = title
        annotation.subtitle = subtitle
       
        annotations.append(annotation)
        saveAnnotations()
        delegate.didAdd(annotation: annotation)
    }
    
    func delete(annotation: MKAnnotation) {
        guard let index = annotations.firstIndex(where: { $0.coordinate.latitude == annotation.coordinate.latitude && $0.coordinate.longitude == annotation.coordinate.longitude }) else { return }
        annotations.remove(at: index)
        saveAnnotations()
        delegate.didDelete(annotation: annotation)
    }
}

extension AnnotationRepository {
    private func saveAnnotations() {
        let fileName = "WeatherAnnotation.json"
        let directoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
        let fileURL = directoryURL.appendingPathComponent(fileName)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: directoryURL.path) {
            try? fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
        }
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(annotations) {
            try? data.write(to: fileURL, options: .atomic)
        }
    }
    
    private func readAnnotations() {
        let fileName = "WeatherAnnotation.json"
        let directoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
        let fileURL = directoryURL.appendingPathComponent(fileName)
        let fileManager = FileManager.default
        if let data = fileManager.contents(atPath: fileURL.path) {
            let decoder = JSONDecoder()
            self.annotations = (try? decoder.decode([WeatherAnnotation].self, from: data)) ?? []
        }
    }
}
