#' Minimal-looking light template for a beamer presentation following the University of Leicester visual identity guidelines, with an emphasis on typography
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
#' draft("my_presentation.Rmd", template = "miniuol", package = "templates")
#' }
#'
#' @export
miniuol <- function(...) {
  rmarkdown::beamer_presentation(
    ...,
    template = find_resource("miniuol", "template.tex"),
    keep_tex = TRUE,
    highlight = NULL,
    latex_engine = "xelatex"
  )
}
