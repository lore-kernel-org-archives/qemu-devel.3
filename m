Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43907C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 21:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMZS5-0004tF-Sb; Tue, 03 Jun 2025 17:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZS3-0004si-7b
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZRz-00065b-O1
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748987138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qcPcMm7ucaSw4wIgb6+bVeJOkGyg2uO0pSfJzc5EtpU=;
 b=KD/EzbBBKE3dlvZ+rMTr3QtMPuhcPLYcpwsfjeycXEV0LkuChL+uQBtesNm2zRVQiYEmzq
 e14tlJDZZXxJfqFZqVSI70SVsjh+iDLdkz05AT/fR9s+0Hg6LJY2NrL+g+cHh6gs5OKyX1
 FB0hacOpZlphvNjKLRY7h1o2TaBLwc0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-7ppLYBJxPBa6B2J6OqwiNw-1; Tue, 03 Jun 2025 17:45:37 -0400
X-MC-Unique: 7ppLYBJxPBa6B2J6OqwiNw-1
X-Mimecast-MFC-AGG-ID: 7ppLYBJxPBa6B2J6OqwiNw_1748987136
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f3796779so3672370f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 14:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748987136; x=1749591936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qcPcMm7ucaSw4wIgb6+bVeJOkGyg2uO0pSfJzc5EtpU=;
 b=SHP85M8tpIcOMjb+Ty9dSYUB1WR7+dBEiookJ2hBDB2LESPTxGieiqHIXvyB8Gv9yw
 lu38auIcUEG26HdXNNZRS1FIF+xxKFSbiD42nyuD/asfl0geiryLRdcV0bJpC65a1+Q7
 bYVxoTV2LT9q7i0Dzfcs5lD0xUpUPqVMYFJgbOtPa55uLr2WqafvF4eNArcsO3+4lHh1
 V+CHHMPSJAc0FScc7c7TGZcxKLbnpbcSh2ACS7q0itSX+SfLNNqHgcoxPtX67G+/XD1w
 8esLnrpPDyEFM6IGpdqfGAyBIcZeVyZNtnETEOm3Lo3Jl3yz4NlrhK7/QljZBkjSXfWF
 x4pA==
X-Gm-Message-State: AOJu0Yy5+8DBGsmiJipz4UYaBzp/lYR8u9BcJqCQ/1TRLJF42tbbTFdO
 vOIkuRz9rCRfhVUXZk9pcHRgYXFd/D72PlSLJ7oQ5vXk7H8Xd8jgpmXJfLwo+BuYGRhJyjmFJcC
 kbTV/e0RcmmKPYINN8bNipedjFjxcloBnXnKQiPvhV3oc7iZ+bPEAB9TPE9ZGhtfSVuHJxJwGpS
 jkc0hSCgIr+DN4lpLo5E0/GaQI6gpJzWWNTBdOcotV
X-Gm-Gg: ASbGncumBHZR5mC+11Wb2YlmbU19ghsKUMxBo1fTXzyFQlbDtzP5j5lg2kkggnLjXBK
 A0Y9Bx5+sxk/XeClbZeDEkIIHpJ5AlVp35rL8x9aVHzTybjvKXxBt+uH1YIPGTDw25B7L7sl+eT
 hHVn04XfuI5ImTVGmk8KAb0lhqK4gAfC/BnMmeoCWWS1rrA0tQglbGOVtyUk0CDwr4MLhsg6lpQ
 89KcPE0C5gNTEn6nJjqMGquPDASVayfVDS+wKi9P0pioEuc/NYodP7VKZw2YdxIq1uapA+N62ZN
 qTzjhxm/yKOMbQ==
X-Received: by 2002:a05:6000:4212:b0:3a4:f7af:db9c with SMTP id
 ffacd0b85a97d-3a51d9871a2mr251273f8f.59.1748987135667; 
 Tue, 03 Jun 2025 14:45:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaQ+r01w4j3k5dJnt5NTJGiKRS50iGlI6RtUYsGx4sGxG2mKChzhW4yMArxsacTGyl5eBWfw==
X-Received: by 2002:a05:6000:4212:b0:3a4:f7af:db9c with SMTP id
 ffacd0b85a97d-3a51d9871a2mr251261f8f.59.1748987135192; 
 Tue, 03 Jun 2025 14:45:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009fd9bsm19159300f8f.82.2025.06.03.14.45.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 14:45:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/16] build, dockerfiles: add support for detecting rustdoc
Date: Tue,  3 Jun 2025 23:45:11 +0200
Message-ID: <20250603214523.131185-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603214523.131185-1-pbonzini@redhat.com>
References: <20250603214523.131185-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

rustdoc is effectively a custom version of rustc, and it is necessary to
specify it in order to run doctests from Meson.  Add the relevant configure
option and environment variables.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                           | 8 ++++++++
 meson.build                                         | 2 ++
 tests/docker/dockerfiles/fedora-rust-nightly.docker | 2 ++
 tests/docker/dockerfiles/ubuntu2204.docker          | 1 +
 tests/lcitool/refresh                               | 3 +++
 5 files changed, 16 insertions(+)

diff --git a/configure b/configure
index 74b3865e51e..2b2b3d65979 100755
--- a/configure
+++ b/configure
@@ -209,6 +209,8 @@ for opt do
   ;;
   --rustc=*) RUSTC="$optarg"
   ;;
+  --rustdoc=*) RUSTDOC="$optarg"
+  ;;
   --cpu=*) cpu="$optarg"
   ;;
   --extra-cflags=*)
@@ -323,6 +325,7 @@ pkg_config="${PKG_CONFIG-${cross_prefix}pkg-config}"
 sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
 
 rustc="${RUSTC-rustc}"
+rustdoc="${RUSTDOC-rustdoc}"
 
 check_define() {
 cat > $TMPC <<EOF
@@ -660,6 +663,8 @@ for opt do
   ;;
   --rustc=*)
   ;;
+  --rustdoc=*)
+  ;;
   --make=*)
   ;;
   --install=*)
@@ -890,6 +895,7 @@ Advanced options (experts only):
   --cxx=CXX                use C++ compiler CXX [$cxx]
   --objcc=OBJCC            use Objective-C compiler OBJCC [$objcc]
   --rustc=RUSTC            use Rust compiler RUSTC [$rustc]
+  --rustdoc=RUSTDOC        use rustdoc binary RUSTDOC [$rustdoc]
   --extra-cflags=CFLAGS    append extra C compiler flags CFLAGS
   --extra-cxxflags=CXXFLAGS append extra C++ compiler flags CXXFLAGS
   --extra-objcflags=OBJCFLAGS append extra Objective C compiler flags OBJCFLAGS
@@ -1901,8 +1907,10 @@ if test "$skip_meson" = no; then
   if test "$rust" != disabled; then
     if test "$rust_host_triple" != "$rust_target_triple"; then
       echo "rust = [$(meson_quote $rustc --target "$rust_target_triple")]" >> $cross
+      echo "rustdoc = [$(meson_quote $rustdoc --target "$rust_target_triple")]" >> $cross
     else
       echo "rust = [$(meson_quote $rustc)]" >> $cross
+      echo "rustdoc = [$(meson_quote $rustdoc)]" >> $cross
     fi
   fi
   echo "ar = [$(meson_quote $ar)]" >> $cross
diff --git a/meson.build b/meson.build
index ef994676fe9..e85b358d637 100644
--- a/meson.build
+++ b/meson.build
@@ -106,6 +106,7 @@ if have_rust
 endif
 
 if have_rust
+  rustdoc = find_program('rustdoc', required: get_option('rust'))
   bindgen = find_program('bindgen', required: get_option('rust'))
   if not bindgen.found() or bindgen.version().version_compare('<0.60.0')
     if get_option('rust').enabled()
@@ -4757,6 +4758,7 @@ if have_rust
   summary_info += {'Rust target':     config_host['RUST_TARGET_TRIPLE']}
   summary_info += {'rustc':           ' '.join(rustc.cmd_array())}
   summary_info += {'rustc version':   rustc.version()}
+  summary_info += {'rustdoc':         rustdoc}
   summary_info += {'bindgen':         bindgen.full_path()}
   summary_info += {'bindgen version': bindgen.version()}
 endif
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index fe4a6ed48d6..4a033309b38 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -156,6 +156,7 @@ ENV PYTHON "/usr/bin/python3"
 RUN dnf install -y wget
 ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo
 ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc
+ENV RUSTDOC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustdoc
 ENV CARGO=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/cargo
 RUN set -eux && \
   rustArch='x86_64-unknown-linux-gnu' && \
@@ -170,6 +171,7 @@ RUN set -eux && \
   /usr/local/cargo/bin/rustup run nightly cargo --version && \
   /usr/local/cargo/bin/rustup run nightly rustc --version && \
   test "$CARGO" = "$(/usr/local/cargo/bin/rustup +nightly which cargo)" && \
+  test "$RUSTDOC" = "$(/usr/local/cargo/bin/rustup +nightly which rustdoc)" && \
   test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"
 ENV PATH=$CARGO_HOME/bin:$PATH
 RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 4a1cf2bdff3..28a6f932430 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -151,6 +151,7 @@ ENV MAKE "/usr/bin/make"
 ENV NINJA "/usr/bin/ninja"
 ENV PYTHON "/usr/bin/python3"
 ENV RUSTC=/usr/bin/rustc-1.77
+ENV RUSTDOC=/usr/bin/rustdoc-1.77
 ENV CARGO_HOME=/usr/local/cargo
 ENV PATH=$CARGO_HOME/bin:$PATH
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 8474ea822f4..d3488b2679e 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -121,6 +121,7 @@ fedora_rustup_nightly_extras = [
     "RUN dnf install -y wget\n",
     "ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo\n",
     "ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc\n",
+    "ENV RUSTDOC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustdoc\n",
     "ENV CARGO=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/cargo\n",
     "RUN set -eux && \\\n",
     "  rustArch='x86_64-unknown-linux-gnu' && \\\n",
@@ -135,6 +136,7 @@ fedora_rustup_nightly_extras = [
     "  /usr/local/cargo/bin/rustup run nightly cargo --version && \\\n",
     "  /usr/local/cargo/bin/rustup run nightly rustc --version && \\\n",
     '  test "$CARGO" = "$(/usr/local/cargo/bin/rustup +nightly which cargo)" && \\\n',
+    '  test "$RUSTDOC" = "$(/usr/local/cargo/bin/rustup +nightly which rustdoc)" && \\\n',
     '  test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"\n',
     'ENV PATH=$CARGO_HOME/bin:$PATH\n',
     'RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli\n',
@@ -143,6 +145,7 @@ fedora_rustup_nightly_extras = [
 
 ubuntu2204_rust_extras = [
     "ENV RUSTC=/usr/bin/rustc-1.77\n",
+    "ENV RUSTDOC=/usr/bin/rustdoc-1.77\n",
     "ENV CARGO_HOME=/usr/local/cargo\n",
     'ENV PATH=$CARGO_HOME/bin:$PATH\n',
     "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
-- 
2.49.0


