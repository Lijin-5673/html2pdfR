# html2pdfR

html2pdfR is an R package for converting local HTML, HTM, and XHTML files to PDF using an external backend.

## Overview

The package provides a simple R interface for HTML-to-PDF conversion.

The R package contains only R code and documentation, while the converter backend is configured separately by the user.

## Features

- Convert HTML, HTM, and XHTML files to PDF
- Configure an external converter backend
- Launch an optional Tk GUI for interactive use
- Keep package source separate from third-party executables

## Installation

```r
# install.packages("remotes")
remotes::install_github("Lijin-5673/html2pdfR")
```

## Backend setup

This package does not bundle third-party executable binaries.

You can either:

- set an existing backend path with `set_html2pdf_backend()`
- download and install a backend with `install_html2pdf_backend()`

## Basic usage

```r
library(html2pdfR)

set_html2pdf_backend("C:/path/to/converter_backend.exe")
convert_html_to_pdf("C:/path/to/file.xhtml")
```

## GUI usage

```r
library(html2pdfR)

set_html2pdf_backend("C:/path/to/converter_backend.exe")
launch_html2pdf_app()
```

## Main functions

- `find_html2pdf_backend()`
- `set_html2pdf_backend(path)`
- `install_html2pdf_backend(url)`
- `convert_html_to_pdf(input)`
- `launch_html2pdf_app()`

## Notes

- The backend executable is managed outside the package source.
- The current setup assumes a local executable such as `converter_backend.exe`.
- The package is in early development.

## License

GPL-3