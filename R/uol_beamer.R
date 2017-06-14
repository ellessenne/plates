#' A minimal beamer template following University of leicester visual identity guidelines
#'
#' Write something here...
#'
#' @inheritParams rmarkdown::beamer_presentation
#' @param ... Additional arguments to \code{rmarkdown::beamer_presentation}
#'
#' @return R Markdown output format to pass to \code{\link[rmarkdown:render]{render}}
#'
#' @examples
#'
#' \dontrun{
#' library(rmarkdown)
#' draft("my_presentation.Rmd", template = "uol_presentation", package = "uolvid")
#' }
#'
#' @export
uol_beamer <- function(...) {
  rmarkdown::beamer_presentation(...,
                                 template = find_resource("uol_beamer", "template.tex"),
                                 latex_engine = "xelatex",
                                 keep_tex = TRUE,
                                 highlight = NULL)
}