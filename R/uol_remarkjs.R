#' A minimal Remark.js template following University of Leicester visual identity guidelines
#'
#' This format is a wrapper around [xaringan::moon_reader()]. It includes a custom .css file following visual identity guidelines issued by the University of Leicester.
#'
#' @inheritParams xaringan::moon_reader
#' @param ... Additional arguments passed to [xaringan::moon_reader()]
#'
#' @note Do not trust the preview of the presentation from the RStudio viewer or window. Instead, open the presentation with a web browser and refresh to see changes.
#'
#' @note Include `css: ["default", "uol_remarkjs"]` in the YAML header to include the standard `xaringan` stylesheet. That improves printing to PDF using Google Chrome, among others. More details on printing to PDF: [#65](https://github.com/yihui/xaringan/issues/65) and [here](https://github.com/yihui/xaringan/wiki/Export-Slides-to-PDF).
#' @examples
#'
#' \dontrun{
#' library(rmarkdown)
#' draft("my_presentation.Rmd", template = "uol_remarkjs", package = "uolvid")
#' }
#'
#' @export
uol_remarkjs <- function(..., css = "uol_remarkjs") {
  if ("uol_remarkjs" %in% css) css = c(setdiff(css, "uol_remarkjs"), find_resource("uol_remarkjs", "uol_remarkjs.css"))
  xaringan::moon_reader(css = css, ...)
}
