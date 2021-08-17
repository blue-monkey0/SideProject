# 한국전자통신연구원 2020 동계 연구 연수생 참여 연구 과제

## 프로젝트 명 : Arc-Fault 감지 기반 화재 위험도 분류 및 예측 모델 개발
- 진행 기간: 2021.01.04 ~ 2021.02.28

## 1. 개발 배경 :question:
- '21년 etri 동계 연구 연수생 참여 후 박사님의 연구 과제에 필요한 데이터 분석 및 모델 개발을 맡게 됨.
- 데이터 분석 및 인공지능 관련 전공을 통해 현재 연구에 기여할 수 있는 좋은 기회라고 생각했음.
- `신호처리`와 같은 새로운 전문 지식에 흥미를 가짐.
- **본 연구 과제에서 코드와 관련된 내용을 제외한 자세한 내용은 밝힐 수 없음.**

| **화재 위험도 분류** | **화재 위험도 단계별 분류** |
| :-----------: | :-----------: |
| SVM | Wavelet Transform |

- 화재 위험도 분류 **`Normal` / `Arc` 상태를 분류하여 화재 위험도를 알려줌.**
- 화재 위험도 단계별 분류 **`WP transform`을 통해 `Arc-Fault`를 탐지하여 화재 위험도를 실시간으로 출력해줌.**

## 2. 역할 :two_men_holding_hands:
> **김건**
- 모델 학습 데이터 수집, 데이터 전처리, 분류 모델 구현 및 평가, Arc-Fault 탐지 화재 위험도 안내 시스템 개발

## 3. 시스템 사용 Tool
<div>
  <img width="200" src="https://github.com/GeonKimdcu/SideProject/blob/main/Arc-Fault/_img/ppy.PNG">
</div>

## 4. 프로젝트 요약
- Arc Generator Test System을 통한 데이터 수집이 아직 이루어지지 않은 관계로 가상의 **Arc-Fault 데이터**를 `생성` 및 `수집`
- **`Normal`, `Arc1`, `Arc2`** 상태인 데이터 3종 생성
- 실제 arc generator에서 검출한 신호와 비슷한 조건으로 생성 후 데이터 종류 당 20개의 데이터 추출
- 도출된 데이터를 바탕으로 **FFT(Fast Fourier Transform)**, **STFT(Short Time Fourier Transform)**, **WT(Wavelet Transform)** 변환 후 `max`, `mean`, `std`, `Frequency`, `Magnitude` 등 데이터 Feature 추출
- Data Feature 간의 **PCC(Pearson Correlation Coefficient)** 기반 `독립성 검정`, 변수 간의 독립성이 너무 강해 변수 선택법이 아닌 차원 축소 **PCA**로 접근
- **Principal Component Analysis**으로 차원 축소 후 Class의 불균형 해소 위한 **SMOTE** 기법 사용하여 **`OverSampling`** 진행
- **SVM(support vector machine)** 으로 Normal, Arc 상태 **분류모델** 학습
- **Time Series Data** 기반 위험도 예측 모델 개발 위해 `K-NN`, `LSTM` 기법 구현
- `K-Nearest Neighbor`을 통해 **window size** 만큼 shift하며, 거리를 0~1사이로 정규화. **Threshold**를 설정하여 임계값 이상은 **Anomaly**로 인식. 즉, Arc 신호를 **`Anomaly Detection`** 하여 labeling이 가능
- `Wavelet Packet Transform`을 통해 Arc state를 Anomaly Detection 함. 단계별 `threshold`를 할당하여 임계값 초과 시 count값을 누적 후 이를 토대로 실시간 단계별 상태 출력
- 관련 논문) H.Zhang, "Arc Fault Signatures Detection on Aircraft Wiring System", IEEE, 2006, pp. 5548-5552


## 5. requirement
```
python==3.7
matplotlib==3.2.2
numpy==1.18.5
pandas==1.0.5
scipy==1.4.1
sklearn==0.0
statsmodels==0.12.2
PyWavelet==1.1.1
```

## 6. 프로젝트 진행 과정 :bulb:

- **`210104-210108`**
  - 연구과제 관련 미팅
  - '신호처리', 'Arc-Fault' study
- **`210111-210115`**
  - 'Arc-Fault' 가상 signal 생성
  - 가상 Arc signal 피드백(Ph.D. & me)
  - 데이터 종류(Normal, Arc1, Arc2) 당 20개의 데이터 추출 (max, mean, std, max-min-diff)
- **`210118-210122`**
  - 'FFT, STFT, WT' study
  - 'transform'한 signal feature 추출(Spectrum 값 및 변화 특성)
  - 데이터 feature간의 상관관계 분석 후 VIF를 통한 변수 선택법, PCA 적용
- **`210125-210129`**
  - Class 불균형 해소 위한 SMOTE 기법을 통한 Oversampling 적용
  - SVM 모델 구현 및 평가. 피드백(Ph.D. & me)
- **`210201-210205`**
  - Time Series Data 생성 및 Preprocessing
  - 연구과제 관련 미팅
- **`210208-210210`**
  - KNN 알고리즘을 통한 Anomaly Detection 구현
  - 구현 모델 피드백(Ph.D. & me)
- **`210216-210219`**
  - Wavelet Packet Transform 관련 논문 정리
  - WPT를 사용해 고역통과필터로 분해된 주파수 성분들로 window 별 maximum peak value추출
  - peak 값을 통해 window 별 ratio로 값 생성
  - threshold를 설정 후, 주어진 신호에서 Arc-Fault를 검출해 단계별 'safety / caution / warning' 상태 출력
- **`210222-210226`**
  - 코드 주석 정리 및 코드 상세 내용 문서화 후 코드 관련 Q&A(Ph.D & me)
