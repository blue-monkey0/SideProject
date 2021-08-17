# 인공지능 그랜드 챌린지 - '사물인지'

## 프로젝트 명 : 주어진 생활 폐기물 이미지를 분석하여 분류기준에 따라 분류
- 진행 기간: 2020.07.20 ~ 2020.09.28

## 1. 개발 배경 :question:
- 실생활의 문제점을 포착해 해결하는 프로젝트라는 점에서 흥미를 가지게 됨.
- `Object Detection` 처음이므로 많이 배울 수 있는 기회라고 생각함.
- 교수님과 함께하는 팀 프로젝트여서 많은 것을 배워보자는 취지로 참여하게 됨.
- 400장의 sample image에서 추가로 2100장의 사진을 더 수집하였음.

## 2. 역할 :two_men_holding_hands:
> **김건**
- image 라벨링, 파일명 변환 코드 구현, jpg 확장자 png로 변환 코드 구현

> **배OO(Supervised.)**
- keras-yolo 오픈 소스 선택 및 공유, 학습 모델 구현

> **박OO**
- image 라벨링, json, xml 파일 변환 코드 구현

> **권OO, 한OO**
- 데이터 수집, image 라벨링

## 3. 시스템 사용 Tool
<div>
  <img width="200" src="https://github.com/GeonKimdcu/SideProject/blob/main/Arc-Fault/_img/ppy.PNG">
</div>

## 4. 프로젝트 요약
- `labelImg` 오픈소스 툴 다운로드하여 생활폐기물을 분류기준에 맞게 라벨링하였음.(Ref. https://github.com/tzutalin/labelImg)
- 클래스는 `paper`, `paperpack`, `can`, `glassbottle`, `PET`, `plasticware`, `plastic bag`으로 분류하였음.
- 대회 기간 내 최대한 데이터 수를 늘리기 위해 노력하였음. 
- 부족한 class의 사진은 각도를 틀거나 뒤집어 image 수를 늘려 class별로 균등하게 해주었음.

## 6. requirement
```
python==3.7
numpy==1.18.5
pandas==1.0.5
keras==2.4.3
yolo3==1.0
```

## 7. 프로젝트 진행 과정 :bulb:

- **`201101-201107`**
  - 프로젝트 개요 OT
  - `CUDA / CUDNN` install
  - `Tensorflow / Keras` install
  - `custom dataset` download
  - `labelImg` 오픈소스 툴 downlad
- **`201108-201113`**
  - 클래스 선정
  - 데이터 수집
  - `labelImg` tool 사용하여 image labelling
- **`201114-201120`**
  - 데이터 수집
  - `labelImg` tool 사용하여 image labelling
  - `Object Detection` 모델 구현 후 학습
