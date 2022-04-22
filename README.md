# 운동타이머 앱

## 배경
이 앱은 제가 평소에 헬스를 하면서 기본 타이머앱이나 타바타 타이머앱이라던지 등을 사용하다가 느꼈던 불편한점을 개선해 만든 헬스에 최적화된 타이머입닌다. 운동 쉬는시간 중간중간에 운동 일지를 기록해야하는 일이 있는데 그럴때마다 백그라운드로 나가서 메모앱을 키는 이런 불편한점도 모두 해결할수 있게 타이머기능과 일지기능을 모두 넣었습니다. 또한 제 스스로의 힘으로 처음 만들어본 앱이기도 합니다.     
   
## 개발환경
데이터베이스는 Reaml 프레임워크를 사용했습니다.
디자인패턴은 MVC디자인패턴을 사용했습니다.
UI는 스토리보드를 이용해 구현했습니다.


## 구현기능
1. 세트수를 알수있는 타이머기능

2. 쉬는시간 종료시 소리로 알려주는 알람기능

3. 운동일지를 기록할수있는 메모기능

4. 1RM 계산기 기능

5. 다중언어를 지원합니다.

## 개발과정

### 타이머 기능

![Simulator Screen Recording - iPhone 13 - 2022-04-22 at 18 01 10](https://user-images.githubusercontent.com/93653997/164673883-e98c9df5-fb31-4403-90d3-3d0f50e08dfd.gif)

타이머는 UIPickerView를 쉬는시간을 설정하고 시작버튼을 누른뒤 한 세트가 끝나면 바로 설정해둔 쉬는시간 타이머가 작동합니다.   
타이머의 작동 유무에따라 어떤 UI는 숨기고, 어떤 버튼은 비활성화 시키고 등을 구현 했습니다.   
또한 세트종료버튼을 누를때마다 현재 세트의 숫자가 올라갑니다.   



### 쉬는시간 종료 알람기능

쉬는시간이 종료되면 알람이 울리도록 설정하고 타이머 View에서 알람을 켜고 끌수 할수 있습니다.


<details>
<summary>코드보기</summary>

소리 재생을 위한 코드 입니다.
```swift
    private func playSound() {
        let url = Bundle.main.url(forResource: "sound", withExtension: "mp3")!
        if soundBool {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                print(error)
            }
        } else {
            return
        }
    }

```
</details>


### 운동일지 기능
![Simulator Screen Recording - iPhone 13 - 2022-04-22 at 18 12 45](https://user-images.githubusercontent.com/93653997/164675965-3d617bdc-b3b6-4f50-bb88-5a32b5bded57.gif)

![Simulator Screen Recording - iPhone 13 - 2022-04-22 at 18 13 08](https://user-images.githubusercontent.com/93653997/164676023-aebe5147-7d88-4ae0-8e2b-30390ca81948.gif)


운동부위별 카테고리를 만들수 있고 이 카테고리를 클릭하면 세부 메모로 넘어간뒤     
거기서 일일 운동일지를 작성할수 있습니다.   



<details>
<summary>코드보기</summary>

팝업뷰에서 받은 데이터를 델리게이트패턴으로 받운뒤 Ramlm 데이터베이스에 새롭게 생성하고    
또한 삭제하거나 테이블뷰에 불러옵니다.
```swift
SendUpdatedelegate {
    func sendUpdate(_ name: String) {
        saveCategories(name: name)
    }
    
    private func saveCategories(name: String) {
        try! RealmSingleton.shared.realm.write {
            RealmSingleton.shared.realm.add(WorkoutCategory(name: name))
        }
        
        tableView.reloadData()
    }
    
    private func loadCategories() {
        workoutCategories = RealmSingleton.shared.realm.objects(WorkoutCategory.self)
        tableView.reloadData()
    }
    
    private func deleteCategories(index: Int) {
        if let categories = workoutCategories?[index] {
            try! RealmSingleton.shared.realm.write{
                RealmSingleton.shared.realm.delete(categories.items)
                RealmSingleton.shared.realm.delete(categories)
            }
        }
        tableView.reloadData()
    }
}

```
</details>

### 1RM 계산기 기능

![Simulator Screen Recording - iPhone 13 - 2022-04-22 at 18 14 07](https://user-images.githubusercontent.com/93653997/164676606-8ee0daea-f4da-4145-a8d0-45c8649ffa49.gif)

입력한 무게와 Reps를 바탕으로 여러 RM의 값을 구합니다.


### 다중언어 지원

![Simulator Screen Recording - iPhone 13 - 2022-04-22 at 18 25 41](https://user-images.githubusercontent.com/93653997/164678009-08e67f18-1f2f-4f3e-9797-eda3af86cb2d.gif)


![Simulator Screen Recording - iPhone 13 - 2022-04-22 at 18 27 06](https://user-images.githubusercontent.com/93653997/164678129-a79650de-7a8f-45e2-9a4b-b1b9bb114481.gif)


아이폰의 언어 설정 따라 영어와 한국어를 지원합니다.


## 심사과정
1. 첫번째 리젝    
앱스토어에 비슷한 타이머앱들이 너무 많이 있다고 스팸앱 판정을 받았습니다.   
저의 앱은 헬스에 특화된 타이머라고 생각하고 만들었기 때문에   
내가 만든앱이 많은 타이머 앱과 무엇이 다른지에 대해 자세히 설명을했습니다.   

그 뒤에 심사에 통과 되고 앱을 출시했습니다.


## 업데이트 과정
1. 첫번째 업데이트     

알람이 울리도록 하는 기능을 켰다 껏다 할수가 있는데
매번 앱이 켜질때마다 버튼이 초기화되버리는 문제가 있었습니다.   
그래서 UserDefault를 사용해 알람사용 유무 상태를 저장하기로 업데이트했습니다


<details>
<summary>코드보기</summary>



```swift
 @IBAction func playSoundButton(_ sender: Any) {
        if soundButton.currentImage == UIImage(systemName: "bell") {
            soundAlert(text: "Do you want to turn off the rest time finish sound?".localized()) { [self] in
                UserDefaults.standard.set(false, forKey: "Sound")
                soundBool = UserDefaults.standard.bool(forKey: "Sound")
                soundButton.setImage(UIImage(systemName: "bell.slash"), for: .normal) }
            } else {
                soundAlert(text: "Do you want to turn on the rest time finish sound?".localized()) { [self] in
                    UserDefaults.standard.set(true, forKey: "Sound")
                    soundBool = UserDefaults.standard.bool(forKey: "Sound")
                    soundButton.setImage(UIImage(systemName: "bell"), for: .normal)}
            }
        }
```

</details>

