# KBO 2019 data

kbo_2019_p <- read_excel("2020빅콘테스트_스포츠투아이_제공데이터_2019.xlsx", sheet = 4)
kbo_2019_h <- read_excel("2020빅콘테스트_스포츠투아이_제공데이터_2019.xlsx", sheet = 5)


kbo_2019_p <- kbo_2019_p[c(3, 4, 10, 30, 31)]
kbo_2019_h <- kbo_2019_h[c(2, 3, 4, 8,10, 11)]

# OB 2019 data
OB_p <- kbo_2019_p %>% filter(T_ID == "OB")
OB_h <- kbo_2019_h %>% filter(T_ID == "OB")
OB <- cbind(OB_h, OB_p[3:5])

# KT 2019 data
KT_p <- kbo_2019_p %>% filter(T_ID == "KT")
KT_h <- kbo_2019_h %>% filter(T_ID == "KT")
KT <- cbind(KT_h, KT_p[3:5])


# SS 2019 data
SS_p <- kbo_2019_p %>% filter(T_ID == "SS")
SS_h <- kbo_2019_h %>% filter(T_ID == "SS")
SS <- cbind(SS_h, SS_p[3:5])

# NC 2019 data
NC_p <- kbo_2019_p %>% filter(T_ID == "NC")
NC_h <- kbo_2019_h %>% filter(T_ID == "NC")
NC <- cbind(NC_h, NC_p[3:5])

# LG 2019 data
LG_p <- kbo_2019_p %>% filter(T_ID == "LG")
LG_h <- kbo_2019_h %>% filter(T_ID == "LG")
LG <- cbind(LG_h, LG_p[3:5])

# SK 2019 data
SK_p <- kbo_2019_p %>% filter(T_ID == "SK")
SK_h <- kbo_2019_h %>% filter(T_ID == "SK")
SK <- cbind(SK_h, SK_p[3:5])

# HH 2019 data
HH_p <- kbo_2019_p %>% filter(T_ID == "HH")
HH_h <- kbo_2019_h %>% filter(T_ID == "HH")
HH <- cbind(HH_h, HH_p[3:5])

# HT 2019 data
HT_p <- kbo_2019_p %>% filter(T_ID == "HT")
HT_h <- kbo_2019_h %>% filter(T_ID == "HT")
HT <- cbind(HT_h, HT_p[3:5])

# WO 2019 data
WO_p <- kbo_2019_p %>% filter(T_ID == "WO")
WO_h <- kbo_2019_h %>% filter(T_ID == "WO")
WO <- cbind(WO_h, WO_p[3:5])

# LT 2019 data
LT_p <- kbo_2019_p %>% filter(T_ID == "LT")
LT_h <- kbo_2019_h %>% filter(T_ID == "LT")
LT <- cbind(LT_h, LT_p[3:5])

KBO_2019 <- rbind(OB, KT, SS, NC, LG, SK, HH, HT, WO, LT)

# 파일 저장
write.csv(KBO_2019, "C:/output/kbo_2019.csv", col.names = T)
