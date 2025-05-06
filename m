Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F23C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKEq-0003h6-VO; Tue, 06 May 2025 11:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEo-0003fM-VH
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEi-0001w4-U2
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDj+O8cy3hkgISiThdRH7nyZOiPD0rN+/yTnNfcclAU=;
 b=JwGnkm4ejaIuttT2P4UExu86Qs/xQ4vcgY0JGCl7OHVdRcghVT/LrO87+XADwoyGfsyQsS
 inATdZ1l/o0SG4nvpDbqOoU70SCaTeE4sSy46s1y8zEiAI4g8m6QzErSk8p4kYE+E6t0cN
 1xCnSJhwZfGhQdj+o/HGNw3GQhNqwu4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-B97Z3QJ7Miii0ipOlM7Tow-1; Tue, 06 May 2025 11:29:32 -0400
X-MC-Unique: B97Z3QJ7Miii0ipOlM7Tow-1
X-Mimecast-MFC-AGG-ID: B97Z3QJ7Miii0ipOlM7Tow_1746545371
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf327e9a2so42971625e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545371; x=1747150171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pDj+O8cy3hkgISiThdRH7nyZOiPD0rN+/yTnNfcclAU=;
 b=m5/bsA1EsXpxRIRo8Hx/sfxjh7Gx390MrpApzSB8+LqAy9CiiD2VkT3EBnhKzsJuMl
 +CUzzfDIfKBMVYaTpm/SjSQ221WJVsSliyfVwBy6T8ch0c1X2oRPTr7OjoRR7+dgVmvZ
 GDlD9PizAZ3qPjIOvpgMdF/kQxovkVUT7j8NYTJUr6CZihg5GLgKbxoqKsK2qtl8RudW
 Rg6ecNzryHIS7BFj4I94W/nrizFakdZT3rk/ThjL+x3tM+B/eHlB2HSA01CKblAwOeUB
 G7Lwn7yIUfp1UeTT+GczWr9IVIqtyIofWBTf0CNeo7/i1A+eoPV5Ebca6wOHPnX1RIBH
 O4hA==
X-Gm-Message-State: AOJu0YwUu54TgIf67E4Oy0R2FtwCN9PVHZ/d44bsLVjMRfu4bgp7DAoq
 w2s4Vh23Ma40qgtnDeYzHC2448DF08gWQI75cJVEFj7TdTFz1pjK2VYJKeAsbWFbOUW9UmaX/YD
 ItP8HfU611pzT8cLCM7HjHIymm6z7p153QfnkLIjZTy2KVrihfx04yizBqPhLn9s3rDNR+3HOz6
 dTWVOmHJQtSy4Oez8lktGWiH5V9ZoDzQ2UYLpf
X-Gm-Gg: ASbGncvLInNwE81qFSxqZ+jdYH1MHAsQSV/HB5wNwuHrOj9IzYVaBjMA48gjeadZJIT
 Q8uLM8BBwRoIeJbqvOIRiHyqKSTLKLI6DYfp11a1esxjBECCBPHLZ71IvB0fvU8RgYIwnZgKnJf
 di9cx3A3wxErnmxmv+jzqLfbf0xsVUJepbIyDj+dR8zDQKKjmACdK0ncjstOVuDINmbyyaW+d3/
 Vk/T86An/7nTrMd8uzbXkiYKNU6cN9SKJQlh+iglrY75r8kHIfbMJi9diiCgxrzTeQypeUOA8G4
 5ygF1bcLClF+0Ds=
X-Received: by 2002:a05:600c:3e05:b0:43d:1824:aadc with SMTP id
 5b1f17b1804b1-441d1012f22mr29532275e9.29.1746545370846; 
 Tue, 06 May 2025 08:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8bHNTaHSCqU7kTeuq2mnNMT1ffJqujU26xDZO3AjBEyu1fTDOCp4++O5h20TlLSU2HRp3PA==
X-Received: by 2002:a05:600c:3e05:b0:43d:1824:aadc with SMTP id
 5b1f17b1804b1-441d1012f22mr29532085e9.29.1746545370263; 
 Tue, 06 May 2025 08:29:30 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89cc7d9sm178190945e9.7.2025.05.06.08.29.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:29:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/30] lcitool: use newer Rust for Debian and Ubuntu
Date: Tue,  6 May 2025 17:28:56 +0200
Message-ID: <20250506152927.222671-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Debian, the rustc-web package provides a newer Rust compiler (1.78)
for all architectures except mips64el.

On Ubuntu, Rust versions up to 1.80 (?) are available as of this writing
for both Jammy (22.04) and Noble (24.04).  However, the path to rustc
and rustdoc must be provided by hand to the configure script using
either command line arguments or environment variables.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/build-platforms.rst                        | 11 ++++++++---
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      |  2 +-
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        |  2 +-
 tests/docker/dockerfiles/debian-amd64-cross.docker    |  2 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker    |  2 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker    |  2 +-
 tests/docker/dockerfiles/debian-i686-cross.docker     |  2 +-
 tests/docker/dockerfiles/debian-mips64el-cross.docker |  2 +-
 tests/docker/dockerfiles/debian-mipsel-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  |  2 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker    |  2 +-
 tests/docker/dockerfiles/debian.docker                |  2 +-
 tests/docker/dockerfiles/ubuntu2204.docker            |  3 ++-
 tests/lcitool/mappings.yml                            |  5 +++++
 tests/lcitool/refresh                                 |  5 +++--
 15 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index c3651871d20..8ecbd6b26f7 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -118,9 +118,14 @@ Rust build dependencies
   include bindgen or have an older version, it is recommended to install
   a newer version using ``cargo install bindgen-cli``.
 
-  Developers may want to use Cargo-based tools in the QEMU source tree;
-  this requires Cargo 1.74.0.  Note that Cargo is not required in order
-  to build QEMU.
+  QEMU requires Rust 1.77.0.  This is available on all supported platforms
+  with one exception, namely the ``mips64el`` architecture on Debian bookworm.
+  For all other architectures, Debian bookworm provides a new-enough Rust
+  compiler in the ``rustc-web`` package.
+
+  Also, on Ubuntu 22.04 or 24.04 this requires the ``rustc-1.77``
+  (or newer) package.  The path to ``rustc`` and ``rustdoc`` must be
+  provided manually to the configure script.
 
 Optional build dependencies
   Build components whose absence does not affect the ability to build QEMU
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
index dbcd2e076de..f11e9808267 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
@@ -114,7 +114,7 @@ packages:
   - python3-venv
   - python3-yaml
   - rpm2cpio
-  - rustc
+  - rustc-1.77
   - sed
   - socat
   - sparse
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
index 4b8ee3d885d..6559cb29343 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
@@ -112,7 +112,7 @@ packages:
   - python3-venv
   - python3-yaml
   - rpm2cpio
-  - rustc
+  - rustc-1.77
   - sed
   - socat
   - sparse
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 05355854285..081f3e00f7b 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -50,7 +50,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
-                      rustc \
+                      rustc-web \
                       sed \
                       socat \
                       sparse \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 6b1e4fc8279..91c555a36e9 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -50,7 +50,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
-                      rustc \
+                      rustc-web \
                       sed \
                       socat \
                       sparse \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index cf0fe63af91..f0e2efcda09 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -50,7 +50,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
-                      rustc \
+                      rustc-web \
                       sed \
                       socat \
                       sparse \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 1c84dfb9456..025beb1ce25 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -50,7 +50,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
-                      rustc \
+                      rustc-web \
                       sed \
                       socat \
                       sparse \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 257204eae48..4a941dd870e 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -50,7 +50,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
-                      rustc \
+                      rustc-web \
                       sed \
                       socat \
                       sparse \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 395c84d65bc..4d3e5d711bd 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -50,7 +50,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
-                      rustc \
+                      rustc-web \
                       sed \
                       socat \
                       sparse \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 1ae227ccded..22b4457ba99 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -50,7 +50,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
-                      rustc \
+                      rustc-web \
                       sed \
                       socat \
                       sparse \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index afa81a57ba8..13ec52c8ad0 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -50,7 +50,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
-                      rustc \
+                      rustc-web \
                       sed \
                       socat \
                       sparse \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 5b3bac43ccb..0a57c1a1d37 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -122,7 +122,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
-                      rustc \
+                      rustc-web \
                       sed \
                       socat \
                       sparse \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 88ce4ef9a9d..4a1cf2bdff3 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -121,7 +121,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
-                      rustc \
+                      rustc-1.77 \
                       sed \
                       socat \
                       sparse \
@@ -150,6 +150,7 @@ ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
 ENV NINJA "/usr/bin/ninja"
 ENV PYTHON "/usr/bin/python3"
+ENV RUSTC=/usr/bin/rustc-1.77
 ENV CARGO_HOME=/usr/local/cargo
 ENV PATH=$CARGO_HOME/bin:$PATH
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 74eb13d62b6..673baf39367 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -64,6 +64,11 @@ mappings:
   python3-wheel:
     OpenSUSELeap15: python311-pip
 
+  rust:
+    Debian12: rustc-web
+    Ubuntu2204: rustc-1.77
+    Ubuntu2404: rustc-1.77
+
 pypi_mappings:
   # Request more recent version
   meson:
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index aa551aca9be..8474ea822f4 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -141,7 +141,8 @@ fedora_rustup_nightly_extras = [
     'RUN $CARGO --list\n',
 ]
 
-ubuntu2204_bindgen_extras = [
+ubuntu2204_rust_extras = [
+    "ENV RUSTC=/usr/bin/rustc-1.77\n",
     "ENV CARGO_HOME=/usr/local/cargo\n",
     'ENV PATH=$CARGO_HOME/bin:$PATH\n',
     "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
@@ -170,7 +171,7 @@ try:
     generate_dockerfile("fedora", "fedora-40")
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
     generate_dockerfile("ubuntu2204", "ubuntu-2204",
-                        trailer="".join(ubuntu2204_bindgen_extras))
+                        trailer="".join(ubuntu2204_rust_extras))
 
     #
     # Non-fatal Rust-enabled build
-- 
2.49.0


