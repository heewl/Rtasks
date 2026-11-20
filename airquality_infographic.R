# Usage: Rscript airquality_infographic.R <output_file.png>
# Exact command that produced the committed image:
#   Rscript airquality_infographic.R airquality_infographic.png

suppressPackageStartupMessages(library(tidyverse))

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1 || !grepl("\\.png$", args[1], ignore.case = TRUE)) {
  stop("Please provide one .png output filename.\nExample: Rscript airquality_infographic.R airquality_infographic.png", call. = FALSE)
}

output_file <- args[1]

aq_clean <- datasets::airquality |>
  filter(!is.na(Ozone), !is.na(Solar.R))

p <- ggplot(aq_clean, aes(x = Solar.R, y = Ozone, colour = Temp)) +
  geom_point(size = 3, alpha = 0.85) +
  geom_smooth(method = "lm", se = FALSE, colour = "grey30", linetype = "dashed") +
  scale_colour_viridis_c(option = "plasma", name = "Temp (°F)") +
  labs(
    title    = "Sunlight and summer heat cook up ground-level ozone",
    subtitle = "Daily New York ozone levels vs. solar radiation and temperature (May–Sept 1973, n = 111 complete days)",
    x        = "Solar Radiation (Langleys)",
    y        = "Ozone (ppb)",
    caption  = "Source: datasets::airquality"
  ) +
  theme_minimal(base_size = 13)

ggsave(filename = output_file, plot = p, width = 9, height = 5.5, dpi = 300)