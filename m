Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21A7CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxpY-0008Iv-UP; Mon, 17 Nov 2025 06:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpW-0008Gd-IL
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:34 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpR-0005g7-MT
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:34 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-429c82bf86bso2368159f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763380528; x=1763985328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7imAwaQy0BQ8L3TxMse2wLX0e+hZkTXypY3zi1UG2Ps=;
 b=PgOLyeNniz6Yqfk+X80z5hGLzU4EU5ldEOWj/Kpxqdlls0JUNdGyiSj2IR4fm1xHFv
 R6SBLsHg3VPh11YpCq2PKtcPTflUhC77aLJDJkeg9o+6vHACA6TaEsXfNOXaG/ZloCPV
 IfYtxW8gkvmRbQ2D8niEKgD3NfVAlEWV0u2z/erkcWmRlaC3Ou/ERdpqL1Abp9mcAClr
 fUvOgLOWPMjttMdTQhpsPACB5mjXkw2TqTZGPfiO+m5YWfYVltLInnr+/dId9ZzcVcKV
 yTRRmuOsqmLNvuLZHhzJNHXhRse6KTfAEp0AJ+DtS3zjAxv7qwtHNxRD2bsmaCmulJf+
 8tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763380528; x=1763985328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7imAwaQy0BQ8L3TxMse2wLX0e+hZkTXypY3zi1UG2Ps=;
 b=wMCfOdmn9sobhffYUJUlysZTxzNWrrZjICfYWVmZfjcXiI7vvmrQJwQFQPmdetYGrk
 fMWssc7equzHTA9WFxQ2L4tOMFuNne8EZTitFyxtYLAisCw7MTaLGCCK2u97Zob9wLWk
 Mod9fJ/qxiyMJZ3HgpasxHtny1uENv/AyYRVGO+pCJcoLiARCcv5damYwEyxgYE8XHlc
 Lt8xqRR2eMjV91lbss3BGGIKReWl5uzyrhKxsYhUyUQh/YECM6t14sOmvPQdtwnHBbbO
 AZ7VJ6RIkFXAn5x/yCOc/E9bsHFuW2bOqkJXrHX5KU5pS6/1Y4QNzDtqDQevjDZ2KZJw
 PGXA==
X-Gm-Message-State: AOJu0YzCwmJ+nFfyVgOqCotvECh5REpq4hiHV6qKTgeS/nBWObwHbZ2N
 pM0wXVd+MEDzkRryuv28b2CXGhvx06X+ZfFt0IJcO7So0B/xqmwpflV32+cZ5NgUyzM=
X-Gm-Gg: ASbGncvQhGEUcXYTqK4+qMWhDSTz3C5B+Nh29Lr7TFIL7sOSTIQc8SDkS/1QBM/TRfM
 VLhtCz+OHypiJuOtlhvIrlx9XVkVBecFb6wUE6G0yajJVaXEq3NO0Yg59aPJbieqx0W1L6Qo+wV
 ra22DjnJtRqq9920b7b+m2wukpvoyZlk3dXXbCq0rXMhCcV3bAWChu4o3xAzaUVhtc8rDDvm3GJ
 BlC3ypDG06t+EDlBz+oe/FT9h3oILrR8niVtHgGXpvwYU4nPFPyQ6EWixAxHL7PVq3QTrVanyXy
 q2jCwxO2Zp4fJV67ZebyUL6yZfLgf7g5y3l9gKD0bMsMVN4SrOPDG93HnvBVkS6tRnudZAptcJq
 IiNkC49YYJeQ6usVQ6uOQQo7RiSqaBDI+Z250gIADHrqzPb94aA120r+IQHB5vg1JPnWsLOlzjA
 dedfR53IZZTiI=
X-Google-Smtp-Source: AGHT+IFyhyTN20RxcBzZD+uUFPjMYnNrgvzGRYDk3hAncx6yPd7SHJ9FKHW13rswfv6s1fo/AVluEw==
X-Received: by 2002:a05:6000:4383:b0:42b:3c8d:1932 with SMTP id
 ffacd0b85a97d-42b59345301mr10668485f8f.23.1763380527789; 
 Mon, 17 Nov 2025 03:55:27 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e85cc0sm26652257f8f.17.2025.11.17.03.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 03:55:25 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AD2A75F915;
 Mon, 17 Nov 2025 11:55:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 04/18] tests/docker: add coreutils to the package list
Date: Mon, 17 Nov 2025 11:55:09 +0000
Message-ID: <20251117115523.3993105-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117115523.3993105-1-alex.bennee@linaro.org>
References: <20251117115523.3993105-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We need coreutils to run the IO tests so we need to include it in the
package list. Now we have the latest libvirt we can do that.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251113102525.1255370-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/cirrus/freebsd-14.vars                   | 2 +-
 .gitlab-ci.d/cirrus/macos-14.vars                     | 2 +-
 scripts/ci/setup/debian/debian-13-ppc64le.yaml        | 1 +
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml      | 1 +
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml        | 1 +
 tests/docker/dockerfiles/alpine.docker                | 1 +
 tests/docker/dockerfiles/centos9.docker               | 1 +
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-i686-cross.docker     | 1 +
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 +
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 +
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 +
 tests/docker/dockerfiles/debian-riscv64-cross.docker  | 1 +
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 +
 tests/docker/dockerfiles/debian.docker                | 1 +
 tests/docker/dockerfiles/fedora-rust-nightly.docker   | 1 +
 tests/docker/dockerfiles/fedora-win64-cross.docker    | 1 +
 tests/docker/dockerfiles/fedora.docker                | 1 +
 tests/docker/dockerfiles/opensuse-leap.docker         | 1 +
 tests/docker/dockerfiles/ubuntu2204.docker            | 1 +
 tests/lcitool/projects/qemu.yml                       | 1 +
 tests/vm/generated/freebsd.json                       | 1 +
 24 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/cirrus/freebsd-14.vars b/.gitlab-ci.d/cirrus/freebsd-14.vars
index 19ca0d36638..6477440ef30 100644
--- a/.gitlab-ci.d/cirrus/freebsd-14.vars
+++ b/.gitlab-ci.d/cirrus/freebsd-14.vars
@@ -11,6 +11,6 @@ MAKE='/usr/local/bin/gmake'
 NINJA='/usr/local/bin/ninja'
 PACKAGING_COMMAND='pkg'
 PIP3='/usr/local/bin/pip'
-PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache4 cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-sphinx py311-sphinx_rtd_theme py311-tomli python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 vulkan-tools xorriso zstd'
+PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache4 cmocka coreutils ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-sphinx py311-sphinx_rtd_theme py311-tomli python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 vulkan-tools xorriso zstd'
 PYPI_PKGS=''
 PYTHON='/usr/local/bin/python3'
diff --git a/.gitlab-ci.d/cirrus/macos-14.vars b/.gitlab-ci.d/cirrus/macos-14.vars
index b039465f56f..4701c388e14 100644
--- a/.gitlab-ci.d/cirrus/macos-14.vars
+++ b/.gitlab-ci.d/cirrus/macos-14.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 vulkan-tools xorriso zlib zstd'
+PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka coreutils ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 vulkan-tools xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/scripts/ci/setup/debian/debian-13-ppc64le.yaml b/scripts/ci/setup/debian/debian-13-ppc64le.yaml
index e29c9c18403..25d96cea460 100644
--- a/scripts/ci/setup/debian/debian-13-ppc64le.yaml
+++ b/scripts/ci/setup/debian/debian-13-ppc64le.yaml
@@ -14,6 +14,7 @@ packages:
   - ca-certificates
   - ccache
   - clang
+  - coreutils
   - dbus
   - debianutils
   - diffutils
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
index d303411391f..6a72eabca9e 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
@@ -14,6 +14,7 @@ packages:
   - ca-certificates
   - ccache
   - clang
+  - coreutils
   - dbus
   - debianutils
   - diffutils
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
index 4ee8630cc43..6001da12504 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
@@ -14,6 +14,7 @@ packages:
   - ca-certificates
   - ccache
   - clang
+  - coreutils
   - dbus
   - debianutils
   - diffutils
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 1da375c9158..03dd6851f60 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -22,6 +22,7 @@ RUN apk update && \
         ceph-dev \
         clang \
         cmocka-dev \
+        coreutils \
         ctags \
         curl-dev \
         cyrus-sasl-dev \
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index ff3e8069b45..670e22be5ad 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -26,6 +26,7 @@ RUN dnf distro-sync -y && \
         ccache \
         clang \
         compiler-rt \
+        coreutils-single \
         ctags \
         cyrus-sasl-devel \
         daxctl-devel \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index c38ab8247d5..c386b658b04 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 2f62da0f5eb..9d83ab7a32e 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 62e297f5d12..c2077ec7a2c 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index eb9a915d492..db9f04ee93d 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 42e8444d153..7758afd80aa 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 1ab197b144d..cba7f43870f 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 85d2c0ffdc2..24f946d1441 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 4f01eecf416..f476cf65eaa 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 2a3046e7859..a60b4ab01d1 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index c1817f162f6..6c6ab0256ea 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -20,6 +20,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       ca-certificates \
                       ccache \
                       clang \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index e4233b53cbe..8e3b3a9fd90 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -33,6 +33,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                ccache \
                clang \
                compiler-rt \
+               coreutils \
                ctags \
                cyrus-sasl-devel \
                daxctl-devel \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 1da425768fc..4f743c00434 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -26,6 +26,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                ca-certificates \
                ccache \
                compiler-rt \
+               coreutils \
                ctags \
                dbus-daemon \
                diffutils \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 632259378c9..9278d797693 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -33,6 +33,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                ccache \
                clang \
                compiler-rt \
+               coreutils \
                ctags \
                cyrus-sasl-devel \
                daxctl-devel \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index def0ca9db46..a041d439768 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -20,6 +20,7 @@ RUN zypper update -y && \
            ccache \
            clang \
            clang-devel \
+           coreutils \
            ctags \
            cyrus-sasl-devel \
            dbus-1 \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index c8cc6249296..23b33d6ad44 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       ca-certificates \
                       ccache \
                       clang \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 82812e77365..1ee7dcf3d46 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -13,6 +13,7 @@ packages:
  - clang
  - cmocka
  - column
+ - coreutils
  - ctags
  - cyrus-sasl
  - daxctl
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index c03e1cd5863..f586827b136 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -15,6 +15,7 @@
     "capstone4",
     "ccache4",
     "cmocka",
+    "coreutils",
     "ctags",
     "curl",
     "cyrus-sasl",
-- 
2.47.3


