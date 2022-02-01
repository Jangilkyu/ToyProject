//
//  MainViewController.swift
//  Covid19
//
//  Created by 장일규 on 2022/01/30.
//

import Foundation
import UIKit
import Charts
import Alamofire

class MainViewController: UIViewController {
    
    var cityName: [String] = []
    var dataEntries: [BarChartDataEntry] = []
    
    // == 국내 총 누적 확진자 ==
    let domConfirmedCase: UILabel = {
        let domConfirmedCase = UILabel()
        domConfirmedCase.text = "국내 총 누적 확진자"
        domConfirmedCase.font = UIFont.boldSystemFont(ofSize: 18)
        domConfirmedCase.textColor = .black
        
        return domConfirmedCase
    }()
    
    let domConfirmedCaseCnt: UILabel = {
        let domConfirmedCaseCnt = UILabel()
        domConfirmedCaseCnt.text = "Label"
        domConfirmedCaseCnt.font = UIFont.boldSystemFont(ofSize: 18)
        domConfirmedCaseCnt.textColor = .black
        
        return domConfirmedCaseCnt
    }()
    
    let domConfirmedCaseStackView: UIStackView = {
        let domConfirmedCaseStackView = UIStackView()
        domConfirmedCaseStackView.axis = .vertical
        domConfirmedCaseStackView.alignment = .center
        domConfirmedCaseStackView.spacing = 20
        return domConfirmedCaseStackView
    }()
    
    // === 국내 신규 확진자 ==
    let domNewConfirmedCase: UILabel = {
        let domNewConfirmedCase = UILabel()
        domNewConfirmedCase.text = "국내 신규 확진자"
        domNewConfirmedCase.font = UIFont.boldSystemFont(ofSize: 18)
        domNewConfirmedCase.textColor = .black
        
        return domNewConfirmedCase
    }()
    
    let domNewConfirmedCaseCnt: UILabel = {
        let domNewConfirmedCaseCnt = UILabel()
        domNewConfirmedCaseCnt.text = "Label"
        domNewConfirmedCaseCnt.font = UIFont.boldSystemFont(ofSize: 18)
        domNewConfirmedCaseCnt.textColor = .black
        
        return domNewConfirmedCaseCnt
    }()
    
    let domNewConfirmedCaseStackView: UIStackView = {
        let domNewConfirmedCaseStackView = UIStackView()
        domNewConfirmedCaseStackView.axis = .vertical
        domNewConfirmedCaseStackView.alignment = .center
        domNewConfirmedCaseStackView.spacing = 20
        
        return domNewConfirmedCaseStackView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
//        stackView.backgroundColor = .blue
        stackView.alignment = .center
        
        return stackView
    }()
    
    let barChartView: BarChartView = {
        let barChartView = BarChartView()
//        barChartView.backgroundColor = .systemPink
        return barChartView
    }()
    
    
    // ======
    override func viewDidLoad() {
        view.backgroundColor = .white
        setup()
        setConfigureBarChart()

        
        self.fetchCovidOverview { [weak self] result in
            guard let self = self else { return }
            switch result {
                case let .success(result):
//                    debugPrint("success \(result)")
                self.configureStackView(koreaCovidOverview: result.korea)
                let covidOverviewList = self.makeCovidOverviewList(cityCovidOverview: result)
                self.configureBarChartView(covidOverviewList: covidOverviewList)
                case let .failure(error):
                    debugPrint("error \(error)")
            }
        }
    }
    
    func setup() {
        addViews()
        setConstraints()
    }
    
    func addViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(domConfirmedCaseStackView)
        stackView.addArrangedSubview(domNewConfirmedCaseStackView)

//        view.addSubview(domConfirmedCaseStackView)
        domConfirmedCaseStackView.addArrangedSubview(domConfirmedCase)
        domConfirmedCaseStackView.addArrangedSubview(domConfirmedCaseCnt)
        
//        view.addSubview(domNewConfirmedCaseStackView)
        domNewConfirmedCaseStackView.addArrangedSubview(domNewConfirmedCase)
        domNewConfirmedCaseStackView.addArrangedSubview(domNewConfirmedCaseCnt)
        
        view.addSubview(barChartView)
    }
    
    func setConstraints() {
        domConfirmedCaseStackViewConstraints()
        domNewConfirmedCaseStackViewConstratins()
        stackViewConstratins()
        barChartViewConstraints()
    }
    
    func domConfirmedCaseStackViewConstraints() {
        domConfirmedCaseStackView.translatesAutoresizingMaskIntoConstraints = false
//        domConfirmedCaseStackView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func domNewConfirmedCaseStackViewConstratins() {
        domNewConfirmedCaseStackView.translatesAutoresizingMaskIntoConstraints = false
    }
        
    func stackViewConstratins() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    }
    
    func barChartViewConstraints() {
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        barChartView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        barChartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        barChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        barChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func setConfigureBarChart() {
        self.barChartView.delegate = self
    }
    
    func fetchCovidOverview(complectionHandler: @escaping (Result<CityCovidOverview, Error>) -> Void
    ) {
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey" : "x3n9CFfQqM7vVicHlTgbz86kNSoPEpysj"
        ]
        
        AF.request(url, method: .get, parameters: param).responseData {
            response in
                switch response.result {
                    case let .success(data):
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(CityCovidOverview.self, from: data)
                            complectionHandler(.success(result))
                        }catch {
                            complectionHandler(.failure(error))
                        }
                    case let .failure(error):
                        complectionHandler(.failure(error))
                    }
        }
    }
    
    func configureStackView(koreaCovidOverview: CovidOverview) {
        self.domConfirmedCaseCnt.text = "\(koreaCovidOverview.totalCase)명"
        self.domNewConfirmedCaseCnt.text = "\(koreaCovidOverview.newCase)명"
    }
    
    func makeCovidOverviewList(
        cityCovidOverview: CityCovidOverview
    ) -> [CovidOverview] {
        return [
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.daegu,
            cityCovidOverview.incheon,
            cityCovidOverview.gwangju,
            cityCovidOverview.daejeon,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
            cityCovidOverview.jeju
        ]
    }
    
    func configureBarChartView(covidOverviewList: [CovidOverview]) {
//        debugPrint(covidOverviewList)

        let entries = covidOverviewList.enumerated().compactMap({
            [weak self] (index: Int, overview: CovidOverview) -> BarChartDataEntry in
            guard let self = self else { return BarChartDataEntry() }
            
            cityName.append(overview.countryName)
            
            return BarChartDataEntry(x: Double(index), y: self.removeFormatString(string: overview.newCase), data: overview)
//            return BarChartDataEntry(x: Double(index), y: self.removeFormatString(string: overview.newCase))
        })
        
        debugPrint(entries)
        
        barChartView.animate(yAxisDuration: 2.0) // 차트 애니메이션
        barChartView.rightAxis.enabled = false // 오른쪽 레이블 없애기
        barChartView.xAxis.labelPosition = .bottom // X축 레이블 위치 조정
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: cityName)
        barChartView.xAxis.setLabelCount(cityName.count, force: false)
        barChartView.doubleTapToZoomEnabled = false // 줌 안되게
        barChartView.leftAxis.axisMinimum = 0 // 미니멈
        
        let chartDataSet = BarChartDataSet(entries: entries, label: "코로나 확진자")
        self.barChartView.data = BarChartData(dataSet: chartDataSet)
        chartDataSet.colors = [.systemPink]
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData

        
    }
    
    func removeFormatString(string: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)?.doubleValue ?? 0
    }
    
}

extension MainViewController:
    ChartViewDelegate {
    
    func chartValueSelected(
        _ chartView: ChartViewBase,
        entry: ChartDataEntry,
        highlight: Highlight) {
            let covidDetailViewController = CovidDetailViewController()
            guard let covidOverview = entry.data as? CovidOverview else {
                return
            }
            
            covidDetailViewController.covidOverview = covidOverview
            
            self.navigationController?.pushViewController(covidDetailViewController, animated: true)
    }
    
}
