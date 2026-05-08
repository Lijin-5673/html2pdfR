## Test environments

- Local Windows 11 x64
- R 4.5.1
- `devtools::check()` completed with 0 errors, 0 warnings, and 0 notes

## R CMD check results

0 errors | 0 warnings | 0 notes

## Submission notes

`html2pdfR` provides functions for converting local 'HTML', 'HTM', and 'XHTML'
files to 'PDF' using an external backend configured by the user.

The package itself does not bundle third-party executable binaries.

The package includes helper functions that allow users to:

- configure an existing backend path with `set_html2pdf_backend()`
- optionally download and install an external backend with
  `install_html2pdf_backend()`
- convert local files with `convert_html_to_pdf()`
- launch an optional 'Tk' graphical interface with `launch_html2pdf_app()`

No external backend is downloaded or installed during package installation,
examples, tests, or vignette building.

Examples are written so they do not require the external backend during checks.

The package is pure R code and does not contain compiled code.

The optional backend installer is only executed when called explicitly by the
user.