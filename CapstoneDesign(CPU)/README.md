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

3. R
- 데이터 분석하여 통계적 검정 수행

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

## 6. 2차 실험 진행
(1) 사용하는 인스턴스의 CPU 개수 확인
![image](https://user-images.githubusercontent.com/48666867/132149000-28b9d9ad-88dd-45ce-b8f3-0e22d3a842b3.png)
현재 사용한 인스턴스 타입은 t2.xlarge(quad core)이므로 CPU 개수가 4개인 것을 확인할 수 있음.

(2) thread = 1 CPU test
![image](https://user-images.githubusercontent.com/48666867/132149029-85068457-5a76-4008-bfea-7418839381ca.png)
CPU Thread: 1 <br
CPU Speed(연산 처리 속도): 337.48<br>
Total Time(연산 소요 시간): 29.6293s<br>
Latency(지연 시간): 2.96<br>

(3) thread = 2 CPU test
![image](https://user-images.githubusercontent.com/48666867/132149080-86bb357d-8277-4461-a189-38001e8be074.png)
CPU Speed(연산 처리 속도): 674.92<br>
Total Time(연산 소요 시간): 14.8145s<br>
Latency(지연 시간): 2.96<br>

(4) thread = 3 CPU test
![image](https://user-images.githubusercontent.com/48666867/132149123-f68956e8-8efd-4093-9d51-33ec59431019.png)
CPU Thread: 3<br>
CPU Speed(연산 처리 속도): 1012.38<br>
Total Time(연산 소요 시간): 9.8756s<br>
Latency(지연 시간): 2.96<br>

(5) thread = 4 CPU test
![image](https://user-images.githubusercontent.com/48666867/132149162-77293c8b-1d8a-4e5d-9498-bd993ae44185.png)
CPU Thread: 4<br>
CPU Speed(연산 처리 속도): 1346.76<br>
Total Time(연산 소요 시간): 7.4232s<br>
Latency(지연 시간): 2.97<br>

## 7. 실험 후 분석 과정 :bulb:
- 각 실험 결과 값들의 신뢰성을 높이기 위해 반복 실험하여 얻은 표본 30개를 Excel로 저장
- R Studio 프로그램으로 표본을 가지고 통계적 검정 시행
- t2.micro, t2.medium와 t2.xlarge를 그룹으로 묶고 난 뒤에 CPU Speed, Total Time 그리고 Latency값의 평균값이 서로 유의한 차이를 보이는지 일원배치 분산분석(One-way Anova) 기법을 사용하여 신뢰도 검정을 수행.
  - Instance Type 별 CPU Speed 평균값이 차이가 있는지 검정
  - Instance Type 별 Total Time 평균값이 차이가 있는지 검정
  - Instance Type 별 Latency 평균값이 차이가 있는지 검정
- Thread를 그룹으로 묶고 난 뒤에 CPU Speed, Total Time 그리고 Latency값의 평균값이 서로 유의한 차이를 보이는지 일원배치 분산분석(One-way Anova) 기법을 사용하여 신뢰도 검정을 하였다.
  - Thread 개수 별로 CPU Speed 평균값이 차이가 있는지 검정
  - Thread 개수 별로 Total Time 평균값이 차이가 있는지 검정
  - Thread 개수 별로 Latency 평균값이 차이가 있는지 검정

## 8. 실험 결과
아래 표는 실험을 반복하여 얻은 30개 표본의 평균값이다.
<img width="733" alt="스크린샷 2021-09-06 오전 10 57 44" src="https://user-images.githubusercontent.com/48666867/132150000-df2c67ef-50c1-4272-9e78-579f4db981af.png">
이들 값을 표본 신뢰도 검정 결과,
- Instance Type 별로 CPU 개수를 다르게 하였을 때, CPU 개수에 따라 연산처리 속도가 증가하여 CPU 개수에 비례한다는 결과를 얻었다. 그리고 연산하는데 걸리는 시간은 감소하여 반비례한다는 것을 알 수 있었다. 그러나 CPU 개수와 지연 시간은 별다른 상관성이 없는 결과를 볼 수 있다.

아래 표는 실험을 반복하여 얻은 30개 표본의 평균값이다.
<img width="730" alt="스크린샷 2021-09-06 오전 11 04 03" src="https://user-images.githubusercontent.com/48666867/132150385-b19b746a-1c05-4020-a1c7-675114848c3d.png">
이들 값을 표본 신뢰도 검정 결과,
- 위 결과들을 통하여 동일한 CPU 개수에서 thread 개수를 다르게 하였을 때, thread 개수에 따라 연산처리 속도가 증가하여 thread 개수에 비례한다는 결과를 얻었다. 그리고 연산하는데 걸리는 시간은 감소하여 반비례한다는 것을 알 수 있었다. 그러나 thread 개수와 지연 시간은 별다른 상관성이 없는 결과를 볼 수 있다.

