# KBO 2018 data

kbo_2018_p <- read_excel("2020빅콘테스트_스포츠투아이_제공데이터_2018.xlsx", sheet = 4)
kbo_2018_h <- read_excel("2020빅콘테스트_스포츠투아이_제공데이터_2018.xlsx", sheet = 5)


kbo_2018_p <- kbo_2018_p[c(3, 4, 10, 30, 31)]
kbo_2018_h <- kbo_2018_h[c(2, 3, 4, 8,10, 11)]

# OB 2018 data
OB_p <- kbo_2018_p %>% filter(T_ID == "OB")
OB_h <- kbo_2018_h %>% filter(T_ID == "OB")
OB <- cbind(OB_h, OB_p[3:5])

# KT 2018 data
KT_p <- kbo_2018_p %>% filter(T_ID == "KT")
KT_h <- kbo_2018_h %>% filter(T_ID == "KT")
KT <- cbind(KT_h, KT_p[3:5])


# SS 2018 data
SS_p <- kbo_2018_p %>% filter(T_ID == "SS")
SS_h <- kbo_2018_h %>% filter(T_ID == "SS")
SS <- cbind(SS_h, SS_p[3:5])

# NC 2018 data
NC_p <- kbo_2018_p %>% filter(T_ID == "NC")
NC_h <- kbo_2018_h %>% filter(T_ID == "NC")
NC <- cbind(NC_h, NC_p[3:5])

# LG 2018 data
LG_p <- kbo_2018_p %>% filter(T_ID == "LG")
LG_h <- kbo_2018_h %>% filter(T_ID == "LG")
LG <- cbind(LG_h, LG_p[3:5])

# SK 2018 data
SK_p <- kbo_2018_p %>% filter(T_ID == "SK")
SK_h <- kbo_2018_h %>% filter(T_ID == "SK")
SK <- cbind(SK_h, SK_p[3:5])

# HH 2018 data
HH_p <- kbo_2018_p %>% filter(T_ID == "HH")
HH_h <- kbo_2018_h %>% filter(T_ID == "HH")
HH <- cbind(HH_h, HH_p[3:5])

# HT 2018 data
HT_p <- kbo_2018_p %>% filter(T_ID == "HT")
HT_h <- kbo_2018_h %>% filter(T_ID == "HT")
HT <- cbind(HT_h, HT_p[3:5])

# WO 2018 data
WO_p <- kbo_2018_p %>% filter(T_ID == "WO")
WO_h <- kbo_2018_h %>% filter(T_ID == "WO")
WO <- cbind(WO_h, WO_p[3:5])

# LT 2018 data
LT_p <- kbo_2018_p %>% filter(T_ID == "LT")
LT_h <- kbo_2018_h %>% filter(T_ID == "LT")
LT <- cbind(LT_h, LT_p[3:5])

KBO_2018 <- rbind(OB, KT, SS, NC, LG, SK, HH, HT, WO, LT)

# 파일 저장
write.csv(KBO_2018, "C:/output/kbo_2018.csv", col.names = T)

