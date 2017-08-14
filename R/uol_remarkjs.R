#' A minimal Remark.js template following University of leicester visual identity guidelines
#'
#' Write something here...
#'
#' @inheritParams xaringan::moon_reader
#' @param ... Additional arguments to \code{xaringan::moon_reader}
#'
#' @return R Markdown output format to pass to \code{\link[rmarkdown:render]{render}}
#'
#' @examples
#'
#' \dontrun{
#' library(rmarkdown)
#' draft("my_presentation.Rmd", template = "uol_remarkjs", package = "uolvid")
#' }
#'
#' @export
uol_remarkjs <- function(..., css = "default") {
  if ("default" %in% css) css = c(setdiff(css, "default"), find_resource("uol_remarkjs", "uol_remarkjs.css"))
  xaringan::moon_reader(css = css, ...)
}
