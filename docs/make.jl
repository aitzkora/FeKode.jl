using Documenter
using FeKode

makedocs(
    sitename = "FeKode",
    doctest=false,
    format = Documenter.HTML(),
    modules = [FeKode],
    pages = ["Documentation" => "index.md"]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
           deps = Deps.pip("mkdocs", "python-markdown-math"),
    repo = "github.com/aitzkora/FeKode.jl.git"
)
