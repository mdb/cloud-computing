require 'fog'
require 'lib/template_helpers'

helpers TemplateHelpers

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :haml, { ugly: true }

activate :directory_indexes

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :relative_assets
end

# Make middleman-sync work with AWS bucket name containing dots
# https://github.com/karlfreeman/middleman-sync/issues/29
Fog.credentials = { path_style: true }

activate :sync do |sync|
  sync.fog_provider = 'AWS'
  sync.fog_directory = 'TODO'
  sync.fog_region = 'us-east-1'
  sync.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']
  sync.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  sync.existing_remote_files = 'delete'
end
