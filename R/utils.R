#' Wrap output to a given width
#'
#' \code{wrap_linewidth()} wrap the output from an R code chunk to a given width, specified by the global option \code{width}.
#' Usage is pretty straighforward: set the global \code{width} option to a given value, set the knitr chunk option \code{linewidth} to \code{getOption("width")}, and call \code{wrap_linewidth()}. See \url{https://github.com/yihui/knitr-examples/blob/master/077-wrap-output.Rmd}.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' options(width = 60)
#' knitr::opts_chunk$set(echo = FALSE, fig.align = "center", linewidth = getOption("width"))
#' uolvid:::wrap_linewidth()geocode("3817 Spruce St, Philadelphia, PA 19104")
#' }

wrap_linewidth = function() {
  hook_output = knitr::knit_hooks$get("output")
  knitr::knit_hooks$set(output = function(x, options) {
    # this hook is used only when the linewidth option is not NULL
    if (!is.null(n <- options$linewidth)) {
      x = knitr:::split_lines(x)
      # any lines wider than n should be wrapped
      if (any(nchar(x) > n)) x = strwrap(x, width = n)
      x = paste(x, collapse = '\n')
    }
    hook_output(x, options)
  })}

# Copied from rticles package:
find_file <- function(template, file) {
  template <- system.file("rmarkdown", "templates", template, file, package = "uolvid")
  if (template == "") {
    stop("Couldn't find template file ", template, "/", file, call. = FALSE)
  }

  template
}

find_resource <- function(template, file) {
  find_file(template, file.path("resources", file))
}

#' Copy default remark.js stylesheet to a given directory
#'
#' With \code{get_remarkjs_css()} you can copy the default stylesheet used for the UoL remark.js template to a given directory. This is useful if you want to tune the stylesheet yourself or implement new classes.
#' @param to where to copy the default stylesheet
#'
#' @return This function returns a logical value indicating whether the operation succeeded or not. Using a missing value for a file or path name will always be regarded as a failure: see \code{\link{file.copy}} for more details.
#' @export
#'
#' @examples
#' \dontrun{
#' # Copy the default stylesheet to the current working directory
#' get_remarkjs_css()
#'
#' # Copy the default stylesheet to the "temp" directory
#' get_remarkjs_css(to = "temp")
#' }

get_remarkjs_css <- function(to = getwd()) {
  file.copy(from = find_resource("uol_remarkjs", "uol_remarkjs.css"),
            to = to)
}
