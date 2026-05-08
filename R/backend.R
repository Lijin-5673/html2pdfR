#' Backend release URL
#'
#' @return URL to the backend zip file hosted on GitHub Releases.
backend_release_url <- function() {
  "https://github.com/Lijin-5673/html2pdfR/releases/download/backend-v1/converter_backend.zip"
}

#' Ensure backend is available
#'
#' @param ask Logical; ask before downloading when interactive.
#' @param verbose Logical; show progress messages.
#'
#' @return Path to the backend executable.
#' @keywords internal
ensure_html2pdf_backend <- function(ask = interactive(), verbose = FALSE) {
  exe <- find_html2pdf_backend()
  
  if (nzchar(exe) && file.exists(exe)) {
    return(exe)
  }
  
  if (!ask) {
    stop(
      paste(
        "Backend not configured.",
        "Run install_html2pdf_backend() first,",
        "or call launch_html2pdf_app() in an interactive session."
      ),
      call. = FALSE
    )
  }
  
  if (interactive() && capabilities("tcltk")) {
    ans <- tcltk::tkmessageBox(
      title = "Backend Required",
      message = paste(
        "The HTML-to-PDF backend is not installed.",
        "Do you want to download it now?"
      ),
      icon = "question",
      type = "yesno",
      default = "yes"
    )
    
    if (as.character(ans) != "yes") {
      stop("Backend installation cancelled.", call. = FALSE)
    }
  }
  
  install_html2pdf_backend(
    url = backend_release_url(),
    ask = FALSE,
    verbose = verbose
  )
}