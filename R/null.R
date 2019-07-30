#' A streamlined beamer template based on the default theme
#'
#' @description A streamlined beamer template absed on the default theme
#' @inheritParams rmarkdown::beamer_presentation
#' @param ... Additional arguments to [rmarkdown::beamer_presentation()]
#'
#' @return R Markdown output format to pass to [rmarkdown::render()]
#'
#' @examples
#'
#' \dontrun{
#' library(rmarkdown)
#' draft("my_presentation.Rmd", template = "null", package = "uolvid")
#' }
#'
#' @export
null <- function(...) {
  rmarkdown::beamer_presentation(
    ...,
    template = find_resource("null", "template.tex"),
    highlight = NULL,
    latex_engine = "pdflatex"
  )
}
