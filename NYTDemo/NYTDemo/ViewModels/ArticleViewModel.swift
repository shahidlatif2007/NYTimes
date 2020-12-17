//
//  ArticleViewModel.swift
//  NYTDemo
//
//  Created by Shahid Latif on 17/12/2020.
//  Copyright © 2020 Shahid Latif. All rights reserved.
//



class ArticleViewModel {
    var articles: Box<[Article]>
    var articleRepository: ArticleRepository
    
    let timePeriod:[TimePeriod] = [.Day,.Week,.Month]
    var apiError:Box<NetworkError>? = Box(NetworkError())
    
    init(repo : ArticleRepository = ArticleRepository()) {
        articles = Box([Article]())
        articleRepository = ArticleRepository()
    }
}

extension ArticleViewModel {
    
    func setTimePeriod(timePeriod: TimePeriod) {
        articleRepository.timePeriod = timePeriod
    }
    
    func currentTimePeriod() -> TimePeriod {
        return articleRepository.timePeriod
    }
    
    func filterBy() ->  String {
        return articleRepository.timePeriod.name
    }
    
    func shouldSendRequest(targetTimePeriod: TimePeriod) -> Bool {
        return targetTimePeriod != articleRepository.timePeriod
    }
    
    func fetchArticles() {
        self.articleRepository.fetchArticles(complete: {[weak self] (response) in
            if response.status == "OK" {
                self?.articles.value = response.results
            }else {
                let error = NetworkError()
                error.statusCode = 400
                self?.apiError?.value = error
            }
        }) { (networkError) in
            if let error = networkError {
                self.apiError?.value = error
            }
            
        }
    }
}
