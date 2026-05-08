#' Get backend root directory
#'
#' @return Path to the package user data directory.
backend_root <- function() {
  tools::R_user_dir("html2pdfR", which = "data")
}

#' Get backend config file path
#'
#' @return Path to the config file storing backend executable location.
backend_config_file <- function() {
  file.path(backend_root(), "backend_path.txt")
}

#' Get default backend directory
#'
#' @return Path to the default backend installation directory.
backend_default_dir <- function() {
  file.path(backend_root(), "converter_backend")
}

#' Get default backend executable path
#'
#' @return Path to the default converter executable.
backend_default_exe <- function() {
  file.path(backend_default_dir(), "converter_backend.exe")
}

#' Find configured backend executable
#'
#' @return Path to backend executable, or an empty string if not found.
#' @export
find_html2pdf_backend <- function() {
  cfg <- backend_config_file()
  
  if (file.exists(cfg)) {
    p <- trimws(readLines(cfg, warn = FALSE, encoding = "UTF-8"))
    if (length(p) > 0 && nzchar(p[1]) && file.exists(p[1])) {
      return(normalizePath(p[1], winslash = "/", mustWork = TRUE))
    }
  }
  
  p <- backend_default_exe()
  if (file.exists(p)) {
    return(normalizePath(p, winslash = "/", mustWork = TRUE))
  }
  
  ""
}

#' Set backend executable path
#'
#' @param path Path to the backend executable.
#'
#' @return Invisibly returns the normalized backend path.
#' @export
set_html2pdf_backend <- function(path) {
  path <- normalizePath(path, winslash = "/", mustWork = TRUE)
  dir.create(backend_root(), recursive = TRUE, showWarnings = FALSE)
  writeLines(path, backend_config_file(), useBytes = TRUE)
  invisible(path)
}
