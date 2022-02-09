import UIKit
import Moya

class ComicsViewModel {
    
    let provider = MoyaProvider<Marvel>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    var characterId: Int = 0
    var currentOffset: Int = 0
    var comics: [Comic] = []
    var totalComics: Int = 0
    
    // MARK: - Initializers
    
    func loadMoreComics(completion: @escaping (Bool) -> ()) {
        provider.request(.comics(offset: currentOffset, id: characterId)) {
            [weak self] result in guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    let comics = try response.map(MarvelResponse<Comic>.self).data.results
                    let total = try response.map(MarvelResponse<Comic>.self).data.total
                    self.totalComics = total
                    self.currentOffset += 20
                    self.comics.append(contentsOf: comics)
                    completion(false)
                } catch {
                    completion(true)
                }
            case .failure:
                completion(true)
            }
        }
    }
}

