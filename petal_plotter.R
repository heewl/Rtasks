library(dplyr)
library(ggplot2)

# Read command-line arguments
args <- commandArgs(trailingOnly = TRUE)
species_a <- args[1]
species_b <- args[2]
image_size <- as.integer(args[3])

selected_species <- c(species_a, species_b)

# Filter data to the selected species
iris_subset <- datasets::iris |>
  filter(Species %in% selected_species)

# Build output filename
output_file <- paste0(
  "iris_",
  species_a,
  "_vs_",
  species_b,
  ".png"
)

# Create ggplot
species_plot <- iris_subset |>
  ggplot(aes(x = Petal.Width, y = Petal.Length, colour = Species)) +
  geom_point() +
  scale_colour_manual(
    values = c(
      setosa = "tomato",
      versicolor = "steelblue",
      virginica = "gold"
    )
  ) +
  labs(
    x = "Petal width",
    y = "Petal length",
    title = paste(species_a, "and", species_b)
  )

# Save plot
ggsave(
  filename = output_file,
  plot = species_plot,
  width = image_size,
  height = image_size,
  units = "px",
  dpi = 150
)

