library(stringr)

args <- commandArgs(TRUE)

if (length(args)>0){
    packages <- args
}else{
    packages <- c(
        "base",
        "graphics",
        "grDevices",
        "methods",
        "stats",
        "utils"
    )
}

ls_package <- function(pkg){
    members <- ls(pattern="*", paste0("package:",pkg))
    ind <- grep("^[a-zA-Z\\._][0-9a-zA-Z\\._]+$", members)
    out <- members[ind]
    attr(out, "package") <- pkg
    out
}

get_functions <- function(objs){
    pkg <- attr(objs, "package")
    e <- as.environment(paste0("package:", pkg))
    out <- Filter(function(x) {
            obj <- get(x, envir = e)
            is.function(obj)
        },
        objs
    )
    attr(out, "package") <- pkg
    out
}

template <-
"\t\t<dict>
\t\t\t<key>begin</key>
\t\t\t<string>\\b(foo)\\s*(\\()</string>
\t\t\t<key>beginCaptures</key>
\t\t\t<dict>
\t\t\t\t<key>1</key>
\t\t\t\t<dict>
\t\t\t\t\t<key>name</key>
\t\t\t\t\t<string>support.function.r</string>
\t\t\t\t</dict>
\t\t\t\t<key>2</key>
\t\t\t\t<dict>
\t\t\t\t\t<key>name</key>
\t\t\t\t\t<string>punctuation.definition.parameters.r</string>
\t\t\t\t</dict>
\t\t\t</dict>
\t\t\t<key>comment</key>
\t\t\t<string>base</string>
\t\t\t<key>contentName</key>
\t\t\t<string>meta.function-call.arguments.r</string>
\t\t\t<key>end</key>
\t\t\t<string>(\\))</string>
\t\t\t<key>endCaptures</key>
\t\t\t<dict>
\t\t\t\t<key>1</key>
\t\t\t\t<dict>
\t\t\t\t\t<key>name</key>
\t\t\t\t\t<string>punctuation.definition.parameters.r</string>
\t\t\t\t</dict>
\t\t\t</dict>
\t\t\t<key>name</key>
\t\t\t<string>meta.function-call.r</string>
\t\t\t<key>patterns</key>
\t\t\t<array>
\t\t\t\t<dict>
\t\t\t\t\t<key>include</key>
\t\t\t\t\t<string>#function-call-parameter</string>
\t\t\t\t</dict>
\t\t\t\t<dict>
\t\t\t\t\t<key>include</key>
\t\t\t\t\t<string>source.r</string>
\t\t\t\t</dict>
\t\t\t</array>
\t\t</dict>
"

templated_block <- function(pkg){
    content <- paste0(sub("\\.","\\\\\\\\.", get_functions(ls_package(pkg))), collapse="|")
    str_replace(template, "foo", content)
}

dict <- ""
for (pkg in packages){
    library(pkg, character.only=TRUE)
    dict <- paste0(dict, templated_block(pkg))
}

syntax_file <- "syntax/R Functions.tmLanguage"
content <- readChar(syntax_file, file.info(syntax_file)$size)
dict_begin <- str_locate(content,
    "<key>patterns</key>\\s*<array>\\s*\n")[2]
dict_end <- str_locate(content, "\n\\s*</array>\\s*<key>repository</key>")[1]

str_sub(content, dict_begin + 1, dict_end) <- dict

dir.create("syntax", FALSE)
cat(content, file=syntax_file)
