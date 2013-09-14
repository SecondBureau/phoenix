module ApplicationHelper
  def is_active?(page_names, type = :action)
    "active" if [*page_names].include? params[type]
  end
  
  def link_to_outbound(*args, &block)
    if block_given?
      options      = args.first || {}
      html_options = args.second
      link_to_outbound(capture(&block), options, html_options)
    else
      name         = args[0]
      options      = args[1] || {}
      html_options = args[2]
      html_options = convert_options_to_data_attributes(options, html_options)
      url = url_for(options)
      href = html_options['href']
      tag_options = tag_options(html_options)
      href_attr = "href=\"#{ERB::Util.html_escape(url)}\"" unless href
      unless local_request? or refinery_user? or page_code =~ /^(UA-xxxxxx-x)?$/
        domain = URI.parse(url).host || 'internal'
        "<a #{href_attr}#{tag_options} onClick=\"trackOutboundLink(this, 'Outbound Links', '#{domain}'); return false;\">#{ERB::Util.html_escape(name || url)}</a>".html_safe
      else
        "<a #{href_attr}#{tag_options}>#{ERB::Util.html_escape(name || url)}</a>".html_safe
      end
    end
  end
  
end
