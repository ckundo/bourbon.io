module ApplicationHelpers
  def github_file_url(file_path, version)
    "https://github.com/thoughtbot/bourbon/blob/v#{version}/core/#{file_path}"
  end

  def inline_css(*names)
    names.map { |name|
      name += ".css" unless name.include?(".css")
      css_path = sitemap.resources.select { |p| p.source_file && p.source_file.include?(name) }.first
      "<style type='text/css'>#{css_path.render}</style>"
    }.reduce(:+)
  end

  def markdown(contents)
    renderer = Redcarpet::Render::HTML
    markdown = Redcarpet::Markdown.new(
      renderer,
      autolink: true,
      fenced_code_blocks: true,
      footnotes: true,
      highlight: true,
      smartypants: true,
      strikethrough: true,
      tables: true,
      with_toc_data: true
    )
    markdown.render(contents)
  end

  def page_description
    yield_content(:description) || data.site.description
  end

  def page_title
    yield_content(:title) || data.site.title
  end

  def preferred_url
    path = yield_content :preferred_path
    File.join(ENV["SITE_URL"], path, "/")
  end

  def svg(name)
    root = Middleman::Application.root
    file_path = "#{root}/source/images/#{name}.svg"
    return File.read(file_path) if File.exists?(file_path)
    "(not found)"
  end
end
