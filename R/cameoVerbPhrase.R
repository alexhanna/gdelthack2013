library(plyr)
library(stringr)

df <- read.table(file="../data/v7.path_pattern_matches.txt", sep = "\t", quote = '', 
	col.names = c("CAMEO", "CAMEORoot", "DepParse"),
	colClasses = c("character", "character", "character"),
	header = FALSE, stringsAsFactors = FALSE)

df.ordered <- df[with(df, order(CAMEO, CAMEORoot)),]
df.protest <- df[str_detect(df$CAMEO, '^14'),]

path.vocab      <- readLines("../data/251741.v7.sf.k=10.c=6.trim/path.vocab")
mean.cPathFrame <- read.table("../data/251741.v7.sf.k=10.c=6.trim/mean.cPathFrame")

df.acl   <- data.frame(DepParse = path.vocab, mean.cPathFrame)
df.merge.nocameo <- merge(df.acl, df, all.x = TRUE)
df.merge <- merge(df.acl, df)

df.merge$V1 <- df.merge$V1 / sum(df.merge$V1)
df.merge$V2 <- df.merge$V2 / sum(df.merge$V2)
df.merge$V3 <- df.merge$V3 / sum(df.merge$V3)
df.merge$V4 <- df.merge$V4 / sum(df.merge$V4)
df.merge$V5 <- df.merge$V5 / sum(df.merge$V5)
df.merge$V6 <- df.merge$V6 / sum(df.merge$V6)
df.merge$V7 <- df.merge$V7 / sum(df.merge$V7)
df.merge$V8 <- df.merge$V8 / sum(df.merge$V8)
df.merge$V9 <- df.merge$V9 / sum(df.merge$V9)
df.merge$V10 <- df.merge$V10 / sum(df.merge$V10)

df.merge.nocameo$V1 <- df.merge.nocameo$V1 / sum(df.merge.nocameo$V1)
df.merge.nocameo$V2 <- df.merge.nocameo$V2 / sum(df.merge.nocameo$V2)
df.merge.nocameo$V3 <- df.merge.nocameo$V3 / sum(df.merge.nocameo$V3)
df.merge.nocameo$V4 <- df.merge.nocameo$V4 / sum(df.merge.nocameo$V4)
df.merge.nocameo$V5 <- df.merge.nocameo$V5 / sum(df.merge.nocameo$V5)
df.merge.nocameo$V6 <- df.merge.nocameo$V6 / sum(df.merge.nocameo$V6)
df.merge.nocameo$V7 <- df.merge.nocameo$V7 / sum(df.merge.nocameo$V7)
df.merge.nocameo$V8 <- df.merge.nocameo$V8 / sum(df.merge.nocameo$V8)
df.merge.nocameo$V9 <- df.merge.nocameo$V9 / sum(df.merge.nocameo$V9)
df.merge.nocameo$V10 <- df.merge.nocameo$V10 / sum(df.merge.nocameo$V10)

df.merge$count <- 1

df.v1 <- ddply(head(df.merge[with(df.merge, order(-V1)),],50), c("CAMEO"), function(d) { sum(d$count)})
df.v2 <- ddply(head(df.merge[with(df.merge, order(-V2)),],50), c("CAMEO"), function(d) { sum(d$count)})
df.v3 <- ddply(head(df.merge[with(df.merge, order(-V3)),],50), c("CAMEO"), function(d) { sum(d$count)})
df.v4 <- ddply(head(df.merge[with(df.merge, order(-V4)),],50), c("CAMEO"), function(d) { sum(d$count)})
df.v5 <- ddply(head(df.merge[with(df.merge, order(-V5)),],50), c("CAMEO"), function(d) { sum(d$count)})
df.v6 <- ddply(head(df.merge[with(df.merge, order(-V6)),],50), c("CAMEO"), function(d) { sum(d$count)})
df.v7 <- ddply(head(df.merge[with(df.merge, order(-V7)),],50), c("CAMEO"), function(d) { sum(d$count)})
df.v8 <- ddply(head(df.merge[with(df.merge, order(-V8)),],50), c("CAMEO"), function(d) { sum(d$count)})
df.v9 <- ddply(head(df.merge[with(df.merge, order(-V9)),],50), c("CAMEO"), function(d) { sum(d$count)})
df.v10 <- ddply(head(df.merge[with(df.merge, order(-V10)),],50), c("CAMEO"), function(d) { sum(d$count)})

df.codes <- rbind(
	cbind(Cluster = "1", df.v1[which(df.v1$V1 == max(df.v1$V1)),]),
	cbind(Cluster = "2", df.v2[which(df.v2$V1 == max(df.v2$V1)),]),
	cbind(Cluster = "3", df.v3[which(df.v3$V1 == max(df.v3$V1)),]),
	cbind(Cluster = "4", df.v4[which(df.v4$V1 == max(df.v4$V1)),]),
	cbind(Cluster = "5", df.v5[which(df.v5$V1 == max(df.v5$V1)),]),
	cbind(Cluster = "6", df.v6[which(df.v6$V1 == max(df.v6$V1)),]),
	cbind(Cluster = "7", df.v7[which(df.v7$V1 == max(df.v7$V1)),]),
	cbind(Cluster = "8", df.v8[which(df.v8$V1 == max(df.v8$V1)),]),
	cbind(Cluster = "9", df.v9[which(df.v9$V1 == max(df.v9$V1)),]),
	cbind(Cluster = "10", df.v10[which(df.v10$V1 == max(df.v10$V1)),])
)

df.final.codes = data.frame( Cluster = 1:10, CAMEO = c("042", "051", "190", "042", "111", "051", "051", "020", "111", "036") )

df.v1.final <- head(df.merge.nocameo[with(df.merge.nocameo, order(-V1)),], 50)
df.v2.final <- head(df.merge.nocameo[with(df.merge.nocameo, order(-V2)),], 50)
df.v3.final <- head(df.merge.nocameo[with(df.merge.nocameo, order(-V3)),], 50)
df.v4.final <- head(df.merge.nocameo[with(df.merge.nocameo, order(-V4)),], 50)
df.v5.final <- head(df.merge.nocameo[with(df.merge.nocameo, order(-V5)),], 50)
df.v6.final <- head(df.merge.nocameo[with(df.merge.nocameo, order(-V6)),], 50)
df.v7.final <- head(df.merge.nocameo[with(df.merge.nocameo, order(-V7)),], 50)
df.v8.final <- head(df.merge.nocameo[with(df.merge.nocameo, order(-V8)),], 50)
df.v9.final <- head(df.merge.nocameo[with(df.merge.nocameo, order(-V9)),], 50)
df.v10.final <- head(df.merge.nocameo[with(df.merge.nocameo, order(-V10)),], 50)

df.v1.final[is.na(df.v1.final$CAMEO), ]$CAMEO <- "042"
df.v2.final[is.na(df.v2.final$CAMEO), ]$CAMEO <- "051"
df.v3.final[is.na(df.v3.final$CAMEO), ]$CAMEO <- "190"
df.v4.final[is.na(df.v4.final$CAMEO), ]$CAMEO <- "042"
df.v5.final[is.na(df.v5.final$CAMEO), ]$CAMEO <- "111"
df.v6.final[is.na(df.v6.final$CAMEO), ]$CAMEO <- "051"
df.v7.final[is.na(df.v7.final$CAMEO), ]$CAMEO <- "051"
df.v8.final[is.na(df.v8.final$CAMEO), ]$CAMEO <- "020"
df.v9.final[is.na(df.v9.final$CAMEO), ]$CAMEO <- "111"
df.v10.final[is.na(df.v10.final$CAMEO), ]$CAMEO <- "036"

df.final <- rbind(
	data.frame(VerbPath = df.v1.final$DepParse, CAMEO = df.v1.final$CAMEO),
	data.frame(VerbPath = df.v2.final$DepParse, CAMEO = df.v2.final$CAMEO),
	data.frame(VerbPath = df.v3.final$DepParse, CAMEO = df.v3.final$CAMEO),
	data.frame(VerbPath = df.v4.final$DepParse, CAMEO = df.v4.final$CAMEO),
	data.frame(VerbPath = df.v5.final$DepParse, CAMEO = df.v5.final$CAMEO),
	data.frame(VerbPath = df.v6.final$DepParse, CAMEO = df.v6.final$CAMEO),
	data.frame(VerbPath = df.v7.final$DepParse, CAMEO = df.v7.final$CAMEO),
	data.frame(VerbPath = df.v8.final$DepParse, CAMEO = df.v8.final$CAMEO),
	data.frame(VerbPath = df.v9.final$DepParse, CAMEO = df.v9.final$CAMEO),
	data.frame(VerbPath = df.v10.final$DepParse, CAMEO = df.v10.final$CAMEO)
	)

write.csv(df.final, file = "verbPathCameo.csv")
