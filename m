Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6A6CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 15:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEr1l-0001Wh-HK; Fri, 31 Oct 2025 11:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEr1j-0001Vo-EZ
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:26:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEr1f-0000uf-Kj
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761924405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=04RuWmhgEhZPNHkjGGD1OovzSe5jaThhHam1mzKieug=;
 b=Qn7yQuE/9S4MQnDlQKg5QGK8BlALGSo736sSHOHQ87f07fmZvOcqM8LCDDxCTA6i3KDv11
 +6L2M2M8QpowKLEeCNihlyYnyFytKWgaWtJkPmapNL4lYnUYvQRNPvJaVgllpIEw5QWtve
 b8yblGYOSLp9/FpDNO3BnFQeUuBUcZg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-WqzJKbDnOnq10DQRJWCKcw-1; Fri, 31 Oct 2025 11:26:43 -0400
X-MC-Unique: WqzJKbDnOnq10DQRJWCKcw-1
X-Mimecast-MFC-AGG-ID: WqzJKbDnOnq10DQRJWCKcw_1761924403
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47106a388cfso18024035e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 08:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761924402; x=1762529202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=04RuWmhgEhZPNHkjGGD1OovzSe5jaThhHam1mzKieug=;
 b=Us+5uQrNmBtv/iDqCv+ROQuXH+/rq8evohEyHBEZE2CJNKW/nSJxlIi6AXpO4Kumzq
 N9MC+1Y5MOg3ZIYXHvCF9DwwqTGpZHrK+gCZji/J3/mPATN7m7orqEkBSCbM2QeCAY9i
 FTSu9tz7H//5P1hfhvEATTLpdGsDGdieF6tYoIxlA1KL9ahh4HLYlNQGagdRkVUCRHal
 7/50y6fzXma0Km8y6LMLQBVA4dQhZcZVGCqHtY23GrekqbiaBshYIUYevSCdWTarWfs1
 IXxgJ3JHshqcSRxviuXWfUzvkN6l+7HpVU84UGpJCDrgvZp9oaQzXepxWMx5qNc66JWn
 M1mQ==
X-Gm-Message-State: AOJu0YxZQKjDiQgQ/0wmWjgfSBr9aP7ef5bxUMwalpQ8vS+T2jeSkD0g
 Ujb9IX3gET8iE4PJ4X245NYPClMPhMXRP7HHJUiFNXUEyQLUno1ZpPKalkCZCRUbHewPAAX4kzt
 ce9iX7u1XYsoqLhcwr2AL3mAstkzM0PjscoTHx37y7uBIVAFhDnk67tml1VFD2hRhkx9rp9Gq6h
 sXufb2RvhpTPSc4h9I2TJgRN3GJfmADHZDJ9KGr8uA
X-Gm-Gg: ASbGnctNFINDebUGh0mQC10uZHzAiKPyMWbZn6A/8TLyqTInnqdL3p0Ivo9ToLSdk7r
 FPGIbcLY8Ws79G/9Qe7JNI7gppcgdaxOOAj2RCZ99FbyeHdLikTrc/B2skjxytaXcF8sPF+QkSV
 nsRlHkcADsOagLfYifokTIALRGibeK2A/jCYPYGMhUmI0LYd+n/wWCfQ7cgRxPagrZJhLypOIGl
 ZDrqvYBN4U+h8TfBFACj70yodUKQkXJ9F/GUEnxWbTtVg9WK3bAtg/hC8r9pr+gGg17ljMPWhog
 p6iQ42/k+vysKCyZPN8G0nj530trAM+5AaymNoRZfjJkyy8EvpQRGjcb+mZ3W2ETjuUtK7eLhHo
 s1fpUTt0GmHDF22t2y8kweJtYCKD2z0XLMHTB4fVoTsN16IK2555b7WW6vt3wJq5NCMvesl2IAt
 FUigRQ
X-Received: by 2002:a05:600c:524e:b0:475:dd8d:2f52 with SMTP id
 5b1f17b1804b1-4773089c6a2mr41277585e9.32.1761924402057; 
 Fri, 31 Oct 2025 08:26:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTetH5W0AcN5wpDJ7Jh8nSwU82xs3Ht1saY6yXNhq0YCYqZqrNgudLkNudJkQ0l+f8Z0Z3rw==
X-Received: by 2002:a05:600c:524e:b0:475:dd8d:2f52 with SMTP id
 5b1f17b1804b1-4773089c6a2mr41277115e9.32.1761924401565; 
 Fri, 31 Oct 2025 08:26:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c48daa0sm2122045e9.3.2025.10.31.08.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 08:26:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH] rust: add back to Ubuntu 22.04 jobs
Date: Fri, 31 Oct 2025 16:26:39 +0100
Message-ID: <20251031152639.294034-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Ubuntu is now including updated versions of Rust (up to 1.85) for
its LTS releases.  Adjust the CI containers and re-add --enable-rust
to the Ubuntu jobs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/build-platforms.rst                   | 10 +++++-----
 .gitlab-ci.d/buildtest.yml                       |  2 +-
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml |  2 +-
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml   |  2 +-
 tests/docker/dockerfiles/ubuntu2204.docker       |  6 +++---
 tests/lcitool/mappings.yml                       |  4 ++--
 tests/lcitool/refresh                            |  4 ++--
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index fc2743658d4..e95784cdb55 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -117,14 +117,14 @@ Rust build dependencies
   a newer version using ``cargo install bindgen-cli``.
 
   QEMU requires Rust 1.83.0.  This is available on all supported platforms
-  with two exception: Ubuntu LTS releases 22.04 and 24.04, and the
-  ``mips64el`` architecture on Debian bookworm.  For all other
+  except for the ``mips64el`` architecture on Debian bookworm.  For all other
   architectures, Debian bookworm provides a new-enough Rust compiler
   in the ``rustc-web`` package.
 
-  It is expected that in the future Ubuntu will provide updated packages
-  like the existing ``rustc-1.82`` package.  The path to ``rustc`` and
-  ``rustdoc`` will have to be provided manually to the configure script.
+  For Ubuntu 22.04 ("Jammy") and 24.04 ("Noble") updated versions of
+  Rust are available through packages such as ``rustc-1.83`` package;
+  the path to ``rustc`` and ``rustdoc`` has to be provided manually to
+  the configure script.
 
   Some distros prefer to avoid vendored crate sources, and instead use
   local sources from e.g. ``/usr/share/cargo/registry``.  QEMU includes a
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 21f6d7e96fe..44df116139b 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -39,7 +39,7 @@ build-system-ubuntu:
     - job: amd64-ubuntu2204-container
   variables:
     IMAGE: ubuntu2204
-    CONFIGURE_ARGS: --enable-docs
+    CONFIGURE_ARGS: --enable-docs --enable-rust
     TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
     MAKE_CHECK_ARGS: check-build
 
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
index ce632d97108..8c4b71b5942 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
@@ -119,7 +119,7 @@ packages:
   - python3-wheel
   - python3-yaml
   - rpm2cpio
-  - rustc-1.77
+  - rustc-1.83
   - sed
   - socat
   - sparse
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
index f45f75c9602..2758f55e5a2 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
@@ -117,7 +117,7 @@ packages:
   - python3-wheel
   - python3-yaml
   - rpm2cpio
-  - rustc-1.77
+  - rustc-1.83
   - sed
   - socat
   - sparse
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index b393db55a8c..602d4196249 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -124,7 +124,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
-                      rustc-1.77 \
+                      rustc-1.83 \
                       sed \
                       socat \
                       sparse \
@@ -155,8 +155,8 @@ ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
 ENV NINJA "/usr/bin/ninja"
 ENV PYTHON "/usr/bin/python3"
-ENV RUSTC=/usr/bin/rustc-1.77
-ENV RUSTDOC=/usr/bin/rustdoc-1.77
+ENV RUSTC=/usr/bin/rustc-1.83
+ENV RUSTDOC=/usr/bin/rustdoc-1.83
 ENV CARGO_HOME=/usr/local/cargo
 ENV PATH=$CARGO_HOME/bin:$PATH
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 8f0e95e1c56..a749cf8c515 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -70,8 +70,8 @@ mappings:
 
   rust:
     Debian12: rustc-web
-    Ubuntu2204: rustc-1.77
-    Ubuntu2404: rustc-1.77
+    Ubuntu2204: rustc-1.83
+    Ubuntu2404: rustc-1.83
 
 pypi_mappings:
   # Request more recent version
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 056cfb6e9d7..273fb534cdd 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -152,8 +152,8 @@ fedora_rustup_nightly_extras = [
 ]
 
 ubuntu2204_rust_extras = [
-    "ENV RUSTC=/usr/bin/rustc-1.77\n",
-    "ENV RUSTDOC=/usr/bin/rustdoc-1.77\n",
+    "ENV RUSTC=/usr/bin/rustc-1.83\n",
+    "ENV RUSTDOC=/usr/bin/rustdoc-1.83\n",
     "ENV CARGO_HOME=/usr/local/cargo\n",
     'ENV PATH=$CARGO_HOME/bin:$PATH\n',
     "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
-- 
2.51.1


