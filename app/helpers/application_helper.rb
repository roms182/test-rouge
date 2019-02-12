module ApplicationHelper
  def rouge(text, language)
    formatter = Rouge::Formatters::HTML.new(css_class: 'highlight')
    formatter = Rouge::Formatters::HTMLLinewise.new(formatter, class: 'highlight')
    lexer = Rouge::Lexer.find(language).new
    formatter.format(lexer.lex(text))
  end

  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'
  # Custom renderer for Markdown syntax
  class RougeRenderer < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def format_ruby_code(code)
    Redcarpet::Markdown
      .new(ApplicationHelper::RougeRenderer, fenced_code_blocks: true)
      .render("```ruby" + code + "```").html_safe
  end

  def format_slim_code(code)
    Redcarpet::Markdown
      .new(ApplicationHelper::RougeRenderer, fenced_code_blocks: true)
      .render("```slim" + code + "```").html_safe
  end

end
