install.packages('dplyr')
install.packages('readr')
install.packages('stringr')
install.packages('tidyr')
install.packages('assertive')
install.packages('ggplot2')
# Library
library(dplyr)
library(readr)
library(stringr)
library(tidyr)
library(assertive)
library(ggplot2)

topComputerBooks <- read_csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")
glimpse(topComputerBooks)
View(topComputerBooks)

# 1. 5 �ѹ�Ѻ�á�ͧ˹ѧ��ͻ����� "Hardcover" ����ըӹǹ��� Reviews �ҡ����ش
topComputerBooks %>% filter(Type == "Hardcover") %>% arrange(desc(Reviews)) %>% head(n=5) %>% 
select(-Rating, -Number_Of_Pages, -Description, Rating)

# 2. ˹ѧ�����˹���ҡ����� 150 ˹�� ������Թ 300 ˹��
topComputerBooks %>% arrange(Number_Of_Pages) %>% filter(Number_Of_Pages > 150 & Number_Of_Pages < 300) %>%
select(Book_title, Number_Of_Pages, Price)

# 3. ˹ѧ������Ҥ��ҡ���Ҥ������¢ͧ�Ҥ�˹ѧ��ͷ�����
topComputerBooks %>% filter(Price > mean(Price))

# 4. ��� Index �ͧ˹ѧ��ͷ���դ���� "Machine" ����� Description
result <- grep("[mM]achine", topComputerBooks$Description)
print(result)
length(result)

# 5. �ӹǹ�ͧ����˹ѧ��� ����դ���� "Network" ����㹪���˹ѧ���
result2 <- grep("[nN]etwork", topComputerBooks$Book_title)
length(result2)

# 6. ��ṹ Rating ����ӷ���ش�ͧ˹ѧ�������� Type
topComputerBooks %>% group_by(Type) %>% summarise(Worst_Rating = min(Rating))

# Graph 1
topComputerBooks %>% filter(Number_Of_Pages < mean(Number_Of_Pages)) %>% ggplot(aes(x=Number_Of_Pages,y=Price))+ geom_point() +
  geom_point(aes(color=Type))+ ggtitle("Relationship between Number of pages and Price from each type of books") + geom_smooth()

# Graph 2
ggplot(data = topComputerBooks) + geom_bar(mapping = aes(x = Type, fill = Type)) + 
  ggtitle("Number of each type of books")
                                             