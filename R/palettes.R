#' @title Monochromatic colour palette
#'
#' @description [get_uol_palette_mono()] return a monochromatic palette of colours following the University of Leicester visual identity guidelines. It is possible to select the colour and the number of values on the same monochromatic scale.
#'
#' @family get palettes
#' @param n Number of colours for the desired palette. Defaults to 3.
#' @param colour A vector of colour names. See [`uol_colours`] for a list of possible colours.
#' @return A vector of colours, in HEX format.
#' @details It is recommended to use not more than `n = 3` colours, as in that case additional colours are picked by interpolation.
#' @import grDevices
#' @export
#'
#' @examples
#' get_uol_palette_mono()
#' get_uol_palette_mono(colour = "blue")
#' get_uol_palette_mono(colour = "red", n = 2)

get_uol_palette_mono <- function(colour = c("blue", "grey", "brown", "pink", "yellow", "green", "red", "purple", "lightblue", "orange", "brightgreen"), n = 3) {
  colour = match.arg(colour)
  if (n > 3) warning("n > 3: colours will be interpolated (not recommended).")

  pal = uol_colours[[colour]]

  out = if (n == 1) {
    pal[1]
    } else if (n == 2) {
      pal[1:2]
    } else if (n == 3) {
      pal
    } else {
      colorRampPalette(pal)(n)
    }
  names(out) <- NULL
  structure(out, class = "palette", colour = colour, palette = "mono")
}

#' @title Colours palette generator
#'
#' @description [get_uol_palette()] return a vector of colours following the University of Leicester visual identity guidelines. It is possible to select the intensity of the palette, the number of colours, and the method used to pick colours. When a palette of 4-10 colours is requested, the colours in the full palette are sorted by the aforementioned method first, and then the required number of colours are selected by picking equally spaced colours on the ranks scale.
#'
#' @family get palettes
#' @param n Number of colours for the desired palette. Defaults to 3.
#' @param intensity Intensity of the desired palette. Possible values are `full`, `medium`, `light`. Defaults to `full`.
#' @param method Method used to pick colours. Possible values are `hue`, `saturation`, `brightness`. Defaults to `hue`.
#' @return A vector of colours, in HEX format.
#' @details It is recommended to use not more than `n = 11` colours, as in that case additional colours are picked by interpolation.
#' @import grDevices
#' @export
#'
#' @examples
#' get_uol_palette()
#' get_uol_palette(n = 5)
#' get_uol_palette(n = 5, intensity = "medium")
#' get_uol_palette(n = 5, method = "brightness")
#'
#' library(ggplot2)
#' pl = get_uol_palette(n = 10)
#' ggplot(mpg, aes(cty, hwy, color = factor(cyl))) +
#' geom_point() +
#' scale_color_manual(values = pl)
get_uol_palette = function(n = 3, intensity = c("full", "medium", "light"), method = c("hue", "saturation", "brightness")) {
  intensity = match.arg(intensity)
  method = match.arg(method)
  if (n < 2) stop("To get monochromatic palettes use the 'get_uol_palette_mono()' function.")
  if (n > 11) warning("n > 11 not recommended: colors will be interpolated.")

  # Get colors
  pal = switch(intensity,
               full = sapply(uol_colours, function(x) x[1]),
               medium = sapply(uol_colours, function(x) x[2]),
               light = sapply(uol_colours, function(x) x[3]))

  # Get order quantity
  ordq = switch(method,
                hue = rgb2hsv(col2rgb(pal))["h",],
                saturation = rgb2hsv(col2rgb(pal))["s",],
                brightness = rgb2hsv(col2rgb(pal))["v",])

  # Make palette
  # Algorithm for n = 2: pick red, blue
  # For n = 3: pick red, blue, brightgreen
  # For n in [4, 11): select n values equally spaced on the ranks scale
  # For n = 11, that resolves to taking all the colors
  # For n > 11, missing colors will be interpolated, after sorting by the mixed scale (option not recommended)

  out = if (n == 2) {
    pal[c("blue", "red")]
  } else if (n == 3) {
    pal[c("blue", "red", "brightgreen")]
  } else if (n > 3 && n <= 11) {
    pal[order(ordq) %in% floor(seq(1, length(pal), length.out = n))]
  } else {
    colorRampPalette(pal[order(ordq)])(n)
  }
  names(out) <- NULL
  # Return object of class 'palette'
  structure(out, class = "palette", intensity = intensity, palette = method)
}

#' @title Manual colours palette generator
#'
#' @description [get_uol_palette_manual()] return a vector of colours following the University of Leicester visual identity guidelines. It is possible to select the intensity of the palette, the number of colours, and the method used to pick colours. When a palette of 4-10 colours is requested, the colours in the full palette are sorted by the aforementioned method first, and then the required number of colours are selected by picking equally spaced colours on the ranks scale.
#'
#' @family get palettes
#' @param colours A vector of colour names. See [`uol_colours`] for a list of possible colours.
#' @param intensity Intensity of the desired palette. Possible values are `full`, `medium`, `light`. Defaults to `full`.
#' @return A vector of colours, in HEX format.
#' @export
#'
#' @examples
#' get_uol_palette_manual(c("red", "blue", "yellow"))
#' get_uol_palette_manual(c("red", "blue", "yellow"), intensity = "medium")
get_uol_palette_manual = function(colours, intensity = c("full", "medium", "light")) {
  intensity = match.arg(intensity)
  if (!all(colours %in% c("blue", "grey", "brown", "pink", "yellow", "green", "red", "purple", "lightblue", "orange", "brightgreen"))) stop("Unknown colour. See ?uol_colours for a list of available colours.")
  if (length(colours) < 2) stop("Use get_uol_palette_mono() for a monochromatic palette.")

  pal = switch(intensity,
               full = sapply(uol_colours, function(x) x[1]),
               medium = sapply(uol_colours, function(x) x[2]),
               light = sapply(uol_colours, function(x) x[3]))
  out = pal[colours]
  names(out) <- NULL
  structure(out, class = "palette", intensity = intensity, palette = "manual")
}

#' @import graphics
#' @export
print.palette = function(x, ...) {
  n = length(x)
  old = par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))
  image(1:n, 1, as.matrix(1:n), col = x, ylab = "", xaxt = "n", yaxt = "n", bty = "n")
  rect(0, 0.95, n + 1, 1.05, col = rgb(1, 1, 1, 2/3), border = NA)
  text((n + 1) / 2, 1, labels = ifelse(attr(x, "palette") == "mono", paste("Monochromatic palette:", attr(x, "colour")), ifelse(attr(x, "palette") == "manual", paste("Manual palette with intensity:", attr(x, "intensity")), paste0("Palette with intensity: ", attr(x, "intensity"), ", method: ", attr(x, "palette")))), cex = 1)
}
