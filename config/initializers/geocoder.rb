Geocoder.configure do |config|
  ## Configurable parameters: if you wish to change some configurable
  ## behaviour in Geocoder, feel free to uncomment the following lines
  ## and provide custom parameters.

  config.timeout      = 3           # geocoding service timeout (secs)
  config.lookup       = :yandex     # name of geocoding service (symbol)
  config.language     = :en         # ISO-639 language code
  config.api_key      = nil         # API key for geocoding service
  config.cache_prefix = "geocoder:" # prefix (string) to use for all cache keys

  ## exceptions that should not be rescued by default
  ## (if you want to implement custom error handling);
  ## supports SocketError and TimeoutError
  # config.always_raise = []

  ## Calculation options
  # config.units  = :mi        # :km for kilometers or :mi for miles
  # config.method = :linear    # :spherical or :linear
end

