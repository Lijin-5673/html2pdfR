# html2pdfR

html2pdfR is an R package for converting local HTML and XHTML files to PDF using an external backend.

## Overview

The package provides a simple R interface for XHTML-to-PDF conversion.

The R package contains only R code and documentation. The required backend files are managed separately and can be downloaded when needed.

## Features

- Convert HTML and XHTML files to PDF
- Download and configure the required backend automatically
- Launch an optional Tk GUI for interactive use
- Keep package source separate from third-party executables

## Installation

```r
# install.packages("remotes")
remotes::install_github("Lijin-5673/html2pdfR")
```

## Backend setup

This package does not bundle third-party executable binaries inside the R package source.

If the backend is not already installed, the package can download it from the project's GitHub Releases.

You can also install the backend manually:

```r
library(html2pdfR)
install_html2pdf_backend()
```

Or set the path to an existing backend executable:

```r
library(html2pdfR)
set_html2pdf_backend("C:/path/to/converter_backend.exe")
```

## Basic usage

```r
library(html2pdfR)

convert_html_to_pdf("C:/path/to/file.xhtml")
```

If the backend is missing, the package will prompt to install it during interactive use.

## GUI usage

```r
library(html2pdfR)

launch_html2pdf_app()
```

The GUI will prompt to download the backend if it is not already installed.

## Main functions

- `find_html2pdf_backend()`
- `set_html2pdf_backend(path)`
- `install_html2pdf_backend(url = NULL)`
- `convert_html_to_pdf(input)`
- `launch_html2pdf_app()`

## Notes

- The backend executable is managed outside the package source.
- Backend files are intended to be downloaded from GitHub Releases.
- The package is currently focused on interactive desktop use.

## License

GPL-3
