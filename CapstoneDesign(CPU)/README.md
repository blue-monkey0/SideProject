# 교내 캡스톤디자인

## 프로젝트 명 : 클라우드 환경에서 CPU 가상 자원 성능 측정에 관한 연구
- 진행 기간: 2020.05.01 ~ 2020.06.10

## 1. 개발 배경 :question:
- 클라우드는 인터넷을 통해 액세스되는 서버와 해당 서버에서 실행되는 소프트웨어 및 데이터베이스를 나타내며, 클라우드 서비스를 이용하면 사용자와 회사는 물리적 서버 자체를 관리하거나 자신의 컴퓨터에서 소프트웨어 응용 프로그램을 실행할 필요가 없음.
- 이러한 장점으로 인해 한국에서도 많은 중견 기업 이상급들이 비용 절감을 위해 오픈 스택, Private Cloud 도입을 하는 추세임. 
- 하지만 클라우드는 공유자원을 빌려 쓰는 것이므로 오늘 잘 작동한다고 해서 내일 잘 작동한다는 것을 보장할 수 없음. 
- 따라서 클라우드 서비스의 객관적인 성능측정을 위해 측정하는 항목 및 방법 등을 연구하여 다양한 클라우드 가상자원에 대한 성능측정을 용이하게 한다.

| **CPU** | **Thread ** |
| :-----------: | :-----------: |
| One-way Anova | One-way Anova |


## 2. 역할 :two_men_holding_hands:
> **김건**
- 가상 인스턴스 생성, 가상 자원 성능 측정 후 데이터 수집, 통계적 검정

## 3. 시스템 사용 Tool
1. sysbench <br>
소개: 인텐시브한 로드에서 데이터베이스를 실행하는 시스템에 필요한 운영체제를 평가하는 모듈화된 크로스 플랫폼 및 멀티 스레드 벤치마크 툴
- 많은 레퍼런스를 보유하고 있어 성능 진단에 유용하게 사용됨.
- 데이터베이스를 설치하지 않고도 복잡한 설정을 하지 않고도 시스템 성능을 분석할 수 있음.
- 백분위수 및 히스토그램을 사용해 속도 및 지연 시간에 대한 광범위한 통계를 냄.

2. AWS EC2
- 가상 인스턴스 생성

## 4. CPU 성능측정 수행을 위한 시나리오 선정
(1) 1차 실험 <br>
주제: AWS Instance 유형 별로 CPU 개수에 차이를 두어 비례 혹은 반비례하게 CPU 성능(CPU Speed, Total Time, Latency)이 측정되는지 증명하고자 함. <br>
사용할 인스턴스 유형: t2.micro(single core), t2.medium(dual core), t2.xlarge(quad core)<br>
 
(2) 2차 실험<br>
주제: AWS Instance 하나의 타입(CPU 개수 동일)에서 스레드 개수에 차이를 두어 비례 혹은 반비례하게 CPU 성능(CPU Speed, Total Time, Latency)이 측정되는지 증명하고자 함.<br>
사용할 인스턴스 유형: t2.xlarge(quad core)

## 5. 1차 실험 진행
(1) 사용하는 인스턴스의 CPU 개수 확인
![image](https://user-images.githubusercontent.com/48666867/132148635-128562de-2012-47df-b265-df36cb7c6f52.png)
현재 사용한 인스턴스 타입은 t2.xlarge(quad core)이므로 CPU 개수가 4개인 것을 확인할 수 있음.

(2) CPU test(코어를 다 사용했을 때 연산 속도 및 연산까지 걸린 시간, 지연성을 확인)
![image](https://user-images.githubusercontent.com/48666867/132148678-247ac747-3772-4760-8b9d-91ece456eefc.png)
실험에 쓰일 인스턴스에서 나온 CPU 개수를 ‘threads=N’에 넣는다. 이를 CPU 개수가 다른 인스턴스 타입 별로 반복하여 측정해줌.
- option 값
(a) --threads 옵션 값은 스레드 수 <br>
(b) --events는 총 요청 수를 제한 <br>
(c) --time은 전체 실행 시간제한(초)이고 0은 시간 관계없이 events 수 만큼 요청 실행<br>
(d) --cpu-max-prime은 소수(prime number)를 이용한 연산으로 값을 20000으로 설정<br>
 

(3) t2.micro(single core) Instance Type CPU test
![image](https://user-images.githubusercontent.com/48666867/132148719-4d40ea15-e54b-441f-9b65-2424b452ecda.png)
CPU Thread : 1<br>
CPU Speed(연산 처리 속도): 332.20<br>
Total Time(연산 소요 시간): 30.0998s<br>
Latency(지연 시간): 3.01<br>
 

(4) t2.medium(dual core) Instance Type CPU test
![image](https://user-images.githubusercontent.com/48666867/132148747-e4e6e6f2-bf4a-4726-ba48-f470391aea87.png)
CPU Thread: 2<br>
CPU Speed(연산 처리 속도): 706.31<br>
Total Time(연산 소요 시간): 14.1540s<br>
Latency(지연 시간): 2.83<br>
 

(5) t2.xlarge(quad core) Instance Type CPU test
![image](https://user-images.githubusercontent.com/48666867/132148760-7be6d658-a88c-46c3-b1ca-9be520063069.png)
CPU Thread: 4<br>
CPU Speed(연산 처리 속도): 1414.44<br>
Total Time(연산 소요 시간): 7.0679s<br>
Latency(지연 시간): 2.83<br>
 
 
 
 








## 7. 프로젝트 진행 과정 :bulb:

- **`201001-201007`**
  - 분석 주제 설정 및 방향 설계
  - 데이터 선정
  - 최종 결과를 어떻게 낼 것인지 설정
- **`201008-201023`**
  - 데이터 수집
  - 자료 조사
- **`201026-201101`**
  - 데이터 전처리
  - 상관관계 분석
- **`201102-201113`**
  - 데이터 상관관계 시각화
  - 다중공선성 진단
- **`201116-201130`**
  - 회귀분석 모델 구현
- **`201201-201204`**
  - 모델 관련 미팅 후 피드백 반영
- **`201205-201209`**
  - 최종 코드 정리 및 프로젝트 ppt로 정리 후 발표

## 8. 프로젝트 보완
- **`210401-210524`**
   - 프로젝트 변수 수정 및 보완 (보건분야 예산액, 의료시설 현황, 의료진 현황을 1인 대비로 변경)
   - 코드 최종 정리 후 논문 작성
   - 관련 사례 국내외 논문 조사
 - **`210603-210605`**
   - KIIT 하계종합학술대회 및 대학생 논문 경진대회 참여 후 연구 논문 발표
   - 우수논문상(동상) 수상
   - [관련 기사](https://news.imaeil.com/Education/2021062215014944509)
