# NewlyCoinedWord 프로젝트 (신조어)
<br />

<img src="/Resources/ezgif-1-b0634dfebde6.gif" width="50%">

<br />
<br />

# 1단계

✅  iOS Versioin, Device Orientation 설정

✅  AppIcon 적용 → 다양한 해상도 이미지를 얻기 위해 [이 링크](https://appiconmaker.co/Home/Index/0a4f6d5a-3de0-4781-b115-2dc343b87f5e) 사용

✅  LaunchScreen 적용

→ 제약 설정

→ 지정 시간(3초) 동안 보여주기

✅  화면 UI 구성

- 스택뷰 ( TextField + PaddingView + Button)
    - PaddingView 와 Button 에 고정 Width 제약을 주었다. (텍스트필드는 화면 크기에 따라 유동적인 길이를 가짐)
    - LayoutMargins 적용하기
    
    ```swift
    searchStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0)
    
    // 이 코드가 없으면 적용이 안됨..........
    searchStackView.isLayoutMarginsRelativeArrangement = true
    ```
    
- 🔥 버튼 Title 길이에 따라 버튼 너비가 **유동적**으로 변하게끔 구현
- Background Image
<br /><br />


# 2단계

✅  뷰객체 Outlet 연결 , Outlet Collection 사용하였다.

✅   UIButton 클래스를 상속한`TagButton` 클래스 구현 ( init 커스텀, 관련 속성 과 인터페이스 캡술화 )

```swift
class TagButton: UIButton {
  
  private let customDefinedWidthPadding: CGFloat = 15
  
  override var intrinsicContentSize: CGSize {
    
    let defaultSize = super.intrinsicContentSize
    
    let width = defaultSize.width + (customDefinedWidthPadding * 2)
    
    let height = defaultSize.height
    
    return CGSize(width: width, height: height)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    self.isHidden = true
    applyRoundDesign(to: self)
  }
  
  private func applyRoundDesign(to view: UIView) {
    
    view.layer.cornerRadius = view.frame.height / 3
    view.layer.borderWidth = 2
    view.layer.borderColor = UIColor.black.cgColor
  }
}
```

✅  Constraint 적용
<br /><br />


# 3단계

✅  탭 제스쳐를 적용하여 키보드가 올라와있을 때 다른 곳을 탭하면 키보드를 내려준다.

→ TapGestureRecognizer 의 Action 을 연결, `resginFirstResponder()` 로 구현

→ 이 때, 뷰 대신 화면 전체를 가리고 있었던 imageView 에 탭 제스처를 추가하여 제스처가 반응을 하지 않는 현상을 해결하느라 시간을 좀 썼다.
<br />

## 💡 완전 대박 깨달은 점

그런데 내가 실제로 탭한 것은 분명 루트 뷰가 아니라 그위를 덮고 있는 이미지 뷰였을 텐데 왜 터치가 무시 되었을까....? 라고 생각하니 `.isUserInteratcionEnabled` 속성이 떠올랐다. 이 속성을 키니 탭제스처가 이미지 뷰에 추가되어도 잘 동작을 했다. 

그리고 덮고 있는 이미지뷰의 UserInteraction 을 끄고, 루브 뷰에 탭 제스처를 연결해도 이벤트 전달이 잘 되었다. 
<br />

### **화면에서 어떤 동작들이 일어난 것일까?**

→ 제스처 & 리스폰더와 관련하여 공부중 🔥
<br /><br />

# 4단계

✅  검색 버튼을 누르면 신조어 검색 작업이 시작 된다.

✅  TextField 의 Text 에 해당하는 의미의 결과를 Label 문자열에 표기한다.

😅 키보드의 리턴키를 눌러도 신조어 검색 작업이 이루어진다.

- `textFieldShouldReturn(_ textField: UITextField)` 에서 구현해주면 된다.
<br /><br />

# 고민할 점
<br />

### 상황

서버에서 데이터를 가져올 경우 시간이 더 걸릴 수 있다.

결과를 가져오는데 시간이 걸려서 로딩이 발생할 경우 사용자 UX 를 통해 적절하게 기다리게 할 수 있는 제스쳐를 구현해주어야 한다.
<br />

### 사용자를 기다리게 할 수 있는 UX 에 대한 고민
<br />

### 연속적인 버튼 클릭을 제어할 수 있는 방법

- 왜? 네트워크 요청을 계속 보낼수 있게 하면 안된다.
- 요청 처리하는 서버 비용이 돈이라