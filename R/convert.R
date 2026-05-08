#' Convert local 'HTML' or 'XHTML' file to 'PDF'
#'
#' @param input Path to a local HTML, HTM, or XHTML file.
#' @param verbose Logical; show progress messages.
#'
#' @return Invisibly returns the expected output PDF path.
#' @export
#'
#' @examples
#' \dontrun{
#' set_html2pdf_backend("C:/path/to/converter_backend.exe")
#' convert_html_to_pdf("C:/path/to/file.xhtml")
#' }
convert_html_to_pdf <- function(input, verbose = FALSE) {
  input <- normalizePath(input, winslash = "/", mustWork = TRUE)
  exe <- find_html2pdf_backend()
  
  if (!nzchar(exe) || !file.exists(exe)) {
    stop(
      paste(
        "Backend not configured.",
        "Run install_html2pdf_backend(<download-url>)",
        "or set_html2pdf_backend(<path-to-exe>)."
      ),
      call. = FALSE
    )
  }
  
  if (verbose) {
    message("Starting conversion.")
  }
  
  out <- system2(
    command = exe,
    args = shQuote(input),
    stdout = TRUE,
    stderr = TRUE
  )
  
  status <- attr(out, "status")
  if (is.null(status)) {
    status <- 0
  }
  
  if (status != 0) {
    stop(paste(out, collapse = "\n"), call. = FALSE)
  }
  
  if (verbose) {
    message("Conversion completed successfully.")
  }
  
  invisible(sub("\\.[^.]+$", ".pdf", input))
}
