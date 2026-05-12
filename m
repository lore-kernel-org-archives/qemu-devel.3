Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854C5CD4F3D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuLZ-0003ax-Qc; Tue, 12 May 2026 17:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuKP-0000jp-MB; Tue, 12 May 2026 17:07:56 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuKK-0002ZD-Qr; Tue, 12 May 2026 17:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619300; bh=mJSoU6Vc8FPybMmzNTOOY7//BbBd1Ejdi/+OtuOoAks=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kZzRfE8JjAWkVZVbTWntzJNwypNSiT0KyVW+R8vItV06mWyqofyX3b2BkkfZjau36
 8kQDKRg7UzxkIBV3SfZEfKF6thnrBNrfgR6KWKZ4K32xOcj5Edy2aVWhJZ+8EYjXsL
 xkV/fTk4HvRBex/Mf6KZKHuZ1zKc+SEgkQ9LRHZOcn98NL9Ggl46QzCBwY/q5h5Bpk
 Q1POh4CFmuMVDVILX7cQbwDBz/yMWDl1qykFoEt9FXefgSx5xyXEQbQR9ljpyTDnRd
 luadpYHx8Irk3FTHVTC/n56asV4pVdJW9OA9ISmoTR8Lxn3hA8sI9lshwLT0uzNyxj
 m62YsJl+99FBg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EAF3F1AA34E;
 Tue, 12 May 2026 23:55:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0200C3ABCBF;
 Tue, 12 May 2026 23:55:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 018/117] rust: suggest passing --locked to "cargo
 install"
Date: Tue, 12 May 2026 23:53:20 +0300
Message-ID: <20260512205503.361097-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

Without the option, cargo will try using the latest version of the
dependencies of bindgen-cli. While it will obviously respect the
constraints in Cargo.toml, old versions of Cargo do not have
version-constrained resolution and will choke on dependencies
that need Rust 2024.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 6257754bb9b00b52018951096a9fba28b98a5b0d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index e95784cdb5..242f1d8820 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -114,7 +114,7 @@ Rust build dependencies
   bindgen tool, which is too big to package and distribute.  The minimum
   supported version of bindgen is 0.60.x.  For distributions that do not
   include bindgen or have an older version, it is recommended to install
-  a newer version using ``cargo install bindgen-cli``.
+  a newer version using ``cargo install --locked bindgen-cli``.
 
   QEMU requires Rust 1.83.0.  This is available on all supported platforms
   except for the ``mips64el`` architecture on Debian bookworm.  For all other
diff --git a/meson.build b/meson.build
index d9293294d8..5c8fa456e9 100644
--- a/meson.build
+++ b/meson.build
@@ -110,7 +110,7 @@ if have_rust
   bindgen = find_program('bindgen', required: get_option('rust'))
   if not bindgen.found() or bindgen.version().version_compare('<0.60.0')
     if get_option('rust').enabled()
-      error('bindgen version ' + bindgen.version() + ' is unsupported. You can install a new version with "cargo install bindgen-cli"')
+      error('bindgen version ' + bindgen.version() + ' is unsupported. You can install a new version with "cargo install --locked bindgen-cli"')
     else
       if bindgen.found()
         warning('bindgen version ' + bindgen.version() + ' is unsupported, disabling Rust compilation.')
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 8e3b3a9fd9..8fe727b619 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -179,7 +179,7 @@ RUN set -eux && \
   test "$RUSTDOC" = "$(/usr/local/cargo/bin/rustup +nightly which rustdoc)" && \
   test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"
 ENV PATH=$CARGO_HOME/bin:$PATH
-RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli
+RUN /usr/local/cargo/bin/rustup run nightly cargo install --locked bindgen-cli
 RUN $CARGO --list
 # As a final step configure the user (if env is defined)
 ARG USER
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 23b33d6ad4..44e763f571 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -162,7 +162,7 @@ ENV CARGO_HOME=/usr/local/cargo
 ENV PATH=$CARGO_HOME/bin:$PATH
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends cargo
-RUN cargo install bindgen-cli
+RUN cargo install --locked bindgen-cli
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 9df607a55f..8d64708ea1 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -147,7 +147,7 @@ fedora_rustup_nightly_extras = [
     '  test "$RUSTDOC" = "$(/usr/local/cargo/bin/rustup +nightly which rustdoc)" && \\\n',
     '  test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"\n',
     'ENV PATH=$CARGO_HOME/bin:$PATH\n',
-    'RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli\n',
+    'RUN /usr/local/cargo/bin/rustup run nightly cargo install --locked bindgen-cli\n',
     'RUN $CARGO --list\n',
 ]
 
@@ -158,7 +158,7 @@ ubuntu2204_rust_extras = [
     'ENV PATH=$CARGO_HOME/bin:$PATH\n',
     "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
     "  apt install -y --no-install-recommends cargo\n",
-    'RUN cargo install bindgen-cli\n',
+    'RUN cargo install --locked bindgen-cli\n',
 ]
 
 debian_all_test_cross_compilers = [
-- 
2.47.3


