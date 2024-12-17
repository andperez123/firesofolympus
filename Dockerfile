# Base image
FROM rust:1.69.0

# Install dependencies
RUN apt-get update && apt-get install -y \
    pkg-config \
    build-essential \
    curl \
    nodejs \
    npm

# Create build directory
RUN mkdir -p /tmp/build && chmod 777 /tmp/build

# Install Solana
RUN sh -c "$(curl -sSfL https://release.solana.com/v1.14.16/install)"

# Install Solana BPF SDK
RUN curl -L https://github.com/solana-labs/solana/releases/download/v1.14.16/solana-release-x86_64-unknown-linux-gnu.tar.bz2 | tar -xj
RUN mv solana-release/bin/sdk/bpf/* /usr/local/bin/
ENV PATH="/usr/local/bin:$PATH"

# Configure Cargo
RUN mkdir -p ~/.cargo && echo '[net]\ngit-fetch-with-cli = true' > ~/.cargo/config

# Install Anchor from binary
RUN curl -L https://github.com/coral-xyz/anchor/releases/download/v0.27.0/anchor-v0.27.0-x86_64-unknown-linux-gnu.tar.gz | tar -xz -C /usr/local/bin

# Install SPL token CLI
RUN cargo install --git https://github.com/solana-labs/solana-program-library spl-token-cli

WORKDIR /app
COPY . .

# Install project dependencies
RUN npm install

CMD ["bash"]