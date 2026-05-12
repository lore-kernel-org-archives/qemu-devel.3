Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B81CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMu9C-0005Hf-Tc; Tue, 12 May 2026 16:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu9A-000562-6g; Tue, 12 May 2026 16:56:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu98-0003Eq-93; Tue, 12 May 2026 16:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619274; bh=hHx/6MVcdTwYFjek/vYMKEkcpRNm8c9zWAEQmvWI/Dw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oOtrSvSwKolaP7KYovb/XMLzBS0McOB+T5zzHnv4E0HHJ9tpfWNeFZ5inteF7RRJn
 gpT0w6VUIHB62rFTY9Yjz6WfpM5J9gVs6iPHOtVvEuYMpNGhEs8QMGPcz9RpZH8gpT
 em35ZiaokWz8ML7dM+b0ZxrS0nMDk7oOSbQGGvIr38LXS67/Ed4Uuc7nXO6XET41Pq
 j9+QNeK01cNpGd2IzVcBd462jrz9/OJRp6MRD49BRqauJUnKYuZC/GMP2DBm2dZmBw
 WPbKv05c3qvUbKKAxG6lfmLgeseeahJu4wnkpGexiOcYRd8OBCKYclz0nf98d26Ys6
 8L/2stK6tMx4A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8263B1AA2DE;
 Tue, 12 May 2026 23:54:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8DCEA3ABC4F;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 018/107] rust: suggest passing --locked to "cargo
 install"
Date: Tue, 12 May 2026 23:53:05 +0300
Message-ID: <20260512205437.360850-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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
index 52521552c8..42787ac0b6 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -116,7 +116,7 @@ Rust build dependencies
   bindgen tool, which is too big to package and distribute.  The minimum
   supported version of bindgen is 0.60.x.  For distributions that do not
   include bindgen or have an older version, it is recommended to install
-  a newer version using ``cargo install bindgen-cli``.
+  a newer version using ``cargo install --locked bindgen-cli``.
 
   Developers may want to use Cargo-based tools in the QEMU source tree;
   this requires Cargo 1.74.0.  Note that Cargo is not required in order
diff --git a/meson.build b/meson.build
index 8ec796d835..327c1e19f8 100644
--- a/meson.build
+++ b/meson.build
@@ -109,7 +109,7 @@ if have_rust
   bindgen = find_program('bindgen', required: get_option('rust'))
   if not bindgen.found() or bindgen.version().version_compare('<0.60.0')
     if get_option('rust').enabled()
-      error('bindgen version ' + bindgen.version() + ' is unsupported. You can install a new version with "cargo install bindgen-cli"')
+      error('bindgen version ' + bindgen.version() + ' is unsupported. You can install a new version with "cargo install --locked bindgen-cli"')
     else
       if bindgen.found()
         warning('bindgen version ' + bindgen.version() + ' is unsupported, disabling Rust compilation.')
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index fe4a6ed48d..cf16205ebf 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -172,7 +172,7 @@ RUN set -eux && \
   test "$CARGO" = "$(/usr/local/cargo/bin/rustup +nightly which cargo)" && \
   test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"
 ENV PATH=$CARGO_HOME/bin:$PATH
-RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli
+RUN /usr/local/cargo/bin/rustup run nightly cargo install --locked bindgen-cli
 RUN $CARGO --list
 # As a final step configure the user (if env is defined)
 ARG USER
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 88ce4ef9a9..ace5a4b1ef 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -154,7 +154,7 @@ ENV CARGO_HOME=/usr/local/cargo
 ENV PATH=$CARGO_HOME/bin:$PATH
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends cargo
-RUN cargo install bindgen-cli
+RUN cargo install --locked bindgen-cli
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index aa551aca9b..7f36a09450 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -137,7 +137,7 @@ fedora_rustup_nightly_extras = [
     '  test "$CARGO" = "$(/usr/local/cargo/bin/rustup +nightly which cargo)" && \\\n',
     '  test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"\n',
     'ENV PATH=$CARGO_HOME/bin:$PATH\n',
-    'RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli\n',
+    'RUN /usr/local/cargo/bin/rustup run nightly cargo install --locked bindgen-cli\n',
     'RUN $CARGO --list\n',
 ]
 
@@ -146,7 +146,7 @@ ubuntu2204_bindgen_extras = [
     'ENV PATH=$CARGO_HOME/bin:$PATH\n',
     "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
     "  apt install -y --no-install-recommends cargo\n",
-    'RUN cargo install bindgen-cli\n',
+    'RUN cargo install --locked bindgen-cli\n',
 ]
 
 def cross_build(prefix, targets):
-- 
2.47.3


