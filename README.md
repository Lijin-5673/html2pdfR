# \# html2pdfR

# 

# `html2pdfR` is an R package for converting local HTML, HTM, and XHTML files to PDF using an external backend.

# 

# \## Features

# 

# \- Convert HTML/XHTML files to PDF

# \- Configure an external converter backend

# \- Optional Tk GUI for interactive use

# \- CRAN-friendly source package design without bundled executables

# 

# \## Installation

# 

# ```r

# \# install.packages("remotes")

# remotes::install\_github("Lijin-5673/html2pdfR")

# ```

# 

# \## Basic usage

# 

# ```r

# library(html2pdfR)

# 

# \# Set an existing backend manually

# set\_html2pdf\_backend("C:/path/to/converter\_backend.exe")

# 

# \# Convert a file

# convert\_html\_to\_pdf("C:/path/to/file.xhtml")

# ```

# 

# \## Backend setup

# 

# This package does not bundle third-party executables.  

# Use one of these approaches:

# 

# \- Point to an existing backend with `set\_html2pdf\_backend()`

# \- Download a backend with `install\_html2pdf\_backend()`

# 

# \## License

# 

# GPL-3

