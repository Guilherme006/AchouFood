
import UIKit

final class PlaceDetailFactory {
    static func make(place: Place, coordinator: DeliveryScenesCoordinator) -> UIViewController {
        let view = PlaceDetailView()
        return PlaceDetailViewController(placeModel: place,
                                         placeDetailView: view,
                                         coordinator: coordinator)
    }
}
