test_that("find_html2pdf_backend returns empty string when no backend is configured", {
  old_cfg <- backend_config_file()
  had_cfg <- file.exists(old_cfg)
  tmp_backup <- tempfile(fileext = ".txt")
  
  if (had_cfg) {
    file.copy(old_cfg, tmp_backup, overwrite = TRUE)
    unlink(old_cfg)
  }
  
  on.exit({
    if (file.exists(old_cfg)) {
      unlink(old_cfg)
    }
    if (had_cfg && file.exists(tmp_backup)) {
      file.copy(tmp_backup, old_cfg, overwrite = TRUE)
    }
  }, add = TRUE)
  
  expect_identical(find_html2pdf_backend(), "")
})

test_that("set_html2pdf_backend errors for missing path", {
  expect_error(
    set_html2pdf_backend(tempfile(fileext = ".exe"))
  )
})

test_that("convert_html_to_pdf errors when backend is not configured", {
  html_file <- tempfile(fileext = ".html")
  writeLines("<html><body><h1>Test</h1></body></html>", html_file)
  
  old_cfg <- backend_config_file()
  had_cfg <- file.exists(old_cfg)
  tmp_backup <- tempfile(fileext = ".txt")
  
  if (had_cfg) {
    file.copy(old_cfg, tmp_backup, overwrite = TRUE)
    unlink(old_cfg)
  }
  
  on.exit({
    if (file.exists(old_cfg)) {
      unlink(old_cfg)
    }
    if (had_cfg && file.exists(tmp_backup)) {
      file.copy(tmp_backup, old_cfg, overwrite = TRUE)
    }
  }, add = TRUE)
  
  expect_error(
    convert_html_to_pdf(html_file),
    "Backend not configured"
  )
})