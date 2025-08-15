require 'openssl'
require 'tempfile'

#auto generate certs
$key_file = Tempfile.new(['key', '.pem'])
$cert_file = Tempfile.new(['cert', '.pem'])

key = OpenSSL::PKey::RSA.new(2048)
cert = OpenSSL::X509::Certificate.new
cert.version = 2
cert.serial = 0
cert.subject = OpenSSL::X509::Name.parse("/CN=localhost")
cert.issuer = cert.subject
cert.public_key = key.public_key
cert.not_before = Time.now
cert.not_after = Time.now + 365 * 24 * 60 * 60
cert.sign(key, OpenSSL::Digest::SHA256.new)

$key_file.write(key.to_pem)
$cert_file.write(cert.to_pem)
$key_file.rewind
$cert_file.rewind

# start server on 443
ssl_bind '0.0.0.0', '443', {
  key: $key_file.path,
  cert: $cert_file.path,
  verify_mode: 'none'
}

rails_env = ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `environment` that Puma will run in.
environment rails_env

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"


# Optional Puma settings:
# environment 'development'

# Logging (optional)
#stdout_redirect 'log/puma.stdout.log', 'log/puma.stderr.log', true




