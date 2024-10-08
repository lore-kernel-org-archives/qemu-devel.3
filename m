Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D24ECF0423
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 21:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syHaU-0000wK-B2; Tue, 08 Oct 2024 17:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1syHaQ-0000vy-Ig
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:17:42 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1syHaO-0000II-Dx
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:17:42 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e03be0d92so1944478b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 14:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728422259; x=1729027059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyhYk86x3Y6zwFojKY/uni4sKUw2rIeokUy1XUAGDGw=;
 b=a15gDs+FrSFFb4kKlvvaFTiJwjeZQpoReQGjROmLo3BSv9VmPI81enykmvvu4Bnyqr
 cSE4XWsdAq9RrIdY4dooU+f154aNf5Gvt4gbOeqThr6DQ71b1gml5O8DdqgJCRf9ORO0
 BHVmD+QsKMbGi0p1JILewLNEG/UyEuYpxUtfxLyPJdcEThI82gSiDDF7UNWu2i1Ojsxt
 r3jSTAHjSLGKz973oNHDbp+p2Iuhjz323WVCRiVGcfAg54QDlc6G4Wyrdlh4TLUMK6af
 dPndcX3iAXSFrnQPvt+wNzkymGkSCFqrt/HL4zEqKZ8wESV18uv0/B4YHzEhw5qUys5m
 TgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728422259; x=1729027059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RyhYk86x3Y6zwFojKY/uni4sKUw2rIeokUy1XUAGDGw=;
 b=WQ6yiARVUFMgJqWSpsjKbQMDk5qryFKXeV2bu86VTt2/ygP3zivjFTGDwQ3qKkFBU0
 ALzaFzNp+G63ezSGpEA1lLxOE7ZByzi/nimd4JLbOXrMjXWZrFvTKPrc/yPXuvvkVgAQ
 oiaUuUbrXU5Flv/MDrLpA6MM3qqNGMyOsiwfFsoOtct2OZQjxENRkvLGfWRwzVuTF8Uw
 Xaq1TBfaHIqZBiJkuG2Jkw7DstRyoTGoakeqUxfuIqy0lPRw8tPs4EWWwJDavCwoo9OF
 /ecrX3CnWe6Q66tMC7iskH9d4PUyCzNp3BCSqPXGGJfnfL8lRQBFLbKkBD/P/y9/obkq
 DGUA==
X-Gm-Message-State: AOJu0YxXu6VHX/o2ejTPMZfTvQ5MMKbiKWDWJf6fuUX5BDyQQS8R3FPy
 Dh+DA2hS9Em/2bQodof3Vg49EpGQONk70fxtH9nJshtDMMTAIHGm4GHbOA==
X-Google-Smtp-Source: AGHT+IHeSXioTfv3VsRZaUVDhmQjHhCxBdSGnV4l64YajWWtCuxxKowvPJSO9qRE3a5I98RrhxzbEA==
X-Received: by 2002:a05:6a00:1749:b0:71d:ebac:f007 with SMTP id
 d2e1a72fcca58-71e1dbc7686mr304170b3a.28.1728422258398; 
 Tue, 08 Oct 2024 14:17:38 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.151])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d6254dsm6549078b3a.153.2024.10.08.14.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 14:17:38 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v8 1/6] tests/lcitool: Update libvirt-ci and add libcbor
 dependency
Date: Wed,  9 Oct 2024 03:17:22 +0600
Message-Id: <20241008211727.49088-2-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241008211727.49088-1-dorjoychy111@gmail.com>
References: <20241008211727.49088-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

libcbor dependecy is necessary for adding virtio-nsm and nitro-enclave
machine support in the following commits. libvirt-ci has already been
updated with the dependency upstream and this commit updates libvirt-ci
submodule in QEMU to latest upstream. Also the libcbor dependency has
been added to tests/lcitool/projects/qemu.yml.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
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
 tests/docker/dockerfiles/fedora.docker                | 1 +
 tests/docker/dockerfiles/opensuse-leap.docker         | 1 +
 tests/docker/dockerfiles/ubuntu2204.docker            | 1 +
 tests/lcitool/projects/qemu.yml                       | 1 +
 18 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/cirrus/macos-14.vars b/.gitlab-ci.d/cirrus/macos-14.vars
index 24cfec3b89..2bbab50ca0 100644
--- a/.gitlab-ci.d/cirrus/macos-14.vars
+++ b/.gitlab-ci.d/cirrus/macos-14.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
+PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/.gitlab-ci.d/cirrus/macos-15.vars b/.gitlab-ci.d/cirrus/macos-15.vars
index 23b2c1d22f..f76ad3b1ed 100644
--- a/.gitlab-ci.d/cirrus/macos-15.vars
+++ b/.gitlab-ci.d/cirrus/macos-15.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
+PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
index 71a0f0c433..4fb3c7555f 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
@@ -35,6 +35,7 @@ packages:
   - libcacard-dev
   - libcap-ng-dev
   - libcapstone-dev
+  - libcbor-dev
   - libcmocka-dev
   - libcurl4-gnutls-dev
   - libdaxctl-dev
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
index d8de967b18..d79399caf3 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
@@ -35,6 +35,7 @@ packages:
   - libcacard-dev
   - libcap-ng-dev
   - libcapstone-dev
+  - libcbor-dev
   - libcmocka-dev
   - libcurl4-gnutls-dev
   - libdaxctl-dev
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 54b9721997..a0136181d3 100644
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
index 136c3a79a1..5c5a753aca 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -92,6 +92,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:amd64 \
                       libcap-ng-dev:amd64 \
                       libcapstone-dev:amd64 \
+                      libcbor-dev:amd64 \
                       libcmocka-dev:amd64 \
                       libcurl4-gnutls-dev:amd64 \
                       libdaxctl-dev:amd64 \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 233f6ee1de..7724b5f7fb 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -92,6 +92,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:arm64 \
                       libcap-ng-dev:arm64 \
                       libcapstone-dev:arm64 \
+                      libcbor-dev:arm64 \
                       libcmocka-dev:arm64 \
                       libcurl4-gnutls-dev:arm64 \
                       libdaxctl-dev:arm64 \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index f26385e0b9..d64c2a2cbd 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -92,6 +92,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:armhf \
                       libcap-ng-dev:armhf \
                       libcapstone-dev:armhf \
+                      libcbor-dev:armhf \
                       libcmocka-dev:armhf \
                       libcurl4-gnutls-dev:armhf \
                       libdaxctl-dev:armhf \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 2328ee1732..f4501866f9 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -92,6 +92,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:i386 \
                       libcap-ng-dev:i386 \
                       libcapstone-dev:i386 \
+                      libcbor-dev:i386 \
                       libcmocka-dev:i386 \
                       libcurl4-gnutls-dev:i386 \
                       libdaxctl-dev:i386 \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index bfa96cb507..126b22c311 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -91,6 +91,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:mips64el \
                       libcap-ng-dev:mips64el \
                       libcapstone-dev:mips64el \
+                      libcbor-dev:mips64el \
                       libcmocka-dev:mips64el \
                       libcurl4-gnutls-dev:mips64el \
                       libdaxctl-dev:mips64el \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 4ac314e22e..0fcb88a174 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -91,6 +91,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:mipsel \
                       libcap-ng-dev:mipsel \
                       libcapstone-dev:mipsel \
+                      libcbor-dev:mipsel \
                       libcmocka-dev:mipsel \
                       libcurl4-gnutls-dev:mipsel \
                       libdaxctl-dev:mipsel \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 8c1dcec9cf..393d0300c6 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -92,6 +92,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:ppc64el \
                       libcap-ng-dev:ppc64el \
                       libcapstone-dev:ppc64el \
+                      libcbor-dev:ppc64el \
                       libcmocka-dev:ppc64el \
                       libcurl4-gnutls-dev:ppc64el \
                       libdaxctl-dev:ppc64el \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 72668e0315..cbe590080d 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -92,6 +92,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev:s390x \
                       libcap-ng-dev:s390x \
                       libcapstone-dev:s390x \
+                      libcbor-dev:s390x \
                       libcmocka-dev:s390x \
                       libcurl4-gnutls-dev:s390x \
                       libdaxctl-dev:s390x \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 42bd0067d1..631fe6b671 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -41,6 +41,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev \
                       libcap-ng-dev \
                       libcapstone-dev \
+                      libcbor-dev \
                       libcmocka-dev \
                       libcurl4-gnutls-dev \
                       libdaxctl-dev \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index ecdefaff1a..a01c004cfa 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -61,6 +61,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                libbpf-devel \
                libcacard-devel \
                libcap-ng-devel \
+               libcbor-devel \
                libcmocka-devel \
                libcurl-devel \
                libdrm-devel \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 0dab4e4873..751919c1ec 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -46,6 +46,7 @@ RUN zypper update -y && \
            libbz2-devel \
            libcacard-devel \
            libcap-ng-devel \
+           libcbor-devel \
            libcmocka-devel \
            libcurl-devel \
            libdrm-devel \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 3a7de6a318..ecd5c4fd08 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -41,6 +41,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcacard-dev \
                       libcap-ng-dev \
                       libcapstone-dev \
+                      libcbor-dev \
                       libcmocka-dev \
                       libcurl4-gnutls-dev \
                       libdaxctl-dev \
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 252e871f80..35878951b6 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -42,6 +42,7 @@ packages:
  - libc-static
  - libcacard
  - libcap-ng
+ - libcbor
  - libcurl
  - libdrm
  - libepoxy
-- 
2.39.5


