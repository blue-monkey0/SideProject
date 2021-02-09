# 한국전자통신연구원 2020 동계 연구 연수생 참여 연구 과제

## 프로젝트 명 : Arc-Fault 감지 기반 화재 위험도 분류 및 예측 모델 개발
- 진행 기간: 2021.01.04 ~ 2021.02.28

## 1. 개발 배경 :question:
- '21년 etri 동계 연구 연수생 참여 후 박사님의 연구 과제에 필요한 데이터 분석 및 모델 개발을 맡게 됨.
- 데이터 분석 및 인공지능 관련 전공을 통해 현재 연구에 기여할 수 있는 좋은 기회라고 생각했음.
- `신호처리`와 같은 새로운 전문 지식에 흥미를 가짐.
- **본 연구 과제에서 개발과 관련된 내용을 제외한 자세한 내용은 밝힐 수 없음.**

| **화재 위험도 분류** | **화재 위험도 예측** |
| :-----------: | :-----------: |
| SVM | LSTM |

- 화재 위험도 분류 **`Normal` / `Arc` 상태를 분류하여 화재 위험도를 알려줌.**
- 화재 위험도 예측 **`Time Step`을 기준으로 다음 신호의 `Normal` / `Arc` 상태를 예측하여 화재 위험도를 예측해줌.**

## 2. 역할 :two_men_holding_hands:
> **김건**
- 모델 학습 데이터 수집, 데이터 전처리, 분류 모델 구현 및 평가, 시계열 예측 모델 구현 및 평가

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
- `K-Nearest Neighbor`을 통해 **window size** 만큼 shift하며, 거리를 0~1사이로 정규화. **Threshold**를 설정하여 임계값 이상은 **Anomaly**로 인식. 즉, Arc 신호를 **`Anomaly Detection`** 하여 labeling이 가능.
- **Time Step**을 주어 3D텐서로 변환 후 `Long short-term memory`모델로 학습 후 안전/위험도 예측



## 5. System
```Python
$ main_project
│
├─ _db
│   └─ data
│       ├─ crawling_data
│       │       └─ [개]  #  Directory for crawled images. When the image processing is complete, go [preprocessed_data] directory
│       ├─ model_data
│       │       ├─ gallery
│       │       │     └─ gallery_list # Temp directory for gallery images(option) 
│       │       ├─ query
│       │       │     └─ query_list  # Temp directory for query image
│       │       └─ working
│       │             ├─ dog_breeds.txt  # Image statistics used in training 
│       │             ├─ result.csv   # List of image softmax by breeds
│       │             ├─ to_reid.csv   # List of images that have passed Pearson correlation coefficient, region, and date filters
│       │             ├─ to_web.csv   # List of images sent to the web
│       │             └─ tmp.h5   # weights for classification model 
│       └─ preprocessed_data
│               └─ dog_class ─ image   # Preprocessed image using YOLO-v4
└─ _src
     ├─ batch
     │     ├─ send_email.py     # Check updated DB and send e-mail
     │     └─ update_data.bat   # Batch file for crawling and Preprocessing 'post' images
     ├─ data_analysis
     │     ├─ dog_image_similarity
     │     │          ├─ copy_image.py # Copy the file from the input path to the output path
     │     │          ├─ crawling_to_preprocessed.py # After preprocessing, train the model and move the file
     │     │          ├─ dog_breed_similarity_comparison.py # Image similarity comparison by pearson correlation
     │     │          ├─ extract_similar_image_path.py # Filtering images through breed classifier
     │     │          └─ predict_dog_data.py # Prediction by image
     │     └─ re_id
     │           └─ code
     │                ├─ reid_query.py   # Extract query image feature (512 vectors)
     │                ├─ reid_gallery.py  # Extract gallery image feature (512 vectors)
     │                ├─ reid_sort.py   # Calculate image similarity using cosine distance and sorting index   
     │                ├─ train.py   # To train model 
     │                └─ model.py   # Model structure for train.py
     │                
     ├─ data_analysis
     │     └─ data_collection_zooseyo.py # 'http://www.zooseyo.or.kr/zooseyo_or_kr.html' site data crawling
     ├─ data_processing
     │     └─ image_data_download.py # Code for downloading image 
     │     └─ yolo_v4
     │            └─  detect.py   # Detect dogs and cats. Crop target image and save 
     └─ web
         ├─ static
         │     └─ assets
         │           └─ img # Image and Icon for Web Design
         │     ├─ bootstrap # Bootstrap CSS, JS Files
         │     ├─ css # CSS files for Web Design
         │     ├─ js # JavaScript files for Web Design
         │     └─ images
         │           ├─ input_image
         │           └─ uploads # User Query Images
         ├─ templates
         │      ├─ find_my_dog_a.html  # Result Page
         │      └─ index.html   # Main page
         └─ app.py # Web Application (Calls Models)
```

## 6. requirement
```
python==3.8
matplotlib==3.2.2
numpy==1.18.5
pandas==1.0.5
scipy==1.4.1
tensorflow==2.3.0 
```

## 7. 프로젝트 진행 과정

- **`200706-200710`**
  - 아이디어 회의
- **`200713-200717`**
  - 아이디어 회의
  - 팀별 발표(변리사 & 학생 피드백)
- **`200720-200724`**
  - 환경 구축
  - 데이터 수집
    - [종합 유기견 보호센터](http://www.zooseyo.or.kr/zooseyo_or_kr.html?) : 유기 동물(공고 & 보호 중)
- **`200727-200731`**
  - 수집된 데이터 EDA
- **`200803-200807`**
  - Data preprocessing code 작성 
    - File renaming & random shuffle, Cross validation, Image Augmentation 
  - pet re-identification
    - [person re identification](https://github.com/waylybaye/Person_reID_baseline_pytorch#dataset--preparation) 응용 
  - 개 품종 분류 및 결과 EDA
- **`200810-200814`**
  - 분류 모델 softmax값을 이용한 cosine 유사도 측정
  - 임의의 이미지에 대해 공고 이미지와 유사도 측정 후 유사한 이미지 N개 출력
- **`200817-200821`**
  - 웹 디자인 구상
  - Object detection & Image crop하는 code 작성 (Using faster R-CNN)   
- **`200824-200831`**
  - 윈도우 작업스케줄러를 이용해 배치파일 적용(데이터 수집, 적재, 모델 학습 자동화)
  - flow diagram 작성
  - 웹 페이지 생성(flask, DB 연동)
  - 분류기와 re-id 연결
  - Object detection & Image crop(이미지 전처리)에 YOLO-V4 사용
  - 날짜, 지역 필터링 적용
  - 이메일 알림 기능 추가
