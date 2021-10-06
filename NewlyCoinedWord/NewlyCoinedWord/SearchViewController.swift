//
//  SearchViewController.swift
//  NewlyCoinedWord
//
//  Created by Woochan Park on 2021/10/04.
//

import UIKit

class SearchViewController: UIViewController {
  
  @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
  
  @IBOutlet weak var searchStackView: UIStackView! {
    didSet {
      searchStackView.layer.borderWidth = 2
      searchStackView.layer.borderColor = UIColor.black.cgColor
      searchStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0)
      
      searchStackView.isLayoutMarginsRelativeArrangement = true
    }
  }
  
  @IBOutlet weak var searchTextField: UITextField!
  
  @IBOutlet var tagButtons: [UIButton]!
  
  @IBOutlet weak var resultLabel: UILabel!
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  // MARK: - IBAction
  
  @IBAction func didTapSearchButton(_ sender: UIButton) {
    
    guard let keyword = searchTextField.text else { fatalError(#function) }
    
    guard let result = fetchSearchResult(with: keyword) else { return }
    
    let randomTags = pickRandomTags()
    applyTagsToButton(tags: randomTags)
    
    tagButtons.forEach {
      $0.isHidden = false
    }
    
    resultLabel.text = result
  }
  
  
  @IBAction func didTapTagButton(_ sender: UIButton) {
    
    let result = fetchSearchResult(with: sender.title(for: .normal))
    
    searchTextField.resignFirstResponder()
    resultLabel.text = result
  }
  
  @IBAction func didTap(_ sender: Any) {
    
    searchTextField.resignFirstResponder()
  }
  

  // MARK: - Custom
  
  private func fetchSearchResult(with keyword: String?) -> String? {
    
    guard let keyword = keyword else { fatalError(#function) }
    
    guard let result = newlyCoinedWordDict[keyword] else {
      
      presentNoResultAlert()
      
      return nil
    }
    
    return result
  }
  
  private func presentNoResultAlert() {
    
    let controller = UIAlertController(title: "검색 결과 없음", message: "다른 키워드로 검색해보세요", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "확인", style: .default, handler: { _ in
      self.searchTextField.text = nil
    })
    
    controller.addAction(okAction)
    
    present(controller, animated: true)
    
  }
  
  /**
    실제로는 네트워크에서 검색 결과와 함께 수신받는 데이터로 대체될 것임
   */
  private func pickRandomTags(for count: Int = 4) -> [String] {
    
    var allCases = newlyCoinedWordDict
    
    var result: [String] = []
    
    while result.count < count {
      
      let pickedOne = String(allCases.keys.randomElement()!)
      
      result.append(pickedOne)
      
      allCases.removeValue(forKey: pickedOne)
    }
    
    return result
  }
  
  private func applyTagsToButton(tags list: [String]) {
    
    print(list.count)
    for (index,tag) in list.enumerated() {
      tagButtons[index].setTitle(tag, for: .normal)
    }
  }

}

extension SearchViewController {
  
  private var newlyCoinedWordDict: [String: String] {
    [
      "재질": "느낌, 부류를 대체하는말",
      "군싹": "군침이 싹도노의 준말",
      "머선129": " 무슨 일이냐의 사투리",
      "whyrano": "왜 이러나의 사투리 '와 이라노'를 영문으로 표현",
      "쫌쫌따리": "아주 조금씩 틈틈이, 엄청 작고 하찮은 양을 애써 모으는 모양",
      "임포": "게임'어몽어스'에 등장하는 무리 사이에 숨은 배신자",
      "억텐": "억지 텐션의 줄임말",
      "스불재": "스스로 불러온 재앙의 줄임말",
      "주불": "주소 불러의 줄임말",
      "레게노": "레전드를 잘못 읽어 생겨난 밈",
      "완내스": "완전 내스타일의 줄임말",
      "혼틈": "혼란을 틈타"
    ]
  }
}
