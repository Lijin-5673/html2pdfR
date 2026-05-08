#' Install external backend
#'
#' @param url HTTPS URL to a zip file containing the backend executable.
#' @param ask Logical; ask before downloading. Defaults to interactive().
#' @param overwrite Logical; overwrite an existing backend installation.
#' @param timeout Download timeout in seconds.
#' @param verbose Logical; show progress messages.
#'
#' @return Invisibly returns the installed executable path.
#' @export
install_html2pdf_backend <- function(
    url,
    ask = interactive(),
    overwrite = FALSE,
    timeout = 300,
    verbose = FALSE
) {
  if (!nzchar(url)) {
    stop("A download URL is required.", call. = FALSE)
  }
  
  target_dir <- backend_root()
  zip_file <- file.path(target_dir, "converter_backend.zip")
  unpack_dir <- backend_default_dir()
  
  if (dir.exists(unpack_dir) && !overwrite) {
    exe <- list.files(
      unpack_dir,
      pattern = "converter_backend\\.exe$",
      recursive = TRUE,
      full.names = TRUE
    )
    if (length(exe) > 0) {
      set_html2pdf_backend(exe[1])
      return(invisible(exe[1]))
    }
  }
  
  if (ask) {
    ans <- utils::menu(
      c("Yes", "No"),
      title = "Download external HTML-to-PDF backend?"
    )
    if (ans != 1) {
      stop("Installation cancelled by user.", call. = FALSE)
    }
  }
  
  dir.create(target_dir, recursive = TRUE, showWarnings = FALSE)
  
  old_timeout <- getOption("timeout")
  on.exit(options(timeout = old_timeout), add = TRUE)
  options(timeout = max(timeout, old_timeout))
  
  if (verbose) {
    message("Downloading backend archive.")
  }
  
  utils::download.file(url, destfile = zip_file, mode = "wb", quiet = !verbose)
  
  if (dir.exists(unpack_dir)) {
    unlink(unpack_dir, recursive = TRUE, force = TRUE)
  }
  dir.create(unpack_dir, recursive = TRUE, showWarnings = FALSE)
  
  if (verbose) {
    message("Unpacking backend archive.")
  }
  
  utils::unzip(zip_file, exdir = unpack_dir)
  
  exe <- list.files(
    unpack_dir,
    pattern = "converter_backend\\.exe$",
    recursive = TRUE,
    full.names = TRUE
  )
  
  if (!length(exe)) {
    stop("Backend executable not found after download and unzip.", call. = FALSE)
  }
  
  exe <- normalizePath(exe[1], winslash = "/", mustWork = TRUE)
  set_html2pdf_backend(exe)
  
  if (verbose) {
    message("Backend installed successfully.")
  }
  
  invisible(exe)
}
