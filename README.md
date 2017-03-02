# uolvid

`uolvid` is an R package for generating colour palettes following the University of Leicester [visual identity guidelines](http://www2.le.ac.uk/offices/cap/marcomms/creative/identity).

Included are:

- `uol_colours`, a list of all the codes in HEX format;

- `get_uol_palette()`, `get_uol_palette_mono()`, and `get_uol_palette_manual()`, three functions to obtain various colour palettes.

# Installation

Install the package from Github using `devtools`:

```r
library(devtools)
devtools::install_github("ellessenne/uolvid")
```
# Usage

Usage of this package is very simple: it is enough to call a palette generator function and store it in a variable:

```r
library(uolvid)
palette <- get_uol_palette(n = 4)
palette
```

A basic example using `ggplot2`:

```r
library(ggplot2)
ggplot(mpg, aes(cty, hwy, color = factor(cyl))) +
  geom_point() +
  scale_color_manual(values = palette)
```

# To-do

A non-exhaustive list of future developments includes:

- [ ] `ggplot2` custom `scale_color_*` and `scale_fill_*` functions;

- [ ] a whole `ggplot2` theme;

- [ ] ...
