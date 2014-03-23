module Lactol
  class Server
    module ViewHelper
      def render_option(name, param)
        # TODO: switch param.type
        input_attribute = {
          type: "text",
          id:   name,
          name: name,
          placeholder: param.banner,
          required:    param.required
        }

        render_tag("label", name, for: name) +  render_tag("input", input_attribute)
      end


      def render_tag(tag_name, text = nil, attributes = {})
        text, attributes = nil, text if text.is_a?(Hash)

        attributes = attributes.map do |key, value|
          case value
          when true
            key
          when false, nil
            nil
          else
            %Q(#{key}="#{value}")
          end
        end.compact.join(" ")

        "<#{tag_name} #{attributes}>#{text}</#{tag_name}>"
      end
    end
  end
end
