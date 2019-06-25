#' A minimal, white beamer template following University of Leicester visual identity guidelines
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
#' draft("my_presentation.Rmd", template = "uol_beamer_white", package = "uolvid")
#' }
#'
#' @export
uol_beamer_white <- function(...) {
  rmarkdown::beamer_presentation(
    ...,
    template = find_resource("uol_beamer_white", "template.tex"),
    keep_tex = TRUE,
    highlight = NULL
  )
}
