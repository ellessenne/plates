#' A minimal, coloured beamer template following University of Leicester visual identity guidelines
#'
#' @description A beamer template following University of Leicester visual identity guidelines
#' @inheritParams rmarkdown::beamer_presentation
#' @param ... Additional arguments to [rmarkdown::beamer_presentation()]
#'
#' @return R Markdown output format to pass to [rmarkdown::render()]
#'
#' @examples
#'
#' \dontrun{
#' library(rmarkdown)
#' draft("my_presentation.Rmd", template = "uol_beamer_colour", package = "templates")
#' }
#'
#' @export
uol_beamer_colour <- function(...) {
  rmarkdown::beamer_presentation(
    ...,
    template = find_resource("uol_beamer_colour", "template.tex"),
    keep_tex = TRUE,
    highlight = NULL
  )
}
