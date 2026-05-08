#' Launch GUI for HTML/XHTML to PDF conversion
#'
#' @return Opens a Tk GUI for file selection and conversion.
#' @export
launch_html2pdf_app <- function() {
  backend_exe <- find_html2pdf_backend()
  
  if (!nzchar(backend_exe) || !file.exists(backend_exe)) {
    stop(
      "Backend not configured. Run install_html2pdf_backend(<download-url>) first.",
      call. = FALSE
    )
  }
  
  selected_file <- NULL
  file_var <- tcltk::tclVar("No file selected")
  status_var <- tcltk::tclVar("Waiting...")
  is_running <- FALSE
  anim_value <- 0
  anim_direction <- 1
  
  write_log <- function(msg) {
    tcltk::tkinsert(log_text, "end", paste0(msg, "\n"))
    tcltk::tkyview.moveto(log_text, 1)
    tcltk::tcl("update")
  }
  
  set_status <- function(msg) {
    tcltk::tclvalue(status_var) <- msg
    tcltk::tcl("update")
  }
  
  animate_progress <- function() {
    if (!is_running) {
      return()
    }
    
    anim_value <<- anim_value + (anim_direction * 6)
    
    if (anim_value >= 100) {
      anim_value <<- 100
      anim_direction <<- -1
    } else if (anim_value <= 0) {
      anim_value <<- 0
      anim_direction <<- 1
    }
    
    tcltk::tkconfigure(progress, value = anim_value)
    tcltk::tcl("after", 90, animate_progress)
  }
  
  start_progress_animation <- function() {
    is_running <<- TRUE
    animate_progress()
  }
  
  stop_progress_animation <- function(final_value = 0) {
    is_running <<- FALSE
    tcltk::tkconfigure(progress, value = final_value)
    tcltk::tcl("update")
  }
  
  choose_file <- function() {
    file <- tcltk::tclvalue(tcltk::tkgetOpenFile(
      title = "Choose HTML or XHTML file",
      filetypes = "{{HTML/XHTML files} {.html .htm .xhtml}} {{All files} *}"
    ))
    
    if (nzchar(file)) {
      selected_file <<- normalizePath(file, winslash = "/", mustWork = TRUE)
      tcltk::tclvalue(file_var) <- selected_file
      tcltk::tkconfigure(convert_btn, state = "normal")
    }
  }
  
  start_conversion <- function() {
    if (is.null(selected_file) || !nzchar(selected_file)) {
      tcltk::tkmessageBox(
        title = "Error",
        message = "Please choose an HTML/XHTML file first.",
        icon = "error",
        type = "ok"
      )
      return()
    }
    
    tcltk::tkdelete(log_text, "1.0", "end")
    anim_value <<- 0
    anim_direction <<- 1
    
    set_status("Starting conversion")
    tcltk::tkconfigure(choose_btn, state = "disabled")
    tcltk::tkconfigure(convert_btn, state = "disabled")
    start_progress_animation()
    tcltk::tcl("update")
    
    output <- tryCatch(
      {
        set_status("Running converter")
        system2(
          command = backend_exe,
          args = shQuote(selected_file),
          stdout = TRUE,
          stderr = TRUE
        )
      },
      error = function(e) {
        structure(c(paste("Error:", conditionMessage(e))), status = 1)
      }
    )
    
    status <- attr(output, "status")
    if (is.null(status)) {
      status <- 0
    }
    
    if (length(output) > 0) {
      for (line in output) {
        write_log(line)
        tcltk::tcl("update")
      }
    }
    
    tcltk::tkconfigure(choose_btn, state = "normal")
    tcltk::tkconfigure(convert_btn, state = "normal")
    
    if (status == 0) {
      stop_progress_animation(100)
      set_status("Done")
      output_pdf <- sub("\\.[^.]+$", ".pdf", selected_file)
      
      tcltk::tkmessageBox(
        title = "Success",
        message = paste("PDF created successfully:\n\n", output_pdf),
        icon = "info",
        type = "ok"
      )
    } else {
      stop_progress_animation(0)
      set_status("Failed")
      
      tcltk::tkmessageBox(
        title = "Error",
        message = "Conversion failed. See the log output.",
        icon = "error",
        type = "ok"
      )
    }
  }
  
  tt <- tcltk::tktoplevel()
  tcltk::tkwm.title(tt, "HTML/XHTML to PDF Converter")
  tcltk::tkwm.geometry(tt, "780x480")
  
  top_frame <- tcltk::ttkframe(tt, padding = 12)
  tcltk::tkpack(top_frame, fill = "x")
  
  file_label <- tcltk::ttklabel(top_frame, textvariable = file_var)
  tcltk::tkpack(file_label, anchor = "w", pady = c(0, 8))
  
  button_frame <- tcltk::ttkframe(top_frame)
  tcltk::tkpack(button_frame, fill = "x")
  
  choose_btn <- tcltk::ttkbutton(
    button_frame,
    text = "Choose File",
    command = choose_file
  )
  tcltk::tkpack(choose_btn, side = "left", padx = c(0, 8))
  
  convert_btn <- tcltk::ttkbutton(
    button_frame,
    text = "Convert to PDF",
    command = start_conversion,
    state = "disabled"
  )
  tcltk::tkpack(convert_btn, side = "left")
  
  progress <- tcltk::ttkprogressbar(
    tt,
    mode = "determinate",
    maximum = 100,
    value = 0
  )
  tcltk::tkpack(progress, fill = "x", padx = 12, pady = c(6, 10))
  
  status_label <- tcltk::ttklabel(tt, textvariable = status_var)
  tcltk::tkpack(status_label, anchor = "w", padx = 12)
  
  log_text <- tcltk::tktext(tt, height = 20, wrap = "word")
  tcltk::tkpack(log_text, fill = "both", expand = TRUE, padx = 12, pady = 12)
  
  tcltk::tkfocus(tt)
  tcltk::tkwait.window(tt)
}