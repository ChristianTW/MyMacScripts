cask 'audacity' do
  version '2.2.2'
  sha256 '39a2783c78cca13e893321e0d87098739258cabbfc257119ee6cb21d0dc9037c'

  url do
    # Audacity does not provide a fixed URL
    # Their download URL points to a html page that generates a temporary URL embedded within an iframe
    # 'open-uri' is required to open that page and grab the temporary URL
    require 'open-uri'
    # fosshub.com/Audacity.html was verified as official when first introduced to the cask
    open("https://www.fosshub.com/Audacity.html/audacity-macos-#{version}.dmg") do |io|
      content = io.read
      %r{^\<iframe.*src=\"(http.*\.dmg)\".*>}.match(content)[1].to_s
    end
  end
  name 'Audacity'
  homepage 'http://www.audacityteam.org/'

  depends_on macos: '>= :snow_leopard'

  app 'Audacity.app'

  zap delete: '~/Library/Application Support/audacity'
end
