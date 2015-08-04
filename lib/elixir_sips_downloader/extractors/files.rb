# Extract a Set of Files from an Feed Item Description.
class ElixirSipsDownloader::Extractors::Files < ElixirSipsDownloader::Extractor
  # @param item_description [String] the feed item description extracted with
  #   `feed.items[i].description`.
  # @return [Set<ElixirSipsDownloader::Downloadables::File>] the Set of Files
  #   extracted from feed item description.
  def extract item_description
    files = Set.new

    begin
      document = REXML::Document.new item_description
      document.elements.each("/div[@class='blog-entry']/ul/li/a") do |element|
        name = element.text
        link = element.attribute('href').to_s
        files << ElixirSipsDownloader::Downloadables::File.new(name, link)
      end
    rescue REXML::ParseException
      ElixirSipsDownloader.logger.info "====>>> Exception; please check downloaded files"
    end
    files
  end
end
