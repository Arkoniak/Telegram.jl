include("tg_scrape.jl")

const main_html = getmain()

const page = matchFirst(sel"div#dev_page_content", main_html)

const funcs = process_page(page)
create_api(funcs, joinpath("..", "src", "telegram_api.jl"))
create_docs(funcs, joinpath("..", "docs", "src", "reference.md"))
