#
# Copyright 2015 YOUR NAME
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# These options are required for all software definitions
name "omnibus-ruby"
default_version '2.1.5'

# A software can specify more than one version that is available for install
# version("1.2.6") { source md5: "618e944d7c7cd6521551e30b32322f4a" }
# version("1.2.8") { source md5: "44d667c142d7cda120332623eab69f40" }

# Sources may be URLs, git locations, or path locations
# source url: "http://downloads.sourceforge.net/project/libpng/zlib/#{version}/zlib-#{version}.tar.gz"

# This is the path, inside the tarball, where the source resides
# relative_path "zlib-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  command "rmdir #{install_dir}/bin", :env => env
  command "ln -fs #{install_dir}/embedded/bin #{install_dir}/bin", :env => env

  ## Ref: https://github.com/ryotarai/omnibus-software/pull/1/files
  mkdir "#{install_dir}/embedded/ssl/certs"
  copy "#{project_dir}/cacert.pem", "#{install_dir}/embedded/ssl/certs/cacert.pem"

  block {
    File.open("#{install_dir}/embedded/ssl/certs/cacert.pem", "a") do |f|
      f.write "
Verisign Class 3 Public Primary Certification Authority 2
=========================================================
-----BEGIN CERTIFICATE-----
MIICPDCCAaUCEDyRMcsf9tAbDpq40ES/Er4wDQYJKoZIhvcNAQEFBQAwXzELMAkG
A1UEBhMCVVMxFzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMTcwNQYDVQQLEy5DbGFz
cyAzIFB1YmxpYyBQcmltYXJ5IENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTk2
MDEyOTAwMDAwMFoXDTI4MDgwMjIzNTk1OVowXzELMAkGA1UEBhMCVVMxFzAVBgNV
BAoTDlZlcmlTaWduLCBJbmMuMTcwNQYDVQQLEy5DbGFzcyAzIFB1YmxpYyBQcmlt
YXJ5IENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIGfMA0GCSqGSIb3DQEBAQUAA4GN
ADCBiQKBgQDJXFme8huKARS0EN8EQNvjV69qRUCPhAwL0TPZ2RHP7gJYHyX3KqhE
BarsAx94f56TuZoAqiN91qyFomNFx3InzPRMxnVx0jnvT0Lwdd8KkMaOIG+YD/is
I19wKTakyYbnsZogy1Olhec9vn2a/iRFM9x2Fe0PonFkTGUugWhFpwIDAQABMA0G
CSqGSIb3DQEBBQUAA4GBABByUqkFFBkyCEHwxWsKzH4PIRnN5GfcX6kb5sroc50i
2JhucwNhkcV8sEVAbkSdjbCxlnRhLQ2pRdKkkirWmnWXbj9T/UWZYB2oK0z5XqcJ
2HUw19JlYD1n1khVdWk/kfVIC0dpImmClr7JyDiGSnoscxlIaU5rfGW/D/xwzoiQ
-----END CERTIFICATE-----
      "
    end
  }

  # link "#{install_dir}/embedded/ssl/certs/cacert.pem", "#{install_dir}/embedded/ssl/cert.pem"

  block { File.chmod(0644, "#{install_dir}/embedded/ssl/certs/cacert.pem") }
end
