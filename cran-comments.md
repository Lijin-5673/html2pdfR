## Test environments

- Local Windows 11 x64
- R 4.5.1
- `devtools::test()` passed
- `devtools::check()` completed with 0 errors and 0 warnings

## R CMD check results

0 errors | 0 warnings | 0 notes

## Submission notes

`html2pdfR` provides functions for converting local 'HTML' and
'XHTML' files to 'PDF' using an external backend.

The package itself does not bundle third-party executable binaries inside
the package source.

The package provides helper functions to:

- configure an existing backend path with `set_html2pdf_backend()`
- install an external backend with `install_html2pdf_backend()`
- convert local files with `convert_html_to_pdf()`
- launch an optional 'Tk' graphical interface with `launch_html2pdf_app()`

No external backend is downloaded or installed during package
installation, examples, or tests.

The package is pure R code and does not contain compiled code.
