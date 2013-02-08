require 'rails_admin/config/fields/base'
require 'rails_admin/config/fields/types/file_upload'

module RailsAdmin
  module Config
    module Fields
      module Types
        # Field type that supports Paperclip file uploads
        class HydraAttachment < RailsAdmin::Config::Fields::Types::FileUpload
          RailsAdmin::Config::Fields::Types.register(self)

          register_instance_option :pretty_value do
            if value.presence
              v = bindings[:view]
              url = resource_url
              if self.image
                thumb_url = resource_url(thumb_method)
                (url != thumb_url) ? v.link_to(v.image_tag(thumb_url, :class => 'img-polaroid'), url, :target => 'blank') : v.image_tag(thumb_url)
              elsif url.present?
                v.link_to(nil, url, :target => 'blank')
              end
            else
              nil
            end
          end

          def resource_url(thumb = false)
            value.class.name == "String" ? value : nil
          end
        end
      end
    end
  end
end
