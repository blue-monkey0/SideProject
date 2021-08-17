# KBO 2016 data

library(dplyr)
library(readxl)
library(writexl)
library(stringr)
library(xlsx)

kbo_2016_p <- read_excel("2020빅콘테스트_스포츠투아이_제공데이터_2016.xlsx", sheet = 4)
kbo_2016_h <- read_excel("2020빅콘테스트_스포츠투아이_제공데이터_2016.xlsx", sheet = 5)


kbo_2016_p <- kbo_2016_p[c(3, 4, 10, 30, 31)]
kbo_2016_h <- kbo_2016_h[c(2, 3, 4, 8,10, 11)]

# OB 2016 data
OB_p <- kbo_2016_p %>% filter(T_ID == "OB")
OB_h <- kbo_2016_h %>% filter(T_ID == "OB")
OB <- cbind(OB_h, OB_p[3:5])

# KT 2016 data
KT_p <- kbo_2016_p %>% filter(T_ID == "KT")
KT_h <- kbo_2016_h %>% filter(T_ID == "KT")
KT <- cbind(KT_h, KT_p[3:5])


# SS 2016 data
SS_p <- kbo_2016_p %>% filter(T_ID == "SS")
SS_h <- kbo_2016_h %>% filter(T_ID == "SS")
SS <- cbind(SS_h, SS_p[3:5])

# NC 2016 data
NC_p <- kbo_2016_p %>% filter(T_ID == "NC")
NC_h <- kbo_2016_h %>% filter(T_ID == "NC")
NC <- cbind(NC_h, NC_p[3:5])

# LG 2016 data
LG_p <- kbo_2016_p %>% filter(T_ID == "LG")
LG_h <- kbo_2016_h %>% filter(T_ID == "LG")
LG <- cbind(LG_h, LG_p[3:5])

# SK 2016 data
SK_p <- kbo_2016_p %>% filter(T_ID == "SK")
SK_h <- kbo_2016_h %>% filter(T_ID == "SK")
SK <- cbind(SK_h, SK_p[3:5])

# HH 2016 data
HH_p <- kbo_2016_p %>% filter(T_ID == "HH")
HH_h <- kbo_2016_h %>% filter(T_ID == "HH")
HH <- cbind(HH_h, HH_p[3:5])

# HT 2016 data
HT_p <- kbo_2016_p %>% filter(T_ID == "HT")
HT_h <- kbo_2016_h %>% filter(T_ID == "HT")
HT <- cbind(HT_h, HT_p[3:5])

# WO 2016 data
WO_p <- kbo_2016_p %>% filter(T_ID == "WO")
WO_h <- kbo_2016_h %>% filter(T_ID == "WO")
WO <- cbind(WO_h, WO_p[3:5])

# LT 2016 data
LT_p <- kbo_2016_p %>% filter(T_ID == "LT")
LT_h <- kbo_2016_h %>% filter(T_ID == "LT")
LT <- cbind(LT_h, LT_p[3:5])

KBO_2016 <- rbind(OB, KT, SS, NC, LG, SK, HH, HT, WO, LT)

# 파일 저장
write.csv(KBO_2016, "C:/output/kbo_2016.csv", col.names = T)
