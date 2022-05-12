FROM gitpod/workspace-base

USER root

# Install Nix
RUN addgroup --system nixbld \
  && adduser gitpod nixbld \
  && for i in $(seq 1 30); do useradd -ms /bin/bash nixbld$i &&  adduser nixbld$i nixbld; done \
  && mkdir -m 0755 /nix && chown gitpod /nix \
  && mkdir -p /etc/nix && echo 'sandbox = false' > /etc/nix/nix.conf && echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf

# Install Nix
CMD /bin/bash -l
USER gitpod
ENV USER gitpod
WORKDIR /home/gitpod

RUN touch .bash_profile \
 && curl -L https://nixos.org/nix/install | sh

RUN echo '. /home/gitpod/.nix-profile/etc/profile.d/nix.sh' >> /home/gitpod/.bashrc
RUN mkdir -p /home/gitpod/.config/nixpkgs && echo '{ allowUnfree = true; }' >> /home/gitpod/.config/nixpkgs/config.nix

# Install cachix
RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
  && nix profile install nixpkgs#cachix \
  && cachix use cachix

# Install git
RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
  && nix profile install nixpkgs#git nixpkgs#git-lfs

# Install direnv
RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
  && nix profile install nixpkgs#direnv \
  && direnv hook bash >> /home/gitpod/.bashrc

# Install Agda
RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
  && nix profile install nixpkgs/release-21.11#haskellPackages.Agda

RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
  && nix profile install nixpkgs/release-21.11#agda-pkg

RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
  && apkg init

RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
  && yes | apkg install cubical
