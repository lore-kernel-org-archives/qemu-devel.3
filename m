Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35777D767F6
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZMC-0001Fi-A2; Thu, 31 Oct 2024 13:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZM6-0000hZ-7b
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZM2-0007Mi-KU
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3IWcSy6/NrB9sOZzfSkvV75pWE0ul/hmIAgB5vMw3bo=;
 b=aIhQPWFwaJ/KFYmMzHc5GxlZDZiCthMyUBVWAp1vawtTGPAUqEPgMq3BOLtKwRddssR26L
 nKgijS/jYD79q6QsTTIapuCc9i7r65ajXQSqi2H43qaR3k34mDz9u3KpZquDx79EpUkEg5
 vDOAYiCmM7T/rtDsSkVKpAeJubPhbYA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-F1zB_5VZNvqNXK_UuJGT3w-1; Thu, 31 Oct 2024 13:53:03 -0400
X-MC-Unique: F1zB_5VZNvqNXK_UuJGT3w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4314f1e0f2bso7564035e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397181; x=1731001981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3IWcSy6/NrB9sOZzfSkvV75pWE0ul/hmIAgB5vMw3bo=;
 b=tEXNRbol3AdD77lCXa84Nt4rg1Hmnp7esl/Pv1KIgdMzC4euNx1m8KBNbFBYAFy6y/
 rSDYseE4gdnP1YPxm38SYmNqkarkHKLp4LmlQ8Ef/Nwdr85Xd6qXF5wYhvqdwWfL5lJ9
 tmaydZ/HlK5YeInt0/w4Pv1/QC4X5ly1ZCTGxbtGDOXH6MXs4G8QVInUCW0KhcrKky0C
 3EtKk3kzaTLBqDroaPpKkho+a12cIvwrFUeVWmm6mQuQrpWSSrH/stUQd14UY8ZgAS6S
 AdywlH2u3vd4/vCL5kZVK1Pu4wJz3dVYlu2IFypcF369NDUgZaZH3XmVbnHyqPqPeEa3
 Yf5g==
X-Gm-Message-State: AOJu0Yzi89vAly6fZ8zKE7ESe6xaMWa+F9VtiIOogvj8+uqCgnAZmb+I
 uZRU8oWzlm+G/hLqzuwhif7DQk/rgiuxlZYERS9sb3K9xbH7H+dumpc6tF/yHk4/9ISABfWDTC/
 UMWdBnIODK1UEVUP2buAQ4y7XPW7cyolpc/pjbVM+Zts4GAO7YXaQZiPyQCslfYn1vQwgjCyDwJ
 lUraUQ5+d1joOzVc46F7pMdSj2EvStNfJ5X/m8z6k=
X-Received: by 2002:a05:600c:1987:b0:431:6083:cd2a with SMTP id
 5b1f17b1804b1-4328324d6bfmr5706185e9.15.1730397181337; 
 Thu, 31 Oct 2024 10:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXLsWqEigyNW7xTHyPiX/JSLrh08SZnxkeKjsk2IIJdspgK3eHq26UCoQDFaeAgIZtXHPjpw==
X-Received: by 2002:a05:600c:1987:b0:431:6083:cd2a with SMTP id
 5b1f17b1804b1-4328324d6bfmr5705995e9.15.1730397180822; 
 Thu, 31 Oct 2024 10:53:00 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9cab13sm65728325e9.48.2024.10.31.10.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <graf@amazon.com>
Subject: [PULL 21/49] tests/lcitool: Update libvirt-ci and add libcbor
 dependency
Date: Thu, 31 Oct 2024 18:51:45 +0100
Message-ID: <20241031175214.214455-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Dorjoy Chowdhury <dorjoychy111@gmail.com>

libcbor dependecy is necessary for adding virtio-nsm and nitro-enclave
machine support in the following commits. libvirt-ci has already been
updated with the dependency upstream and this commit updates libvirt-ci
submodule in QEMU to latest upstream. Also the libcbor dependency has
been added to tests/lcitool/projects/qemu.yml.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Reviewed-by: Alexander Graf <graf@amazon.com>
Link: https://lore.kernel.org/r/20241008211727.49088-2-dorjoychy111@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/cirrus/macos-14.vars                     | 2 +-
 .gitlab-ci.d/cirrus/macos-15.vars                     | 2 +-
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 1 +
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 1 +
 tests/docker/dockerfiles/alpine.docker                | 1 +
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-i686-cross.docker     | 1 +
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 +
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 +
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 +
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 +
 tests/docker/dockerfiles/debian.docker                | 1 +
 tests/docker/dockerfiles/fedora-rust-nightly.docker   | 1 +
 tests/docker/dockerfiles/fedora.docker                | 1 +
 tests/docker/dockerfiles/opensuse-leap.docker         | 1 +
 tests/docker/dockerfiles/ubuntu2204.docker            | 1 +
 tests/lcitool/projects/qemu.yml                       | 1 +
 19 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/cirrus/macos-14.vars b/.gitlab-ci.d/cirrus/macos-14.vars
index 1fd03d68b97..25dff322e6a 100644
--- a/.gitlab-ci.d/cirrus/macos-14.vars
+++ b/.gitlab-ci.d/cirrus/macos-14.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
+PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/.gitlab-ci.d/cirrus/macos-15.vars b/.gitlab-ci.d/cirrus/macos-15.vars
index b6b6d71d473..a72e9ed024d 100644
--- a/.gitlab-ci.d/cirrus/macos-15.vars
+++ b/.gitlab-ci.d/cirrus/macos-15.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
+PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
index dd89ba1b3a7..f4647940f8c 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
@@ -36,6 +36,7 @@ packages:
   - libcacard-dev
   - libcap-ng-dev
   - libcapstone-dev
+  - libcbor-dev
   - libcmocka-dev
   - libcurl4-gnutls-dev
   - libdaxctl-dev
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
index 74f14d8d0fe..fe2995c19bd 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
@@ -36,6 +36,7 @@ packages:
   - libcacard-dev
   - libcap-ng-dev
   - libcapstone-dev
+  - libcbor-dev
   - libcmocka-dev
   - libcurl4-gnutls-dev
   - libdaxctl-dev
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 9ce7b5280c0..f87c40fbfe3 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -45,6 +45,7 @@ RUN apk update && \
         libaio-dev \
         libbpf-dev \
         libcap-ng-dev \
+        libcbor-dev \
         libdrm-dev \
         libepoxy-dev \
         libffi-dev \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index b86949b2e6c..d3b58c3e90d 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -94,6 +94,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:amd64 \
                       libcap-ng-dev:amd64 \
                       libcapstone-dev:amd64 \
+                      libcbor-dev:amd64 \
                       libcmocka-dev:amd64 \
                       libcurl4-gnutls-dev:amd64 \
                       libdaxctl-dev:amd64 \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 68789791121..4a6785bf5b4 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -94,6 +94,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:arm64 \
                       libcap-ng-dev:arm64 \
                       libcapstone-dev:arm64 \
+                      libcbor-dev:arm64 \
                       libcmocka-dev:arm64 \
                       libcurl4-gnutls-dev:arm64 \
                       libdaxctl-dev:arm64 \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index e38b8fcc412..52e8831326f 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -94,6 +94,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:armhf \
                       libcap-ng-dev:armhf \
                       libcapstone-dev:armhf \
+                      libcbor-dev:armhf \
                       libcmocka-dev:armhf \
                       libcurl4-gnutls-dev:armhf \
                       libdaxctl-dev:armhf \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index b4d06187390..1326e8a5ca9 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -94,6 +94,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:i386 \
                       libcap-ng-dev:i386 \
                       libcapstone-dev:i386 \
+                      libcbor-dev:i386 \
                       libcmocka-dev:i386 \
                       libcurl4-gnutls-dev:i386 \
                       libdaxctl-dev:i386 \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 4f6c816b3fe..0ba542112eb 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -93,6 +93,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:mips64el \
                       libcap-ng-dev:mips64el \
                       libcapstone-dev:mips64el \
+                      libcbor-dev:mips64el \
                       libcmocka-dev:mips64el \
                       libcurl4-gnutls-dev:mips64el \
                       libdaxctl-dev:mips64el \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index a238526b4c5..59b5d2655b4 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -93,6 +93,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:mipsel \
                       libcap-ng-dev:mipsel \
                       libcapstone-dev:mipsel \
+                      libcbor-dev:mipsel \
                       libcmocka-dev:mipsel \
                       libcurl4-gnutls-dev:mipsel \
                       libdaxctl-dev:mipsel \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index b6c6f5b7b00..8680b35c5a7 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -94,6 +94,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:ppc64el \
                       libcap-ng-dev:ppc64el \
                       libcapstone-dev:ppc64el \
+                      libcbor-dev:ppc64el \
                       libcmocka-dev:ppc64el \
                       libcurl4-gnutls-dev:ppc64el \
                       libdaxctl-dev:ppc64el \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 14f169984eb..384a2b425e7 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -94,6 +94,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:s390x \
                       libcap-ng-dev:s390x \
                       libcapstone-dev:s390x \
+                      libcbor-dev:s390x \
                       libcmocka-dev:s390x \
                       libcurl4-gnutls-dev:s390x \
                       libdaxctl-dev:s390x \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 22b064cbf01..505330a9e22 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -42,6 +42,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev \
                       libcap-ng-dev \
                       libcapstone-dev \
+                      libcbor-dev \
                       libcmocka-dev \
                       libcurl4-gnutls-dev \
                       libdaxctl-dev \
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index c2029cc4c6e..9180c8b5222 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -62,6 +62,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                libbpf-devel \
                libcacard-devel \
                libcap-ng-devel \
+               libcbor-devel \
                libcmocka-devel \
                libcurl-devel \
                libdrm-devel \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 1980421f6ae..b64399af662 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -62,6 +62,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                libbpf-devel \
                libcacard-devel \
                libcap-ng-devel \
+               libcbor-devel \
                libcmocka-devel \
                libcurl-devel \
                libdrm-devel \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 53b94610308..4d5fb3e3a14 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -47,6 +47,7 @@ RUN zypper update -y && \
            libbz2-devel \
            libcacard-devel \
            libcap-ng-devel \
+           libcbor-devel \
            libcmocka-devel \
            libcurl-devel \
            libdrm-devel \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index ce3aa39d4f3..94697bd036b 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -42,6 +42,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev \
                       libcap-ng-dev \
                       libcapstone-dev \
+                      libcbor-dev \
                       libcmocka-dev \
                       libcurl4-gnutls-dev \
                       libdaxctl-dev \
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 6852918642e..80bcac09027 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -43,6 +43,7 @@ packages:
  - libc-static
  - libcacard
  - libcap-ng
+ - libcbor
  - libcurl
  - libdrm
  - libepoxy
-- 
2.47.0


