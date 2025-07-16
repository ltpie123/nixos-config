# Optional: Automated SSH key setup
# WARNING: This stores your private key in your config (less secure)
# Only use if you understand the security implications

{ pkgs, ... }: {
  # This is an example of how you could automate SSH key setup
  # NOT RECOMMENDED for production use due to security concerns
  
  # home.file.".ssh/id_ed25519" = {
  #   source = ./secrets/id_ed25519;  # Your private key file
  #   onChange = "chmod 600 ~/.ssh/id_ed25519";
  # };
  
  # home.file.".ssh/id_ed25519.pub" = {
  #   source = ./secrets/id_ed25519.pub;  # Your public key file
  #   onChange = "chmod 644 ~/.ssh/id_ed25519.pub";
  # };
} 