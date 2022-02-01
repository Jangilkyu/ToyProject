//
//  CityCovidOverview.swift
//  Covid19
//
//  Created by 장일규 on 2022/01/31.
//

import Foundation

// 지역
struct CityCovidOverview: Codable {
    let korea: CovidOverview
    let seoul: CovidOverview
    let busan: CovidOverview
    let daegu: CovidOverview
    let incheon: CovidOverview
    let gwangju: CovidOverview
    let daejeon: CovidOverview
    let ulsan: CovidOverview
    let sejong: CovidOverview
    let gyeonggi: CovidOverview
    let gangwon: CovidOverview
    let chungbuk: CovidOverview
    let chungnam: CovidOverview
    let jeonbuk: CovidOverview
    let jeonnam: CovidOverview
    let gyeongbuk: CovidOverview
    let gyeongnam: CovidOverview
    let jeju: CovidOverview
}

// 시도별 발생동향
struct CovidOverview: Codable {
    let countryName: String // 시도명
    let newCase: String // 신규 확진자 수
    let totalCase: String // 확진환자 수
    let recovered: String // 완치자 수
    let death: String // 사망자
    let percentage: String // 발생률
    let newCcase: String // 전일대비증감 - 해외 유입
    let newFcase: String // 전일대비증감 - 지역 발생
}


