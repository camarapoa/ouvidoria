# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ouvidoria_session',
  :secret      => '660972255d00fa55b9ac29a8b40ab9735332febab5801f2b8ef2d2862e5916af3ec7e8e913aac522d6f1fada3e912563fc24a40ad5879fdc41e00a27b12dde8a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
