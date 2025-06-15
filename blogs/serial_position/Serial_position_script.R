require(tidyverse)
require(cowplot)

# make sure you change this to the location of your WD if you're not using an R project 
serial.dat <- read_csv("serial_position_data.csv")

serial_long <- gather(serial.dat, "serial_position", "Correct", -Participant)

# the ordering can get messed up later on, so it's important to convert the position
# to an ordered factor
serial_long$serial_position <- factor(serial_long$serial_position,
                                      levels = paste("SP", 1:20, sep = ""),
                                      ordered = T)

serial_long <- serial_long %>% 
  group_by(serial_position) %>% 
  summarise(prop_correct = mean(Correct))

serial_long %>% 
  ggplot(aes(x = serial_position, y = prop_correct*100, group = 1)) + 
  geom_point() + 
  geom_line() +
  ylab("Proportion correct (%)") + 
  xlab("Serial position") + 
  scale_y_continuous(limits = c(0, 100),
                     breaks = seq(0, 100, 20)) + 
  scale_x_discrete(breaks = paste("SP", 1:20, sep = ""),
                   labels = as.character(1:20))
